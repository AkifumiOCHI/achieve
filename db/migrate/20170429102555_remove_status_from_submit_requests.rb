class RemoveStatusFromSubmitRequests < ActiveRecord::Migration
  def change
    remove_column :submit_requests, :status, :integer
  end
end
