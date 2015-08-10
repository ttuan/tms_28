describe Subject do
  describe "create" do
    subject {FactoryGirl.create :subject}
    it {is_expected.to be_valid}
  end
  
  describe "association" do
    it {expect have_many :user_subjects}
    it {expect have_many :tasks}
    it {expect have_many(:courses).through :course_subjects}
  end

  describe "#name" do
    subject {FactoryGirl.build :invalid_subject1}
    it {is_expected.not_to be_valid}
  end

  describe "#description" do
    subject {FactoryGirl.build :invalid_subject2}
    it {is_expected.not_to be_valid}
  end

  describe "#day_work" do
    subject {FactoryGirl.build :invalid_subject3}
    it {is_expected.not_to be_valid}
  end
end
