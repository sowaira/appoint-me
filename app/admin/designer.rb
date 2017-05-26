ActiveAdmin.register Designer do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#

	actions :index, :new, :create, :destroy, :show

	permit_params :email

	filter :email
	filter :name

	form partial: 'form'

	controller do

	  def create
	    @designer = Designer.invite_designer(params)
	    if @designer and  @designer.errors.empty?
	      redirect_to superadmin_designer_path(@designer)
	    else
	      redirect_to new_superadmin_designer_path
	      return
	    end
	  end
	end


	index do
	  column("Id") do |item|
	    link_to item.id, superadmin_designer_path(item)
	  end
	  column("Email") do |item|
	    item.email
	  end
	  column("name") do |item| 
	    item.name
	  end
	  column("unconfirmed_email") do |item| 
	    item.unconfirmed_email
	  end
	  column("confirmed_at") do |item| 
	    item.confirmed_at
	  end
	  column("phone") do |item| 
	    item.phone
	  end
	  
	  actions
	end

end
