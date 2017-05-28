ActiveAdmin.register Business do


	actions :index, :new, :create, :destroy, :show, :edit, :update

	permit_params :email

	filter :email
	filter :name

	form partial: 'form'


	controller do

	  def create
	    @business = Business.create_business(params)
	    if @business and  @business.errors.empty?
	      redirect_to superadmin_business_path(@business), notice: "Business Created successfully" 
	    else
	      redirect_to new_superadmin_business_path, alert: "Please fill the form correctly!"
	      return
	    end
	  end



	  def update
	    @business = Business.find_by(id: params["id"])
	    @business.update_business(params)
	    redirect_to superadmin_business_path(@business), notice: "Business Updated successfully"
	  end
	  

	end






# Show view
	show do |business|
		attributes_table do
		  row :id
		  row :name
		  row :email
		  row :address
		  row :latitude
		  row :longitude
		  row :unconfirmed_email
		  row :image do 
		    image_tag business.picture, class: 'my-image-size'
		  end
		end

		panel "Designers under business" do
			table_for(business.designers) do 
				column("id") { |d| link_to d.id, superadmin_designer_path(d.id) }
				column :name 
				column :email
				column :unconfirmed_email
			end
		end
	
	end



# Index view
	index do
	  column("Id") do |item|
	    link_to item.id, superadmin_designer_path(item)
	  end
	  column "Picture" do |item|
  		image_tag item.picture, class: 'my-image-size'
	  end
	  column("name") do |item| 
	    item.name
	  end
	  column("Email") do |item|
	    item.email
	  end
	  column("unconfirmed_email") do |item| 
	    item.unconfirmed_email
	  end
	  column("confirmed_at") do |item| 
	    item.confirmed_at
	  end
	  
	  actions
	end

end
