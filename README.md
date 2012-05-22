Droid Driver
==================

Telnets to a running emulator and allows you to send commands to it

    driver = DroidDriver.new
    
    driver.sms "1234567", "text message"
    
    driver.close

It also supports `open`

    DroidDriver.open do |d|
      d.sms "1234567", "message"
    end
