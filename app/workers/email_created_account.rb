class EmailCreatedAccount
  include Sidekiq::Worker

  def perform user_id
    user = User.find user_id
    UserMailer.create_account(user).deliver
  end
end
