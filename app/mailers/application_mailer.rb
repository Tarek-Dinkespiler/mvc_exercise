# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'tarek@thp.com'
  layout 'mailer'
end
