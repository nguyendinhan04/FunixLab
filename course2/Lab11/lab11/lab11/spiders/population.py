import scrapy


class PopulationSpider(scrapy.Spider):
    name = "population"
    allowed_domains = ["www.worldometers.info"]
    start_urls = ["https://www.worldometers.info/world-population/population-by-country/"]

    def parse(self, response):
        countries = response.xpath('//*[@id="example2"]/tbody/tr/td[2]/a')
        for country in countries:
            country_name = country.xpath(".//text()").get()
            link = country.xpath(".//@href").get()
            yield response.follow(url = link, callback= self.parse_country, meta = {"country_name" : country_name})

    def parse_country(self,response):
        country_name = response.meta["country_name"]
        years = response.xpath("/html/body/div[2]/div[3]/div/div/div[5]/table/tbody/tr")
        for item in years:
            year = item.xpath(".//td[1]/text()").get()
            population_per_year = item.xpath("td[2]/strong/text()").get()
        # year = response.xpath("/html/body/div[2]/div[3]/div/div/div[5]/table/tbody/tr/td[1]/text()").getall()
        # population_per_year = response.xpath("/html/body/div[2]/div[3]/div/div/div[5]/table/tbody/tr/td[2]/strong/text()").getall()
            yield {
                "country_name" : country_name,
                "year" : year,
                "population_per_year" : population_per_year
            }
        pass