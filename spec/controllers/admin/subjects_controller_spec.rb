RSpec.describe Admin::SubjectsController, type: :controller do
  let!(:subject1) {FactoryGirl.create :subject}
  let!(:subject2) {FactoryGirl.create :subject}
  let!(:subject3) {FactoryGirl.create :subject}
  let!(:admin) {FactoryGirl.create :admin}

  before {sign_in admin}

  describe "#index" do
    before {get :index}
    context "get index successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "index"}
      it {expect(assigns :subjects).to match_array [subject1, subject2, subject3]}
    end
  end

  describe "#show" do
    before {get :show, id: subject1}
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
      before {post :create, subject: FactoryGirl.attributes_for(:subject)}
      it {expect(response).to have_http_status 302}
      it {expect(response).to redirect_to admin_root_path}
    end

    context "post create fail with name blank" do
      before {post :create, subject: FactoryGirl.attributes_for(:invalid_subject1)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "new"}
    end

    context "post create fail with description blank" do
      before {post :create, subject: FactoryGirl.attributes_for(:invalid_subject2)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "new"}
    end

    context "post create fail with daywork blank" do
      before {post :create, subject: FactoryGirl.attributes_for(:invalid_subject3)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "new"}
    end
  end

  describe "#edit" do
    before {get :edit, id: subject1}
    context "get edit successfully" do
      it {expect(response).to be_success}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "edit"}
    end
  end

  describe "#update" do 
    context "patch update successfully" do
      before {patch :update, id: subject1, subject: FactoryGirl.attributes_for(:subject)}
      it {expect(response).to have_http_status 302}
      it {expect(response).to redirect_to action: :show, id: assigns(:subject).id}
    end

    context "patch update fail with name blank" do
      before {patch :update, id: subject1, subject: FactoryGirl.attributes_for(:invalid_subject1)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "edit"}
    end

    context "patch update fail with description blank" do
      before {patch :update, id: subject1, subject: FactoryGirl.attributes_for(:invalid_subject2)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "edit"}
    end

    context "patch update fail with daywork blank" do
      before {patch :update, id: subject1, subject: FactoryGirl.attributes_for(:invalid_subject3)}
      it {expect(response).to have_http_status 200}
      it {expect(response).to render_template "edit"}
    end
  end

  describe "#destroy" do
    before {delete :destroy, id: subject1}
    context "delete destroy successfully" do
      it {expect(response).to have_http_status 302}
      it {expect(response).to redirect_to admin_subjects_path}
    end
  end
end
