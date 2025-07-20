import scrapy
import re
from no_accent_vietnamese import no_accent_vietnamese


class CasesSpider(scrapy.Spider):
    name = "cases"
    allowed_domains = ["web.archive.org"]
    start_urls = ["https://web.archive.org/web/20210907023426/https://ncov.moh.gov.vn/vi/web/guest/dong-thoi-gian"]
    iter_num = 0

    def parse(self, response):
        case_datetimes = response.xpath('.//*[@id="portlet_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_nf7Qy5mlPXqs"]/div/div[2]/div/div[1]/div/div/div/div/ul')
        # for loop duyet qua tung ngay
        for case_datetime in case_datetimes:
            # lay thoi gian (vd: 18:20 05/09/2021)
            dt = case_datetime.xpath('.//li/div[@class = "timeline"]/div[@class = "timeline-detail"]/div[@class = "timeline-head"]/h3/text()').get()
            
            # lay noi dung trong ngay
            content = no_accent_vietnamese(case_datetime.xpath('.//li/div[@class = "timeline"]/div[@class = "timeline-detail"]/div[@class = "timeline-content"]/p[2]/text()').get()).strip()

            if content:
                # su dung regex de lay duoc so ca mac trong ngay
                case_number = re.findall("THONG BAO VE (\S+) CA MAC MOI",content)[0]
                
            if case_number and dt:
                yield {
                    "time" : dt,
                    "new_case" : int(case_number.replace('.',''))
                }

        # Neu van con trang tiep theo, chuyen den trang tiep theo va tiep tuc crawl
        next_page_url = response.xpath('.//*[@id="portlet_com_liferay_asset_publisher_web_portlet_AssetPublisherPortlet_INSTANCE_nf7Qy5mlPXqs"]/div/div[2]/div/div[2]/ul/li[2]/a/@href').get()

        # để demo chỉ lấy 3 trang kế tiếp nếu muốn lấy tất cả hãy bỏ điểu kiện self.iter_num < 3

        # if next_page_url:
        #     yield scrapy.Request(url = next_page_url, callback= self.parse)

        if next_page_url and self.iter_num < 3:
            self.iter_num += 1
            yield scrapy.Request(url = next_page_url, callback= self.parse)