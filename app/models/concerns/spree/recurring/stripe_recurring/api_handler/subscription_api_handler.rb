module Spree
  class Recurring < Spree::Base
    class StripeRecurring < Spree::Recurring
      module ApiHandler
        module SubscriptionApiHandler
          def subscribe(subscription)
            raise_invalid_object_error(subscription, Spree::Subscription)
            before_each
            customer = subscription.user.find_or_create_stripe_customer(subscription.card_token)
            subscription_id = customer.subscriptions.create(plan: subscription.api_plan_id).id
            subscription.subscription_id = subscription_id
          end

          def unsubscribe(subscription)
            raise_invalid_object_error(subscription, Spree::Subscription)
            before_each
            subscription.user.api_customer.subscriptions.retrieve(subscription.subscription_id).delete
          end
        end
      end
    end
  end
end
