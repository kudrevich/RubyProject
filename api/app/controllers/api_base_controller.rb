class APIBaseController < ActionController::API
  include Knock::Authenticable

  def current_ability
    @current_ability ||= if current_superuser.present?
                           Ability.new(current_superuser)
                         else
                           Ability.new(current_user)
                         end
  end

  protected

  def auth_user
    if current_superuser.present?
      authenticate_superuser
    else
      authenticate_user
    end
  end
end
