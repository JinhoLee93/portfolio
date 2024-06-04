from bs4 import BeautifulSoup
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import requests
import time 

class Article:
    def __init__(self, title, thumbnail_url, article_url):
        self.title = title
        self.thumbnail_url = thumbnail_url
        self.article_url = article_url

def get_articles_from_big_kinds():
    categories = ['//*[@id="cate-list"]/li[3]', 
                  '//*[@id="cate-list"]/li[4]', 
                  '//*[@id="cate-list"]/li[5]', 
                  '//*[@id="cate-list"]/li[6]', 
                  '//*[@id="cate-list"]/li[7]', 
                  '//*[@id="cate-list"]/li[8]', 
                  '//*[@id="cate-list"]/li[9]']

    url = 'https://www.bigkinds.or.kr/v2/news/recentNews.do'

    driver = webdriver.Chrome()
    driver.get(url)

    articles = []
    for xpath in categories:
        time.sleep(2)
        category_button = WebDriverWait(driver, 5).until(EC.element_to_be_clickable((By.XPATH, f'{xpath}')))
        category_button.click()
        for t in range(50):
            soup = BeautifulSoup(driver.page_source, 'html.parser')
            preprocessed_articles = soup.find_all('div', class_='news-item')
            for article in preprocessed_articles:
                try:
                    article_title = article.find('strong', class_='title').text
                    thumbnail_url = article.find('a', class_='thumb news-detail')['style'].split('\'')[1]
                    article_url = article.find('a', class_='provider', href=True)['href']
                    articles.append(Article(title=article_title, thumbnail_url=thumbnail_url, article_url=article_url))
                except:
                    pass
            time.sleep(2)
            pagination_button = WebDriverWait(driver, 5).until(EC.element_to_be_clickable((By.XPATH, '//*[@id="news-results-pagination"]/div/div[4]/a')))
            pagination_button.click()
        driver.find_element(By.TAG_NAME, 'body').send_keys(Keys.CONTROL + Keys.HOME)

    return articles

print(len(get_articles_from_big_kinds()))