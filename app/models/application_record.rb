class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  
  private
  
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
end
