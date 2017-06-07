require 'rails_helper'

describe Blog do
  # タイトルと内容とがあれば有効な状態であること be_validマッチャを使用する。
  it "is valid with title and content" do
    blog = Blog.new(title: 'Akifumi_achieve_test_RSPEC_Blog_Title', content: 'Akifumi_achieve_test_RSPEC_Blog_Content')
    expect(blog).to be_valid
  end

  #タイトルがなければ無効であること be_validマッチャを使用する。
  it "is invalid without a title" do
    blog = Blog.new
    expect(blog).not_to be_valid
  end

  #タイトルがなければ無効であること
  it "is invalid without a title" do
    blog = Blog.new
    blog.valid?
    expect(blog.errors[:title]).to include("を入力してください")
  end

end
