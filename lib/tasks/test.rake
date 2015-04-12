namespace :test do
  desc 'Run full test suite'
  task suite: :environment do
    notify('Running Tests')
    Rake::Task['test'].invoke
  end
end
