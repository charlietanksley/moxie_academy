# Original version cribbed heavily from
# padrino-admin-0.10.1/lib/padrino-admin/helpers/authentication_helpers.rb
#
# This version is much simpler.  Go back a notch if you want a more
# complicated version!
module UserServices
  module Authentication

    # Public: Tell whether the current user is logged in.
    #
    # Returns a Boolean.
    def logged_in?
      session_id.nil? ? false : true
    end

    # Public: Provide the current session id.
    #
    # Returns the current session id or nil.
    def session_id
      session[:session_id] rescue nil
    end

    # Public: Set current user in the session[:session_id].
    #
    # storage - a Hash used to store the user id (default: session)
    # user    - a User (the full object, as we query for the id)
    #
    # Returns nothing.
    def self.set_as_current_user(storage='session', user=nil)
      storage[:session_id] = user.id
    end

    # Private: Log in an user based on info in the session.
    #
    # Returns a User.
    def login_from_session
    end

  end # Authentication
end # UserServices

__END__

module Padrino
  module Admin
    module Helpers
      module AuthenticationHelpers
        ##
        # Returns true if +current_account+ is logged and active.
        #
        def logged_in?
          !current_account.nil?
        end

        ##
        # Returns the current_account, it's an instance of <tt>Account</tt> model
        #
        def current_account
          @current_account ||= login_from_session
        end

        ##
        # Override the current_account, you must provide an instance of Account Model
        #
        # ==== Examples:
        #
        #     set_current_account(Account.authenticate(params[:email], params[:password])
        #
        def set_current_account(account=nil)
          session[settings.session_id] = account ? account.id : nil
          @current_account = account
        end

        ##
        # Returns true if the +current_account+ is allowed to see the requested path
        #
        # For configure this role please refer to: +Padrino::Admin::AccessControl::Base+
        #
        def allowed?
          access_control.allowed?(current_account, request.path_info)
        end

        ##
        # Returns project modules for the current account
        #
        def project_modules
          access_control.project_modules(current_account)
        end

        ##
        # Returns a helper useful in a +before_filter+ for check if
        # an account are: +logged_in?+ and +allowed?+
        #
        # By default this method is used in Admin Apps.
        #
        def login_required
          store_location! if store_location
          return access_denied unless allowed?
        end

        ##
        # Store in session[:return_to] the env['HTTP_REFERER']
        #
        def store_location!
          session[:return_to] = env['HTTP_REFERER']
        end

        ##
        # Redirect the account to the page that requested an authentication or
        # if the account is not allowed/logged return it to a default page
        #
        def redirect_back_or_default(default)
          return_to = session.delete(:return_to)
          redirect(return_to || default)
        end

        private
          def access_denied
            # If we have a login_page we redirect the user
            if login_page
              redirect(login_page)
            # If no match we halt with 401
            else
              halt 401, "You don't have permission for this resource"
            end
          end

          def login_page
            login_page ||= settings.login_page rescue nil
            return unless login_page
            login_page = File.join(ENV['RACK_BASE_URI'].to_s, login_page) if ENV['RACK_BASE_URI']
            login_page
          end

          def store_location
            settings.store_location rescue nil
          end

          def login_from_session
            Account.find_by_id(session[settings.session_id]) if defined?(Account)
          end
      end # AuthenticationHelpers
    end # Helpers
  end # Admin
end # Padrino

