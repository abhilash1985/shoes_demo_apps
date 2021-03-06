# Simple Flickr photo viewer
# - Brian Hogan
Shoes.setup do
  gem "net-flickr"
  gem "xml-simple"
end

require 'net/flickr'
Shoes.app :title => "Flickr",
          :height => 250 do
  
  start do
    get_images
  end
  api_key = File.open("#{ENV["HOME"]}/.flickr_api_key").read
  @flickr_service = Net::Flickr.new(api_key) 

  @photos = flow
  
  
  flow do
    button "Refresh", :width=>"100%" do
      get_images
    end
  end
  
  
  def get_images
    @photos.clear
    @flickr_service.photos.recent(:per_page => 12).each do |p|
     
      @photos.append do
        @image = image p.source_url(:thumb), :height=>100, :width=>100,
                 :margin_top => 10,
                 :margin_right=>10,
                 :margin_bottom => 10,
                 :margin_left => 10
      
        @image.click do
          display_larger_image(p)
        end
      end
      
    end
  end
  
  def display_larger_image(photo)
    
  window :width=>600 do
    title photo.title, :align => "center"
    i = image(photo.source_url, :width=>590, :margin => 4)
    i.click do
      close
    end
    para photo.description, :align => "center"
        
      
    end
  end

end