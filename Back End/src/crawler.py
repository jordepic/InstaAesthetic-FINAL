import urllib.request
import json
import requests

def findUrls(username):
    imageURLS = []
    likes = []
    url = "https://www.instagram.com/" + username + "/"
    first = urllib.request.urlopen(url)
    html = first.read()
    startindex = 0
    endindex = 0
    html = html.decode("utf-8")
    while(html.find('display_url') != -1):
            startindex = html.find('display_url') + 14
            endindex = html.find('edge_liked_by') - 3
            imageURLS.append(html[startindex:endindex])
            startLikeIndex = html.find("edge_liked_by") + 24
            endLikeIndex = html.find("edge_media_preview_like") - 3
            likes.append(html[startLikeIndex:endLikeIndex])
            html = html[endindex + 39:]
    return imageURLS, likes

def detect_properties_uri(uri):
    """Detects image properties in the file located in Google Cloud Storage or
    on the Web."""
    data =json.dumps({"requests": [{"image": {"source": {"imageUri": uri}},"features": [{"type": "IMAGE_PROPERTIES"}]}]})
    r = requests.post(url = "https://vision.googleapis.com/v1/images:annotate?key=AIzaSyDvcjmCq0GYlYRGNWE6iD4O9UCeuxZ0cMk", data = data)
    props = r.json()
    colordict = []
    for color in props["responses"][0]["imagePropertiesAnnotation"]["dominantColors"]["colors"]:
        colordict.append({
            "rgb": [color["color"]["red"], color["color"]["green"], color["color"]["blue"]],
            "score": color["score"],
            "pixel_fraction": color["pixelFraction"]
        })
    return colordict


def return_reults(accountName):
    try:
        imageURLS, likes = findUrls(accountName)
        results = []
        for i in range(min(len(imageURLS), 6)):
            results.append({
                "url": imageURLS[i],
                "liked_by": int(likes[i]),
                "colors": detect_properties_uri(imageURLS[i])
        })
        return results
    except:
        return []
