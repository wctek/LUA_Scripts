function getIP()
   tmr.alarm (1, 500, 1, function()
      if wifi.ap.getip() == nil then
         print (".")
      else        
         tmr.stop(1)
         print (""..wifi.ap.getip())
      end
   end)
end

function con(SSID, PWD)   
    wifi.setmode(wifi.SOFTAP)
    cfg={}
    cfg.ssid=SSID
    cfg.pwd=PWD
    wifi.ap.config(cfg)    
end

function setIP(_IP,_MASK,_GW)
      wifi.ap.setip({ip=_IP,netmask=_MASK,gateway=_GW})
end

function startServer()
    
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive", function(client,request)
        local buf = "";
        local _, _, method, path, vars = string.find(request, "([A-Z]+) (.+)?(.+) HTTP");
        if(method == nil)then
            _, _, method, path = string.find(request, "([A-Z]+) (.+) HTTP");
        end
        local _GET = {}
        if (vars ~= nil)then
            for k, v in string.gmatch(vars, "(%w+)=(%w+)&*") do
                _GET[k] = v
                print(k..'='..v);
            end
        end
        buf = "HTTP/1.1 200 OK\n\n";
        buf = buf.."\n";
        buf = buf .."<!DOCTYPE html>";
        buf = buf .."<head>";
        buf = buf .."<meta name = 'viewport' content = 'user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width'>";
        buf = buf .."<style>table{padding:0;margin:0}button:hover{background-color:#eee;color:#000;}td{text-align:center;font-weight:bold}body{font-family:Verdana,Arial;";
        buf = buf .."background-color:#eeeeff;}button{padding:20px;width:80px;background-color:#337ab7;color:#fff;"
        buf = buf .. "border:1px solid #2e6da4;border-radius: 5px;}</style>";
        buf = buf .."<title>Piccolino WebButtons</title>";
        buf = buf .."</head>";
        buf = buf .."<body>";
        buf = buf .."Piccolino AP ready!";
        buf = buf .."</body>";
        buf = buf .."</html>";
       
        client:send(buf);
        client:close();
        
        collectgarbage();
    end)
end)

end
