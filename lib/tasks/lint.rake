task lint: ['lint:scss', 'lint:coffee']

namespace :lint do
  task :sass do
    system('scss-lint app/assets/stylesheets')
  end

  # task :coffee do
  #   system('coffeelint app/assets/javascripts')
  # end
end
