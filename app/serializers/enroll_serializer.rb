class EnrollSerializer < ActiveModel::Serializer
  attributes :id, :name, :level, :user_name

  def user_name
    object.user.name
  end
end
