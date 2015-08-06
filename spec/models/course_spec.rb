describe Course do
  describe "create" do
    subject {FactoryGirl.create :course}
    it {is_expected.to be_valid}
  end

  describe "association" do
    it {expect have_many :activities}
    it {expect have_many(:users).through :user_courses}
    it {expect have_many(:subjects).through :course_subjects}
  end

  describe "#name" do
    subject {FactoryGirl.build :course, name: nil}
    it {is_expected.not_to be_valid}
  end

  describe "#description" do
    subject {FactoryGirl.build :course, description: nil}
    it {is_expected.not_to be_valid}
  end

  describe ".course_active" do
    let!(:course1) {FactoryGirl.create :course}
    let!(:course2) {FactoryGirl.create :course, status: true}
    let!(:course3) {FactoryGirl.create :course, status: true}
    it {expect(Course.course_active.size).to eq 2}
  end

  describe "#check_status" do
    subject {FactoryGirl.create :course, status: false}
    it {expect(subject.send :check_status).to eq false}
  end

  describe "#number_delay_day" do
    subject {(FactoryGirl.create :course).send :number_delay_day}
    it {is_expected.to eq -2}
  end

  describe "#init_start_date" do
    subject {(FactoryGirl.create :course)}
    before {subject.send(:init_start_date)}
    it {expect(subject.start_date).to eq Date.today}
  end

  describe "#init_day_work" do
    subject {(FactoryGirl.create :course)}
    let!(:subject1) {subject.subjects.create day_work: 10}
    let!(:subject2) {subject.subjects.create day_work: 12}
    it {expect(subject.send :init_day_work).to eq 22}
  end
end
