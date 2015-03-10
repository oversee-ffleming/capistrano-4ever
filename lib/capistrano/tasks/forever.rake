namespace :forever do
  task :check do
    on roles :app do
      exists = test("[ -f #{fetch :forever_path} ]")
      forever_check = "Forever is not installed to #{fetch :forever_path}"
      if exists
        can_execute = test("[ -x #{fetch :forever_path} ]")
        forever_check = "Forever is installed to #{fetch :forever_path}"
        forever_check <<  " #{can_execute ? 'and is' : 'but isn\'t'} executable by #{fetch :user}"
      end
      puts forever_check
    end
  end

  task :start do
    on roles :app do
      within fetch(:forever_target_path, release_path) do
        with fetch(:forever_env_variables, {}) do
          execute fetch(:forever_path), fetch(:forever_flags), 'start', fetch(:forever_app)
        end
      end
    end
  end

  task :stop do
    on roles :app do
      within fetch(:forever_target_path, release_path) do
        with fetch(:forever_env_variables, {}) do
          begin
            execute fetch(:forever_path), fetch(:forever_flags), 'stop', fetch(:forever_app)
          rescue => e
            raise e unless e.to_s.include? 'cannot find process with id'
            puts "Forever: Couldn't stop #{fetch :forever_app} - process not found"
          end
        end
      end
    end
  end

  task :restart do
    on roles :app do
      invoke 'forever:stop'
      invoke 'forever:start'
    end
  end

  task :stop_all do
    on roles :app do
      within fetch(:forever_target_path, release_path) do
        with fetch(:forever_env_variables, {}) do
          execute fetch(:forever_path), 'stopall'
        end
      end
    end
  end

  task :restart_all do
    on roles :app do
      within fetch(:forever_target_path, release_path) do
        with fetch(:forever_env_variables, {}) do
          execute fetch(:forever_path), 'restartall'
        end
      end
    end
  end

end
