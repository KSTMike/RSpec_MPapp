require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
  end
  
  it "is valid with a first name, last name and email, and password" do
    user = User.new(
      first_name: "Aaron",
      last_name:  "Sumner",
      email:      "tester@example.com",
      password:   "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end

  # 名がなければ無効な状態であること
  it "is invlid with a first name" do
    user= FactoryBot.build(:user, first_name: nil)
    user.valid?

    expect(user.errors[:first_name]).to
    include("can't be blank")
  end

  # 姓がなければ無効な状態であること
  it "is invalid with a last name" do
    user = FactoryBot.build(:user, last_name: nil)
    user.valid?

    expect(user.errors[:last_name]).to
    include("can't be blank")
  end

  # メールアドレスが無ければ無効な状態であること
  it "is invalid with an email address" do
    user = FactoryBot.build(:user, eamil: nil)
    user.valid?

    expect(user.errors[:email]).to
    include("can't be blank")
  end

  # ユーザーのフルネームを文字列として返す事
  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: "John",
                                   last_name: "Doe")

    expect(user.name).to eq "John Doe"
  end

    it "is invalid with a duplicate email address" do
      FactoryBot.create(:user, email: "aaron@example.com")
      FactoryBot.build(:user, email: "aaron@example.com")
      usr.valid?

    expect(user.errors.[:email]).to 
    include("has already been taken")
    end

  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  it "returns a user's full name as a string" do
    user = FactoryBot.build(:user, first_name: "John", last_name: "Doe")
    expect(user.name).to eq "John Doe"
  end

  it "sends a welcome email on account creation" do
    allow(UserMailer).to \
      receive_message_chain(:welcome_email, :deliver_later)
    user = FactoryBot.create(:user)
    expect(UserMailer).to have_received(:welcome_email).with(user)
  end

  it "performs geocoding", vcr: true do
    user = FactoryBot.create(:user, last_sign_in_ip: "161.185.207.20")
    expect {
      user.geocode
    }.to change(user, :location).
      from(nil).
      to("Brooklyn, New York, US")
  end
end
