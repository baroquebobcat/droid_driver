require 'net/telnet'

class DroidDriver

  # port - default 5554
  def self.open port=5554
    d = new port
    yield d
  ensure
    d.close
  end

  # port - default 5554
  # second emulator is on 5556, and so on
  def initialize port=5554
    @connection = Net::Telnet.new "Host" => "localhost",
                                  "Port" => port
  end

  # returns true if success, blows up on failure with the message
  def sms number, message
    response = @connection.cmd "String" =>"sms send #{number} #{message}", "Match" => /OK|KO:(.*)/, "Timeout" => 5
    if response.chomp == "OK"
      true
    else
      raise response.chomp.sub "KO:",''
    end
  end
  
  # close telnet to emulator
  def close
    @connection.close
  end
end
