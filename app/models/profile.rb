# frozen_string_literal: true

# == Schema Information
#
# Table name: profiles
#
#  id         :bigint(8)        not null, primary key
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Profile < ApplicationRecord
  belongs_to :user

  def send_email
    ProfileMailer.notify_user(user).deliver_later
  end
end
