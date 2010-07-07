require File.dirname(__FILE__) + '/../spec_helper'
module MortgageCalc
  describe MortgageUtil do
    def assert_monthly_apr_payment_matches(loan_amount, rate, period, fee, points)
      mortgage_util = MortgageUtil.new(loan_amount, rate, period, fee, points)
      monthly_payment_with_fees = mortgage_util.monthly_payment_with_fees
      monthly_payment_from_apr = MortgageUtil.new(loan_amount, mortgage_util.apr, period, 0, 0).monthly_payment
      monthly_payment_with_fees.should be_close(monthly_payment_from_apr, 0.01)
    end

    context "with valid MortgageUtil" do
      before(:all) do
        @mortgage_util = MortgageUtil.new(100000, 6.0, 360, 1200, 1.25)
        @mortgage_util_with_apr_as_rate = MortgageUtil.new(100000, @mortgage_util.apr, 360, 1200, 1.25)
      end
      it "should have proper monthly interest rate" do
        @mortgage_util.send(:monthly_interest_rate).should == 0.005
      end
      it "should have proper monthly payment" do
        @mortgage_util.monthly_payment.should be_close(599.55, 0.001)
      end
      it "should have proper total fees" do
        @mortgage_util.total_fees.should be_close(2450, 0.001)
      end
      it "should have proper APR" do
        @mortgage_util.apr.should be_close(6.22726, 0.00001)
      end
    end
    it "should calculate original monthly payment from APR" do
      assert_monthly_apr_payment_matches(300000, 6.5, 360, 1200, 1.25)
      assert_monthly_apr_payment_matches(300000, 6.5, 360, 0, 0)
      assert_monthly_apr_payment_matches(400000, 1.1, 180, 1200, 1.25)
      assert_monthly_apr_payment_matches(300000, 6.5, 360, 0, 7.25)
      assert_monthly_apr_payment_matches(300000, 6.5, 360, 10000, 7.25)
    end
  end

  context "net negative fees" do
     before(:all) do
      @mortgage_util =  MortgageUtil.new(100000, 6.0, 360, 1200, -11.25)
      @mortgage_util.total_fees.should be 0
    end
    it "calculate total fees should return 0 if total fees is less than 0" do
       @mortgage_util.send(:calculate_total_fees).should be 0
    end
    it "should not return APR less than interest rate" do
      @mortgage_util.apr.should be_close 6.0, 0.00000001
    end
  end

  context "initialize convert to best types" do
    before(:all) do
      @mortgage_util =  MortgageUtil.new('100000', '6.0', 360, 1200, '-1.25')
    end
    it "should convert rate to float if necessary" do
      @mortgage_util.interest_rate.class.should == Float
    end
    it "should convert points to float if necessary" do
      @mortgage_util.points.class.should == Float
    end
    it "should convert loan_amount to float if necessary" do
      @mortgage_util.loan_amount.class.should == Float
    end
    it "should convert period to integer if necessary" do
      @mortgage_util.period.class.should == Fixnum
    end
  end
end