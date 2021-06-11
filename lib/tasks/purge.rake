namespace :captain do
    task :purge_entries => :environment do 
        # Limpio entradas de hace 3 o más meses de antigüedad.
        LogEntry.where(
            :bucket => "FULLJAUS", 
            :created_at.lt => Time.now - 15.days
        ).delete_all
    end
end