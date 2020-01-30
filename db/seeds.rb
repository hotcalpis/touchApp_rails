# frozen_string_literal: true

User.create!(name: 'テストユーザー',
             email: 'testuser@testuser.testuser',
             password: Rails.application.credentials[:testuser_password].to_s,
             confirmed_at: Time.now.utc.to_s)

User.create!(name: Rails.application.credentials[:adminuser_name].to_s,
             email: Rails.application.credentials[:adminuser_email].to_s,
             password: Rails.application.credentials[:adminuser_password].to_s,
             confirmed_at: Time.now.utc.to_s,
             admin_flg: true)
