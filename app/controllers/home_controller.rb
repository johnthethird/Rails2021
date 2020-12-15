class HomeController < ApplicationController
  def show
    # Example of storing some HTML content in the DB for easy changes.
    # Using AppConfig makes sense for a few content pieces, but if you want a full-blown CMS (Content Management System) there are
    # a lot of them out there to leverage.
    @content = AppConfig.home_page_content
  end

  def about
    # For performance, you can tell the browser (or any web cache in between your server and the user's browser)
    # to cache this page for X minutes. Make sure you dont have any dynamic content on the page, like flash alerts etc.
    expires_in 10.minutes, public: true
  end
end
