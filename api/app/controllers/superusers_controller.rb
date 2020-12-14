class SuperusersController < APIBaseController
  before_action :load_superuser, except: :create
  authorize_resource except: :create
  before_action :auth_user, except: :create

  def show
    render json: @superuser.to_json(except: [:password_digest])
  end

  def update
    @superuser.update(update_superuser_params)
    if @superuser.errors.blank?
      render status: :ok
    else
      render json: @superuser.errors, status: :bad_request
    end
  end

  def destroy
    @superuser.delete
  end


  def show_user
    user = User.find(params[:id])
    if user.errors.blank?
      render json: user, except: [:password_digest], status: :ok
    else
      render status: :bad_request
    end
  end


  protected

  def load_superuser
    @superuser = current_superuser
  end

  def default_superuser_fields
    %i[login]
  end

  def update_superuser_params
    params.required(:superuser).permit(
      *default_superuser_fields
    )
  end

  def create_superuser_params
    params.required(:superuser).permit(
      *default_superuser_fields, :password
    )
  end
end
