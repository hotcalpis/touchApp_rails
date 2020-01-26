# frozen_string_literal: true

User.create!(name: 'テストユーザー',
             email: 'testuser@testuser.testuser',
             password: Rails.application.credentials[:testuser_password].to_s,
             confirmed_at: Time.now.utc.to_s)
