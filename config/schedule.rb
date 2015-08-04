every 1.minutes do
  # runner "EmailReport.perform_async"
  runner "User.change"
end