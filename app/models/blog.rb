class Blog < ActiveRecord::Base
    validates :title, presence: true
    belongs_to :user
    has_many :comments, dependent: :destroy #Commentモデルのアソシエーションを設定　dependent destroyで削除の際一緒に削除
end
