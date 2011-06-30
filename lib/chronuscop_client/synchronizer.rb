module ChronuscopClient

  # This class handles synchronizing local and remote keys.
  class Synchronizer

    def start
      Thread.new { keep_in_sync }
    end

    def keep_in_sync
      for i in 1..7 do
        sleep(1)
        puts "synchronizing"
      end
    end

  end
end

