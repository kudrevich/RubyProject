class SubcategoriesController < APIBaseController
  authorize_resource except: %i[index show]


  def index
    subcategoryes = Subcategory.all.order(:id)
    if subcategoryes.blank?
      render status: :no_content
    else
      render json: subcategoryes, status: :ok
    end
  end

  def show
    subcategory = Subcategory.find(params[:id])
    if subcategory.errors.blank?
      render json: subcategory.to_json(include:{
                                          users:{except: %i[password_digest timestamps]}
                                        })
    else
      render json: subcategory.errors, status: :bad_request
    end
  end

  def update
    subcategory = Subcategory.find(params[:id])
    subcategory.update(update_subcategory_params)
    if subcategory.errors.blank?
      render json: subcategory, status: :ok
    else
      render json: subcategory.errors, status: :bad_request
    end
  end

  def create
    subcategory = Subcategory.create(create_subcategory_params)
    if subcategory.errors.blank?
      render json: subcategory, status: :ok
    else
      render json: subcategory.errors, status: :bad_request
    end
  end

  def destroy
    subcategory = Subcategory.find(params[:id])
    if subcategory.errors.blank?
      subcategory.delete
      render status: :ok
    else
      render json: subcategory.errors, status: :bad_request
    end
  end

  protected


  def default_subcategory_fields
    %i[name category_id]
  end

  def update_subcategory_params
    params.required(:subcategory).permit(
      *default_subcategory_fields
    )
  end

  def create_subcategory_params
    params.required(:subcategory).permit(
      *default_subcategory_fields
    )
  end
end
