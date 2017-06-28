namespace :cache do
  desc 'Recount counter cache for EduProgram students'
  task :recount => :environment do
    EduProgram.find_each do |e|
      EduProgram.reset_counters(e.id, :students)
      puts 'EduProgram '+e.name+' has '+ e.students.size.to_s + ' students.'
    end
  end
end
