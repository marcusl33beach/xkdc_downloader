require 'nokogiri'
require 'open-uri'

class Xkdc_downloader
  def self.delete_files()
    system('rm *.png')
  end

  def self.download_png (url)
    url = url
    doc = Nokogiri::HTML(open(url))
    doc.traverse do |el|
        [el[:src], el[:href]].grep(/\.(gif|jpg|png|pdf)$/i).map{|l| URI.join(url, l).to_s}.each do |link|
            File.open(File.basename(link),'wb'){|f| f << open(link,'rb').read}
        end
    end
    File.delete('a899e84.jpg')
    File.delete('terrible_small_logo.png')
  end
end

Xkdc_downloader.delete_files
Xkdc_downloader.download_png('http://c.xkcd.com/random/comic/')

system('imgcat *.png')