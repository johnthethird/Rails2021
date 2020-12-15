class NavComponent < ApplicationComponent
  attr_reader :current_user, :current_path

  NAV_LINKS = [
    { id: 'home', title: 'Home', path_regex: %r{^/$}, href: '/', selected: '' },
    { id: 'cards', title: 'Cards', path_regex: %r{^/cards$}, href: '/cards', selected: '' },
    { id: 'search', title: 'Search', path_regex: %r{^/cards/search$}, href: '/cards/search', selected: '' },
    { id: 'about', title: 'About', path_regex: %r{^/about$}, href: '/about', selected: '' }
  ]

  def initialize(current_user: nil, current_path: '/')
    @current_path = current_path
    @current_user = current_user
  end

  def nav_links
    NAV_LINKS.map do |h|
      if current_path =~ h[:path_regex]
        h[:selected] = 'selected'
      else
        h[:selected] = ''
      end
      h
    end

    # A one-line way to do this is using Ruby's tertiary conditional syntax
    # NAV_LINKS.map{|h| h[:selected] = (current_path =~ h[:path_regex]) ? 'selected' : ''; h}
  end

  def is_logged_in?
    current_user.present?
  end

  def is_admin?
    is_logged_in? && current_user.is_admin?
  end
end
