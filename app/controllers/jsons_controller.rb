class JsonsController < ApplicationController
  
  def generate_json
    render :json => { :lectors => Lector.all_with_lectures, :lectures => Lecture.all.map{ |l| l.serializable_hash(:only => [:id, :lector_id, :native_id, :name, :video_url, :slides_url ])} }
  end
  
end
