# frozen_string_literal: true

User.create!(name: 'テストユーザー',
             email: 'testuser@testuser.testuser',
             password: "#{Rails.application.credentials[:testuser_password]}",
             confirmed_at: "#{Time.now.utc}")
