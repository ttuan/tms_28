require "active_support/time"

every 1.day, at: "5:00pm" do
  runner "User.report_in_day"
end

every "0 23 28-31 * * ['$(date +%d -d tomorrow)' = '01'] &&" do
  rake "report_supervisor"
end
