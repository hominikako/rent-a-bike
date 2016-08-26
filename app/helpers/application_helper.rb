module ApplicationHelper
    
    def is_admin?
         return (user_signed_in? and current_user.role == 1)
    end
    
end
