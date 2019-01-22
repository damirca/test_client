module TestClient
  class Runner
    def initialize
      @bluecode_client = BluecodeClient.new
      @checksums = Array.new
    end

    def run
      File.readlines(input_file_location).each do |command|
        command.chomp!

        next unless command
        next unless valid_command?(command)

        case command
        when 'C'
          bluecode_client.clear
        when 'CS'
          checksums << bluecode_client.checksum
        else
          digits = command.split('A').last
          bluecode_client.store(digits)
        end
      end
    end

    def final_result
      checksums.compact.join
    end

    private

    attr_reader :bluecode_client, :checksums

    def input_file_location
      File.join(File.dirname(__FILE__), 'test_input.txt')
    end

    def valid_command?(command)
      return true if %(C CS).include?(command)
      return true if command =~ /\AA\d+\z/

      false
    end
  end
end
