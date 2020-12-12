class OrdersController < APIBaseController
  authorize_resource
  before_action :auth_user, except: :create

  def index
    orders = current_user.orders.order(:id)
    if orders.blank?
      render status: :no_content
    else
      render json: orders, status: :ok
    end
  end

  def show
    order = Order.find_by_id(params[:id])
    if order.errors.blank?
      render json: order
    else
      render json: order.errors, status: :bad_request
    end
  end

  def update
    order = Order.find_by_id(params[:id])
    order.update(update_order_params)
    if order.errors.blank?
      render json: order, status: :ok
    else
      render json: order.errors, status: :bad_request
    end
  end

  def create
    order = Order.new(create_order_params)
    order.user = current_user
    order.subcategory = current_user.subcategory
    order.save
    if order.errors.blank?
      render json: order, status: :ok
    else
      render json: order.errors, status: :bad_request
    end
  end

  def destroy
    order = Order.find(params[:id])
    if order.errors.blank?
      order.delete
      render json: order, status: :ok
    else
      render json: order.errors, status: :bad_request
    end
  end

  def start_execute
    order = Order.find(params[:id])
    if order.user = current_user
      render json: {you: "dont execute yourself order"}, status: :bad_request
      return
    end
    if order.executor == nil
      order.executor = current_user
      order.save
      if order.errors.blank?
        render json: order, status: :ok
      else
        render json: order.errors, status: :bad_request
      end
    else
      render json: {error: "order has already been executing"}, status: 403
    end
  end

  def confirm
    order = Order.find(params[:id])
    executor = User.find(order.executor_id)
    executor.rank += rand(0..10)
    executor.save
    order.delete
    render status: :ok
  end

  protected

  def default_order_fields
    %i[description city price date picture ]
  end

  def update_order_params
    params.required(:order).permit(
      *default_order_fields
    )
  end

  def create_order_params
    params.required(:order).permit(
      *default_order_fields
    )
  end
end
