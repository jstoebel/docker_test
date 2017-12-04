desc 'ensure no sneaky rails envs.'
task :assert_env do
  raise 'Invalid env' unless /production|development/ =~ Rails.env
end

desc 'Run docker-compose command with the correct settings '
task docker_compose: %w[environment assert_env] do
  options = {}
  OptionParser.new do |opts|
    opts.banner = 'Usage: rake docker_compose -cmd'
    opts.on('-c', '--command ARG', String) { |cmd| options[:cmd] = cmd }
  end.parse!

  command_str = 'docker-compose ' \
      "-f config/docker/#{Rails.env}/docker-compose.yml " \
      "--project-directory #{Rails.root} " \
      "#{options[:cmd]}"

  puts command_str
  exec command_str
end