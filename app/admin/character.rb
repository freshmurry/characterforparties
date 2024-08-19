ActiveAdmin.register Character do
  # Permit params for Character and nested Photos
  permit_params :user_id, :character_type, :time_limit, :listing_name, :description, :address, :price, :active, photos_attributes: [:id, :image, :_destroy]

  # Form for creating/updating Character
  form do |f|
    f.inputs do
      f.input :user, as: :select, collection: User.all.collect { |user| [user.email, user.id] }
      f.input :character_type, as: :select, collection: ['Movie Character', 'Cartoon Character', 'Impersonator']
      f.input :time_limit, as: :select, collection: ['1 hr.', '2 hrs.', '3  hrs.']
      f.input :listing_name
      f.input :description
      f.input :address
      f.input :price, as: :number
      f.input :active, as: :boolean
      
      f.inputs "Images" do
        f.has_many :photos, allow_destroy: true, new_record: true do |pf|
          pf.input :image, as: :file
        end
      end
    end
    f.actions
  end

  # Show view for Character
  show do
    attributes_table do
      row :user
      row :character_type
      row :time_limit
      row :listing_name
      row :description
      row :address
      row :price
      row :active

      row "Images" do |character|
        if character.photos.any?
          character.photos.each do |photo|
            div do
              image_tag photo.image.url(:thumb), size: "200x200" if photo.image.present?
            end
          end
        else
          div "No images available."
        end
      end
    end
    active_admin_comments
  end
end