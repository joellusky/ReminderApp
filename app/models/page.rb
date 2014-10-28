class Page < ActiveRecord::Base
    # add callbacks to write changes to git like this:
  after_create  :create_page
  after_update  :update_page
  after_destroy :delete_page
end

