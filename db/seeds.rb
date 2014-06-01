# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

lecturer = FactoryGirl.create(:lecturer, :email => "foo@bar.com")
FactoryGirl.create(:student, :lecturer => lecturer, :matric_no => "AUO/11/301", :projects => [FactoryGirl.create(:project)])
FactoryGirl.create_list(:student, 30, :lecturer => lecturer, :projects => [FactoryGirl.create(:project)])
