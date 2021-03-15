# namespace :db do
#   desc 'Drop, create, migrate, seed and populate sample data' #schema:load in place of migrate
#   task prepare: [:drop, :create, "schema:load", :seed, :populate_sample_data] do
#     puts 'Ready to go!'
#   end

#   desc 'Populates the database with sample data'
#   task populate_sample_data: :environment do
#     10.times { User.create!(email: Faker::Internet.email) }
#   end
# end