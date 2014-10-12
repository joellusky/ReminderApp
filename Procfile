web: bundle exec thin -p $PORT -c ./config/unicorn.rb
worker: bundle exec sidekiq -e production -C config/sidekiq.yml