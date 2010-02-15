Given /^(.*), (.*), (.*), (.*), (.*)$/ do |loan_amount, fees, points, rate, period|
  @mortgage_util = MortgageCalc::MortgageUtil.new(Integer(loan_amount), Float(rate), Integer(period), Float(fees), Float(points))
end

Then /^the resultant apr should be (.*)$/ do |apr_expected|
  @mortgage_util.apr.should be_close(Float(apr_expected), 0.001)
end
