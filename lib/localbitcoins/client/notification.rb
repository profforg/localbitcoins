module LocalBitcoins
  module Notification
    # Notification interaction endpoints

    def notifications
      request(:get, "/api/notifications/").data
    end

    # FIXME: This should work, but API is giving errors for some reason,
    #        in certain cases.
    def mark_notification_as_read(notification_id)
      request(:post, "/api/notifications/mark_as_read/#{notification_id}/")
    end
  end
end
