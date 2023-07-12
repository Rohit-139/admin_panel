class ProgramSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :category, :video

  def video
    object.video.url
  end
  def category
    object.category.name
  end
end
