class Task < ActiveRecord::Base
  belongs_to :user #scaffold作成時に、user:referencesとしたことで自動的に生成される
  belongs_to :charge, class_name: 'User', foreign_key: 'charge_id' #この行を追記した
  has_many :submit_requests, dependent: :destroy

  validates :title, presence: true #タイトルが空ではならないというヴァリデーション追記
  enum status: {未着手:0, 対応中:1, 完了:2}
end
