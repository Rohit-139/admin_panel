ActiveAdmin.register Customer do
  menu parent: 'users', priority: 1
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :email, :password, :type, :country_name, :state, :city, :dob
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password, :type, :country_name, :state, :city, :dob]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
  index do
    id_column
    column :name
    column :email
    column :type, :label => 'Role'
    column :country_name
    column 'DOB', &:dob
    # add column name for actions
    actions name: "Actions"
  end
end
