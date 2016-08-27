require 'application_helper'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
    def allow_if_admin
      unless is_admin?
       flash[:danger] = "Administration permissions needed to access to this page"
       redirect_to new_user_session_path
      end
    end
  # Determines if the users is logged in and is admin
      def is_admin? 
        return (user_signed_in? and current_user.role == 1)
      end
end
