function getIP()
   tmr.alarm (1, 500, 1, function()
      if wifi.sta.getip() == nil then
         print (".")
      else        
         tmr.stop(1)
         print (""..wifi.sta.getip())
      end
   end)
end

function con(SSID, PWD)
    wifi.setmode(wifi.STATION)
    wifi.sta.config(SSID,PWD)
    wifi.sta.connect()
end

function getFeed(_key,_email,_feed_id,_options)
   
    conn=net.createConnection(net.TCP, 0) 

    conn:on("connection", function(conn, payload) 
                       conn:send("GET /?k=".._key.."&u=".._email.."&f=".._feed_id.."&o=".._options
                        .." HTTP/1.1\r\n" 
                        .."Host: pgw.io\r\n" 
                        .."Connection: close\r\n"
                        .."Accept: */*\r\n" 
                        .."User-Agent: Mozilla/4.0 "
                        .."(compatible; Piccolino by wctek.com;)"
                        .."\r\n\r\n")
                       end) 
    
    conn:connect(80,'pgw.io') 
    conn:on("receive", function(conn, payload)
    local feed=string.sub(payload,string.find(payload,"/html")+13,string.find(payload,",\r\n0"))

    print(feed);
    
    conn:close()
    end) 

end

function setIP(_IP,_MASK,_GW)
   wifi.sta.setip({ip=_IP,netmask=_MASK,gateway=_GW})
end

