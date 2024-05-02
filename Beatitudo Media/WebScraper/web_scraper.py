from bs4 import BeautifulSoup
import requests

categories = {"News" : [{"Politics" : "https://news.naver.com/section/100"},
                        {"Economy" : "https://news.naver.com/section/101"},
                        {"Society" : "https://news.naver.com/section/102"},
                        {"Lifestyle" : "https://news.naver.com/section/103"},
                        {"Technology" : "https://news.naver.com/section/104"},
                        {"World" : "https://news.naver.com/section/105"}]}

url = "https://news.naver.com/section/100"

page = requests.get(url)

soup = BeautifulSoup(page.text, 'html.parser')

article_titles = soup.find_all("div", class_ = "section_latest")

preprocessed_articile_titles = []
for title in article_titles:
    preprocessed_articile_titles = title.find_all("strong", class_ = "sa_text_strong")

processed_article_titles = [title.text for title in preprocessed_articile_titles]
print(processed_article_titles)