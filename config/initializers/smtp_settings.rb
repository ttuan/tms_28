ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address        => "smtp.gmail.com",
  :port           => 587,
  :domain         => "localhost:3000",
  :authentication => :plain,
  :user_name      => "tms28server@gmail.com",
  :password       => "abcd1234admin"
}
