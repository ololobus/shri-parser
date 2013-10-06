class Parser
  
  require 'nokogiri'
  require 'open-uri'
  
  URL = "http://tech.yandex.ru"
  PATH = "/education/shri/msk-2013/"
  
  def self.perform
    doc = Nokogiri::HTML(open(URL + PATH))
    
    # lectors
    doc.css(".users-list__users a.username").each do |u|
      lector = Lector.new
      lector.native_id = u.attr("href").split("/").last
      udoc = Nokogiri::HTML(open(URL + u.attr("href")))
      lector.name = udoc.css(".team-member__descr .title_type_h2").children.first.content
      lector.photo_url = udoc.css(".team-member__avatar.image").first.attr("src")
      about = udoc.css(".team-member__descr .static-text").children.first
      if about
        lector.about = about.content
      end
      lector.save
      udoc.css(".team-member__descr .team-member__treatises a").each do |ll|
        lec = LectorsLecture.new
        lec.lector = lector
        lec.url = ll.attr("href")
        lec.name = ll.children.first.content
        lec.save
      end
    end
    
    # lectures
    doc.css(".hall-schedule .b-link").each do |l|
      lecture = Lecture.new
      lecture.native_id = l.attr("href").split("/").last
      ldoc = Nokogiri::HTML(open(URL + "/education/shri/msk-2013/" + l.attr("href")))
      lecture.name = ldoc.css(".talk__info .title.title_type_h1").children.first.content
      video = ldoc.css(".talk__videos iframe.player").first
      if video
        lecture.video_url = video.attr("src")
      end
      slides = ldoc.css(".talk__slides iframe.player").first
      if slides
        lecture.slides_url = slides.attr("src")
      end
      speaker_native_id = ldoc.css("a.username.talk__speaker").first.attr("href").split("/").last.to_i
      lector = Lector.where(:native_id => speaker_native_id).first
      if lector
        lecture.lector = lector
      end
      lecture.save
    end
    
  end
  
  def self.clean
    Lector.destroy_all
    Lecture.destroy_all
    LectorsLecture.destroy_all
  end
  
end