class Users::RegistrationsController < Devise::RegistrationsController

  def create
    @user = build_resource # Needed for Merit
    super
  end

  def update
    @user = resource # Needed for Merit
    super
  end


  private

  def account_update_params
    if current_user.provider == "facebook"
      params.require(:user).permit(:username)
    else
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :current_password)
    end

  end

  protected

  def update_resource(resource, params)
    if current_user.provider == "facebook"
      resource.update_without_password(params)
    else
      super
    end

  end



end