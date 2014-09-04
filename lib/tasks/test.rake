namespace :test do
  desc 'Run full test suite'
  task suite: :environment do
    notify('Running Linters')
    Rake::Task['lint'].invoke

    notify('Running Cucumber')
    system('cucumber --format pretty --color')

    notify('Running Tests')
    Rake::Task['test'].invoke
  end
end
