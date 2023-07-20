ActiveAdmin.register Program do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :status, :video, :user_id, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :status, :video, :user_id, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  index do
    selectable_column
    id_column
    column :name
    column :status
    column :video
    column :user_id
    column :category_id
    column :created_at
    actions
  end

  filter :name
  filter :status
  filter :video
  filter :user_id
  filter :category_id
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :status
      f.input :video
      f.input :user_id
      f.input :category_id
      f.input :created_at
    end
    f.actions
  end

  # def self.ransackable_attributes(auth_object = nil)
  #   ["blob_id", "created_at", "id", "name", "record_id", "record_type"]
  # end
end
