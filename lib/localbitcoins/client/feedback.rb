module LocalBitcoins
  module Feedback
    def give_feedback(username, feedback_type, msg='')
      request(:post, "/api/feedback/#{username}/", {:feedback=>feedback_type, :msg=>msg})
    end
  end
end
