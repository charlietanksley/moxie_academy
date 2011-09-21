# Original version cribbed heavily from
# padrino-admin-0.10.1/lib/padrino-admin/helpers/authentication_helpers.rb
#
# This version is much simpler.  Go back a notch if you want a more
# complicated version!
module UserServices
  module Authentication

    # Public: Redirect to login unless user is logged in.
    #
    # Returns nothing (redirect).
    def verify_logged_in
      redirect url(:sessions, :new) unless logged_in?
      # stick current url in :back?
    end

    # Public: Tell whether the current user is logged in.
    #
    # Returns a Boolean.
    def logged_in?
      session_id.nil? ? false : true
    end

    # Public: Provide the current session id.
    #
    # The rational for having this as its own method is that I might
    # decide to not to use sessions, but to use something sturdier.
    #
    # Returns the current session id or nil.
    def session_id
      session[:uid] rescue nil
    end


    # Public: Determine whether the current user can view the current
    # page.
    #
    # user      - A User, with an id and a group_id attribute.
    # resource  - A resource (e.g., a Lesson), which has a `visible_to`
    #             many attribute.
    #
    # Returns a Boolean.
    def visible_to_user?(user, resource)
      resource.groups.include? user.group
    end

    # Public: Show the page or redirect depending on whether the page is
    # visible to the user.
    #
    # Returns nothing.
    def verify_visible_to_user(user, resource)
      redirect to(error 403) unless visible_to_user(user, resource)
    end

  end # Authentication
end # UserServices
