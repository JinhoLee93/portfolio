from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time
import asyncio

class ScrapedArticle:
    def __init__(self, title, thumbnail_url, article_url, article_body, date):
        self.title = title
        self.thumbnail_url = thumbnail_url
        self.article_url = article_url
        self.article_body = article_body
        self.date = date

def get_articles_from_big_kinds():
    print('Starting Web Scraper')

    url = 'https://www.bigkinds.or.kr/v2/news/recentNews.do'

    driver = webdriver.Chrome()
    driver.get(url)

    articles = []
    title_set = set()
    time.sleep(2)
    while len(articles) < 10000:
        soup = BeautifulSoup(driver.page_source, 'html.parser')
        preprocessed_articles = soup.find_all('div', class_='news-item')
        for article in preprocessed_articles:
            try:
                article_title = article.find('strong', class_='title').text
                thumbnail_url = article.find('a', class_='thumb news-detail')['style'].split('\'')[1]
                if 'noImg' in thumbnail_url:
                    continue
                article_url = article.find('a', class_='provider', href=True)['href']
                article_body = article.find('p', class_='text').text
                article_date = time.strftime('%Y-%m-%d')
                if article_title not in title_set:
                    title_set.add(article_title)
                    articles.append(ScrapedArticle(title=article_title, thumbnail_url=thumbnail_url, article_url=article_url, article_body=article_body, date=article_date))
                    print(len(articles))
            except:
                pass
        time.sleep(2)
        pagination_button = WebDriverWait(driver, 5).until(EC.element_to_be_clickable((By.XPATH, '//*[@id="news-results-pagination"]/div/div[4]/a')))
        pagination_button.click()

    print('Ending Web Scraper')

    return articles