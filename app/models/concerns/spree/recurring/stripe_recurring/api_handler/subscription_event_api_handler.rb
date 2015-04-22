module Spree
  class Recurring < ActiveRecord::Base
    class StripeRecurring < Spree::Recurring
      module ApiHandler
        module SubscriptionEventApiHandler
          def retrieve_event(event_id)
            begin
              before_each
              Stripe::Event.retrieve(event_id)
            rescue error_class => e
              logger.error "Stripe Event error: #{e.message}"
              errors.add :base, "Stripe Event error: #{e.message}"
              nil
            end
          end
        end
      end
    end
  end
end