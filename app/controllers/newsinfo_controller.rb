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
    
  end
end
