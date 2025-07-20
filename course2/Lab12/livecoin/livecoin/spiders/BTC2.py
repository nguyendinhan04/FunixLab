import scrapy
from scrapy_splash import SplashRequest
import time

class Btc2Spider(scrapy.Spider):
    name = "BTC2"
    allowed_domains = ["web.archive.org"]
    start_urls = ["https://web.archive.org/web/20200116052415/https://www.livecoin.net/en/"]

    def parse(self,response):
        number_tabs = len(response.xpath("//div[@class = 'filterPanel___2zFYQ']/div"))
        for number in range(0,number_tabs):
            script = f'''
            function main(splash, args)
                assert(splash:go(args.url))  
                assert(splash:wait(0.5))  

                --Select the element and perform a mouse click
                tab = splash:select_all(".filterPanel___2zFYQ > .filterPanelItem___2z5Gb")
                assert(tab[{number +  1}]:mouse_click()) 
                assert(splash:wait(0.5))  

                return {{
                    png = splash:html(), 
                }}
            end
            '''
            yield SplashRequest(url = "https://web.archive.org/web/20200116052415/https://www.livecoin.net/en/",callback=self.parse_each_tab, endpoint="execute",args= {'lua_source' : script},meta={'tab_number': number},dont_filter=True)
    
    def parse_each_tab(self,response):
        records = response.xpath("//div[@class = 'tableGrid___28dQz']/div")
        for record in records:
            pair = record.xpath(".//div[1]/div/text()").get()
            volume = record.xpath(".//div[2]/span/text()").get()
            yield {
                "tab_nubmer": response.meta.get("tab_number"),
                "Pair" : pair,
                "volume(24h)" : volume
            }
            pass
