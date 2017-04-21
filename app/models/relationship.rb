class Relationship < ActiveRecord::Base
  belongs_to :follower, class_name: "User" #follower,followedという参照関係を定義する。この時外部キーはfollower_id(モデル作成時に定義済み)
  belongs_to :followed, class_name: "User" #class_nameを"User"と定義したことで、参照関係先をUserモデル（＝usersテーブル）にした（クラスをつけないと参照先はbelongs_toのため、followerとなる）
end
