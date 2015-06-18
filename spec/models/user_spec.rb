RSpec.describe User, type: :model do
  describe "validations" do
    it { should have_many :posts }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_least(3) }
    it { should validate_presence_of(:username) }
    it { should validate_length_of(:username).is_at_least(3) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_confirmation_of(:password) }
    it { should validate_presence_of(:password).on(:create) }
    it { should_not validate_presence_of(:password).on(:update) }
    it { should validate_presence_of(:password_confirmation).on(:create) }
    it { should_not validate_presence_of(:password_confirmation).on(:update) }
    it "should allow valid values for email" do
      should allow_value("eliza@elizamarcum.com", "a@b.co.uk", "eliza+hash@example.com").for(:email)
    end
    describe "should not save if username is !unique" do
      it "shoud have error message 'has already been taken' "do
        Fabricate(:user, username: "username1")
        user = Fabricate.build(:user, username: "username1")
        user.valid?.should be_falsey
        (user.errors[:username].any?).should be_truthy
        error = user.errors[:username][0]
        expect(error).to eq('has already been taken')
      end
    end
    describe "should be invalid if email is not formatted correctly" do
      it { should_not allow_value("elizabrock.com").for(:email) }
      it { should_not allow_value("eliza@examplecom").for(:email) }
      it { should_not allow_value("@.com").for(:email) }
    end
    it { should_not validate_presence_of(:bio) }
    it "should have a working factory" do
      Fabricate.build(:user).should be_valid
    end
  end
end
