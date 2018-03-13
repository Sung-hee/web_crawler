class NewsinfoController < ApplicationController
  require 'httparty'
  require 'nokogiri'
  
  def index
    @article = Array.new
    encode = URI.encode("euc-kr","삼성전자")
    url = "http://finance.naver.com/news/news_search.nhn?q=%BB%EF%BC%BA%C0%FC%C0%DA"
    edaily_html = HTTParty.get(url)
    doc = Nokogiri::HTML(edaily_html)
    
    doc.css("#contentarea_left > div.newsSchResult > dl").each do |article|
      @article << {
        title: article.css("dd.articleSubject > a")[0].text,
        # summary: article.css("dd.articleSummary")[0].text,
        press: article.css("dd.articleSummary > span.press")[0].text,
        bar: article.css("dd.articleSummary > span.bar")[0].text,
        wdate: article.css("dd.articleSummary > span.wdate")[0].text,
        url: article.css("dd.articleSubject > a")[0]['href']
      }
      
    # doc.css("#contentarea_left > ul.realtimeNewsList > li").each do |article|
    #   @article[article.css("dl > dd.articleSubject > a").text] = {
    #     :title => article.css("dl > dd.articleSubject > a").text,
    #     :summary => article.css("dl > dd.articleSummary").text,
    #     :press => article.css("dl > dd.articleSummary > span.press").text,
    #     # bar: article.css("dl > dd.articleSummary > span.bar").text,
    #     :wdate => article.css("dl > dd.articleSummary > span.wdate").text,
    #     :url => article.css("dl > dd.articleSubject > a")[0]['href']
    #   }
    # end
    
    # doc.css("#contentarea_left > ul.realtimeNewsList > li > dl > dd.articleSubject > a").each do |title|
    #   @artitcle_title << title.text
    # end
    
    # puts @article.inspect
    # puts @artitcle_title.inspect
    end
    puts @article.inspect
  end

  def crolling
    # @article = Hash.new
    
    @titles = Array.new
    @press = Array.new
    @wdate = Array.new
    @url = Array.new
      
    puts request.original_url
    
    # 차후 companycode 파라미터를 통해 여러 기업의 기사를 긁어옴
    # companycode = request.original_url.split("companycode=").last
    # puts companycode
    
    url = "http://finance.naver.com/item/news_news.nhn?code=005930"
    naver_html = HTTParty.get(url)
    doc = Nokogiri::HTML(naver_html)
    
    # 타이틀 
    doc.css("body > div > table.type5 > tbody > tr > td.title > a").each do |titles|
      @titles << titles.text
    end
    puts @titles.inspect
    
    # 정보제공 
    doc.css("body > div > table.type5 > tbody > tr > td.info").each do |press|
      @press << press.text
    end
    puts @press.inspect
    
    # 날짜 
    doc.css("body > div > table.type5 > tbody > tr > td.date").each do |wdates|
      @wdate << wdates.text
    end
    
    puts @wdate.inspect
    # url 
    doc.css("body > div > table.type5 > tbody > tr > td.title").each do |urls|
      @url << urls.css("a")[0]['href']
    end
    
    puts @url.inspect
    
    # article id
    @article_id = Array.new
    
    @url.each do |id|
      @article_id << id[31,10]
    end
    
    puts @article_id
    
    # office id
    @office_id = Array.new
    
    @url.each do |id|
      @office_id << id[52,3]
    end
    # @office_id = @url_test[31,10]
    
    puts @office_id
  end
end
