FactoryGirl.define do
	factory :user do
		sequence(:email){ |n| "test#{n}@test.com" }
		name "Test User"
		password "12341234"
		password_confirmation "12341234"
	end
end