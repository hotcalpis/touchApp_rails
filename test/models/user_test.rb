require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
	  @user = User.new(name: "asamura", email: "asamura@hideto.com",
	                   password: "loveseibu")
  end
	
	test "should be valid" do
	  assert @user.valid?
  end
	
	test "should be invalid with name blank" do
	  @user.name = ""
		assert_not @user.valid?
	end
	
	test "should be invalid with email blank" do
	  @user.email = ""
		assert_not @user.valid?
	end
	
	#21=>20でfailure
	test "should be invalid with 21literal name" do
	  @user.name = "a" * 21
	  assert_not @user.valid?
	end
	
	#244=>243でfailure
	test "should be invalid with 256literal email" do
	  @user.email = "a" * 244 + "@example.com"
		assert_not @user.valid?
	end
	
	test "should be valid with valid addresses" do
	  valid_addresses = %w[rt@example.com A_SA-MU_RA@foo.bar.com one.two.three@gmail.com love+seibu@gg.com]
    valid_addresses.each do |address|
		  @user.email = address
			assert @user.valid?
		end
	end
	
	test "should be invalid with invalid addresses" do
	  invalid_addresses = %w[user@example,com userpexample.com aruaru@iitai. foo@ba_aar.com 20202@ezweb..com]
	  invalid_addresses.each do |address|
		  @user.email = address
			assert_not @user.valid?, "#{address.inspect} is failure"
		end
	end
	
	test "email addresses should be unique" do
	  duplicate_user = @user.dup
		duplicate_user.email = @user.email
		@user.save
		assert_not duplicate_user.valid?
	end
	
	test "email should downcase before save" do
	  @user.email = "EXAMple@rAiLs.CoM"
		@user.save
		assert_equal "example@rails.com", @user.reload.email
	end
	
	test "password should not be blank" do
	  @user.password = " " * 8
		assert_not @user.valid?
	end
	
	#8文字以上にするとfailure
	test "password valitation should have minimum length 8" do
	  @user.password = "asamura"
		assert_not @user.valid?
	end
	
end