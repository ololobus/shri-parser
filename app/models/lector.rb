class Lector < ActiveRecord::Base
  has_many :lectures
  has_many :lectors_lectures
  
  def self.all_with_lectures
    self.all.map do |l|
      {
        :id => l.id,
        :native_id => l.native_id,
        :name => l.name,
        :about => l.about,
        :photo_url => l.photo_url,
        :all_lectures => l.lectors_lectures.map{ |ll| ll.serializable_hash(:only => [:id, :lector_id, :name, :url]) }
      }
    end
  end
  
end
