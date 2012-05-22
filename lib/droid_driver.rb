require 'net/telnet'
class DroidDriver
  # port - default 5554
  # second emulator is on 5556, and so on
  def initialize port=5554
    @connection = Net::Telnet.new "Host" => "localhost",
                                  "Port" => port
  end

  def sms number, message
    response = @connection.cmd "String" =>"sms send #{number} #{message}", "Match" => /OK|KO:(.*)/, "Timeout" => 5
    if response.chomp == "OK"
      true
    else
      raise response.chomp.sub "KO:",''
    end
  rescue Timeout::Error
    # timed out
  end
  
  # close telnet to emulator
  def close
    @connection.close
  end
end
