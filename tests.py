import requests
from bs4 import BeautifulSoup


def test_headings_exist():
    url = "https://www.reuters.com/technology/disrupted"
    response = requests.get(url)
    soup = BeautifulSoup(response.content, "html.parser")
    headings = soup.find_all(
        "a",
        {"data-testid": "Heading", "class": "text__text__1FZLe text__dark-grey__3Ml43 text__medium__1kbOh text__heading_5_and_half__3YluN heading__base__2T28j heading_5_half title__title__1Sa2a title"},
    )

    assert len(headings) > 0, "No headings found on the page"


def test_headings_text_not_empty():
    url = "https://www.reuters.com/technology/disrupted"
    response = requests.get(url)
    soup = BeautifulSoup(response.content, "html.parser")
    headings = soup.find_all(
        "a",
        {"data-testid": "Heading", "class": "text__text__1FZLe text__dark-grey__3Ml43 text__medium__1kbOh text__heading_5_and_half__3YluN heading__base__2T28j heading_5_half title__title__1Sa2a title"},
    )

    for heading in headings:
        title = heading.text.strip()
        assert title != "", "Heading text should not be empty"
