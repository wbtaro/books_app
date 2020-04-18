# config valid for current version and patch releases of Capistrano
lock "~> 3.13.0"

set :application, "booksapp"

set :repo_url, "https://github.com/wbtaro/books_app.git"

set :branch, "master"

set :deploy_to, "/opt/books_app"

set :rbenv_ruby, "2.7.0"

append :linked_dirs, "public/packs"
append :linked_dirs, "public/uploads"

namespace :deploy do
  desc 'Create Database'
  task :db_create do
    on fetch(:migration_servers) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          execute :rake, 'db:create'
        end
      end
    end
  end

  # SQLiteを使う場合は必要、じゃないと毎回DBつぶされる
  # desc "copy current production.sqlite3 so that tables are not reseted"
  # task :confirm_db do
  #   on fetch(:migration_servers) do
  #     if test "[ -f #{current_path}/db/production.sqlite3 ]"
  #       # execute "cp #{current_path}/db/production.sqlite3 #{release_path}/db/production.sqlite3"
  #     end
  #   end
  # end

  # CDで自動デプロイするには手動でアップロードする方式は不可能
  desc "set master key"
  task :set_master_key do
    on roles(:app) do |host|
      master_key_path = "config/master.key"
      execute "mkdir -p #{release_path}/config" if test "[ ! -d #{release_path}/config ]"
      upload!(master_key_path, "#{release_path}/config/master.key")
    end
  end

  desc "start rails"
  task :start_rails do
    on roles(:app) do |host|
      within current_path do
        with rails_env: fetch(:rails_env) do
          execute :rails, "server"
        end
      end
    end
  end
end

before "deploy:migrate", "deploy:db_create"
before "deploy:assets:precompile", "deploy:set_master_key"
before "deploy:cleanup", "deploy:start_rails"
