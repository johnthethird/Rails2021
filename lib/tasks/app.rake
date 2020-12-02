namespace :app do
  desc "Load default settings into DB (also set to run after db:seed)"
  task :load_default_settings => [:environment] do |t, args|
    puts "Loading all default settings in models/app_config.rb into the app_configs DB table..."
    AppConfig.keys.each do |key|
      db_val = AppConfig.where(var: key).first
      unless db_val
        puts "AppConfig: Loading #{key}"
        default = AppConfig.send(key)
        AppConfig.send("#{key}=", default)
      end
    end
  end
end

Rake::Task["db:seed"].enhance do
  Rake::Task["app:load_default_settings"].execute
end