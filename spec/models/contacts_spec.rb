require 'rails_helper'

describe Contact do
  # 名前とメールアドレスと内容とが全てあって初めて有効な状態であること be_validマッチャを使用する。
  it "is valid with name and email and content" do
    contact = Contact.new(name: 'Akifumi_achieve_test_RSPEC_Contact_Name', email: 'akifumi.ochi@gmail.com', content: 'Akifumi_achieve_test_RSPEC_Contact_Content')
    expect(contact).to be_valid
  end

  #名前がなければ無効であること(他2つが入っていても) be_validマッチャを使用する。
  it "is invalid without a name" do
    contact = Contact.new(email: 'akifumi.ochi@gmail.com', content: 'Akifumi_achieve_test_RSPEC_Contact_Content')
    expect(contact).not_to be_valid
  end

  #メールアドレスがなければ無効であること(他2つが入っていても) be_validマッチャを使用する。
  it "is invalid without an email" do
    contact = Contact.new(name: 'Akifumi', content: 'Contact_content')
    expect(contact).not_to be_valid
  end

  #問い合わせ内容がなければ無効であること(他2つが入っていても) be_validマッチャを使用する。
  it "is invalid without a content" do
    contact = Contact.new(name: 'Akifumi', email: 'akifumi.ochi@gmail.com')
    expect(contact).not_to be_valid
  end


  #名前がなければ無効であること(他2つが入っていても) includeマッチャを使用する。
  it "is invalid without a name" do
    contact = Contact.new(email: 'akifumi.ochi@gmail.com', content: 'Akifumi_achieve_test_RSPEC_Contact_Content')
    contact.valid?
    expect(contact.errors[:name]).to include("を入力してください")
  end

  #メールアドレスがなければ無効であること(他2つが入っていても) includeマッチャを使用する。
  it "is invalid without an email" do
    contact = Contact.new(name: 'Akifumi', content: 'Contact_content')
    contact.valid?
    expect(contact.errors[:email]).to include("を入力してください")
  end

  #問い合わせ内容がなければ無効であること(他2つが入っていても) includeマッチャを使用する。
  it "is invalid without a content" do
    contact = Contact.new(name: 'Akifumi', email: 'akifumi.ochi@gmail.com')
    contact.valid?
    expect(contact.errors[:content]).to include("を入力してください")
  end

  # ("を入力してください！")…エクスクラメーションが入っているとテストに通らない。
end
