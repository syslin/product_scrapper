every 1.week do
  runner 'ProductUpdateJob.perform_later'
end