RSpec.describe Admin::CoursesController, type: :controller do
  let!(:course1) {FactoryGirl.create :course}
  let!(:course2) {FactoryGirl.create :course}
  let!(:course3) {FactoryGirl.create :course}
  let!(:admin) {FactoryGirl.create :admin}

  before {sign_in admin}

  describe "#index" do
    before {get :index}
    context "get index successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "index"}
      it {expect(assigns :courses).to match_array [course1, course2, course3]}
    end
  end

  describe "#show" do
    before {get :show, id: course1}
    context "get show successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "show"}
    end
  end

  describe "#new" do
    before {get :new}
    context "get new successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "new"}
    end
  end

  describe "#create" do 
    context "post create successfully" do
      before {post :create, course: FactoryGirl.attributes_for(:course)}
      it {expect(response).to have_http_status 302}
      it {expect(response).to redirect_to admin_root_path}
    end

    context "post create fail with name blank" do
      before {post :create, course: FactoryGirl.attributes_for(:invalid_course1)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "new"}
    end

    context "post create fail with description blank" do
      before {post :create, course: FactoryGirl.attributes_for(:invalid_course2)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "new"}
    end
  end

  describe "#edit" do
    before {get :edit, id: course1}
    context "get edit successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "edit"}
    end
  end

  describe "#update" do 
    context "patch update successfully" do
      before {patch :update, id: course1, course: FactoryGirl.attributes_for(:course)}
      it {expect(response).to have_http_status 302}
      it {expect(response).to redirect_to action: :show, id: assigns(:course).id}
    end

    context "patch update fail with name blank" do
      before {patch :update, id: course1, course: FactoryGirl.attributes_for(:invalid_course1)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "edit"}
    end

    context "patch update fail with description blank" do
      before {patch :update, id: course1, course: FactoryGirl.attributes_for(:invalid_course2)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "edit"}
    end
  end

  describe "#destroy" do
    before {delete :destroy, id: course1}
    context "delete destroy successfully" do
      it {expect(response).to have_http_status 302}
      it {expect(response).to redirect_to admin_courses_path}
    end
  end
end
