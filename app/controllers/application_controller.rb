class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    # before_action :authenticate_customer!, except: [:top, :about ]
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      top_path
    end
  end

  def after_sign_out_path_for(resource)
       flash[:notice] = "Signed out successfully."
    case resource
     when :admin   # ログアウト時はシンボルが返ってくる
      new_admin_session_path
    end
  end
    
     
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
