# frozen_string_literal: true

User.create!(name: 'TestUser',
             email: 'testuser@testuser.testuser',
             password: "#{Rails.application.credentials[:testuser_password]}")
