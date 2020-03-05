class AutoCreateJob < ApplicationJob
  include Resque::Plugins::Status
  queue_as :default

  def perform
    Trip.create(name: "Test", description: "Test", location: "Buenos Aires")
    puts "Trip created"
  end
end
