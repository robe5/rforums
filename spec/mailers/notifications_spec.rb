require "spec_helper"

describe Notifications do
  describe "password_recovery" do
    let(:mail) do
      @time = Time.now + 1.day
      @user = User.new(:name => "User 1", :email => "to@test.com", 
        :reset_password_code => "43fe8c150a0f6e91ed7c392d2d486149c20fe4be",
        :reset_password_code_until => @time)
      Notifications.password_recovery(@user)
    end

    it "renders the headers" do
      mail.subject.should eq("[Forums] User recovery")
      mail.to.should eq(["to@test.com"])
      mail.from.should eq(["forums@forums.local"])
    end

    it "renders the body" do
      mail.body.encoded.should match(recovery_session_url(:token => @token, :host => 'localhost'))
    end
    
    it "renders the until time" do
      mail.body.encoded.should match(@time.localtime.to_s(:long))
    end
  end

end
