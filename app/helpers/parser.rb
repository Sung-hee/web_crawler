# module Parser
#   class Stocknews
#       def edaily
#         url = http://edaily.co.kr/stock/E01_00.html
#         edaily_html = HTTParty.get(url)
#         doc = Nokogiri::HTML(edaily_html)
        
#         news = Hash.new
#         news_title = Array.new
        
#         doc.css("div.arti_data > ul").each do |article|
#           news[article.css("li > div.data_txt > strong").text] = {
#             :title => article.css("li > div.data_txt").text,
#             :url => article.css("li > a")[0]['href']
#           }
#         end
        
#         doc.css("div.arti_data > ul > li > strong").each do |title|
#           news_title << title.text
#         end
        
#         news_data = news_info.sample
        
#         title = news[news_data][:title]
#         url = news[news_data][:url]
        
#         puts news.inspect
        
#         return [title, url]
#       end
#   end
# end