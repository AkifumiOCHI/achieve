class AddStatusToSubmitRequests < ActiveRecord::Migration
  def change
    add_column :submit_requests, :status, :string, default: "1"
  end
end
