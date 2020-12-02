# Based on https://github.com/huacnlee/rails-settings-cached

# Use this for application level settings
# The values are stored in the database, and can be changed by an admin user
class AppConfig < RailsSettings::Base
  self.table_name = "app_configs"

  validates :var, presence: true

  # the app configuration is cached, change this if you want to force update
  # the cache, or call AppConfig.clear_cache
  cache_prefix { "v1" }
  
  field :app_name, type: :string, default: 'Surfy Spots'
  # Designed logo with https://www.designevo.com/apps/logo/?name=blue-wave-and-surfer
  field :logo_url, type: :string, default: 'http://lynch-carter.s3.amazonaws.com/logo.png'
  field :email_send_from, type: :string, default: 'admin@example.com'
  field :home_page_content, type: :string, default: %Q{
    <section id="home" class="hero is-large">
        <div class="hero-body">
            <div class="container">
                <div class="columns is-vcentered">
                    <div class="column is-6">

                        <h1 class="title is-title is-size-1 has-text-weight-bold has-text-white">Find a Spot to Shred</h1>
                        
                        <p class="subtitle is-4 has-margin-top-20 is-family-primary has-text-white">Avoid the groms and the Bennys.</p>

                        <form method="get" action="#">
                            <div class="field has-addons has-margin-top-30">
                                <div class="control">
                                    <input class="input is-medium" type="email" name="email" placeholder="Your email">
                                </div>
                                <div class="control">
                                    <button type="submit" class="button is-primary is-medium">
                                            Sign Up!
                                        </button>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="column is-5 has-text-centered">
                        <figure class="image">
                            <img src="#{AppConfig.logo_url}" alt="Surfy Spots">
                        </figure>
                    </div>
                </div>
            </div>
        </div>
    </section>
  }
end