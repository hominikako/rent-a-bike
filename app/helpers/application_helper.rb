module ApplicationHelper
    
    # check if user is admin
    def is_admin?
         return (user_signed_in? and current_user.role == 1)
    end
    
    # returns the style for a row, depending on the rental period.
    # if the rental has passed -> return warning
    # if the rental has not arrived yet -> return success
    # if the rental is happening now  -> return danger
    def status_rental_row_class(start_date, end_date)
        current_time = Time.now.to_date
        return "danger" if  current_time >= start_date and current_time <= end_date 
        return "success" if current_time < start_date
        return "warning" if end_date < current_time
        return ""
     end
end
