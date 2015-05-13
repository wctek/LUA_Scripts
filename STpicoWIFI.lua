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

function setIP(_IP,_MASK,_GW)
   wifi.sta.setip({ip=_IP,netmask=_MASK,gateway=_GW})
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

        collectgarbage();

        buf = "HTTP/1.1 200 OK\n\n";
--        buf = buf.."\n";
        buf = buf .."<!DOCTYPE html>";
        buf = buf .."<head>";
        buf = buf .."<meta name = 'viewport' content = 'user-scalable=no, initial-scale=1.0, maximum-scale=1.0, width=device-width'>";
        buf = buf .."<style>table{padding:0;margin:0}button:hover{background-color:#eee;color:#000}td{text-align:center;font-weight:bold}";
        buf = buf .."body{font-family:Verdana;background-color:#eef}button{padding:20px;width:80px;background-color:#337ab7;color:#fff;"
        buf = buf .."border:1px solid #2e6da4;border-radius: 5px;}</style>";
        buf = buf .."<title>Piccolino WebButtons</title>";
        buf = buf .."</head>";
        buf = buf .."<body>";
        buf = buf .."<center>";
        buf = buf .."<table border='0' width='182'>";
        buf = buf .."<tr>";
        buf = buf .."<td colspan='4'>Piccolino WebButtons Demo</td>";
        buf = buf .."</tr>";
        buf = buf .."<tr>";
        buf = buf .."<td colspan='4'>&nbsp;</td>";
        buf = buf .."</tr>";
        buf = buf .."<tr>";
        buf = buf .."<td colspan='4'>&nbsp;</td>";
        buf = buf .."</tr>";
        buf = buf .."<tr>";
        buf = buf .."<td colspan='2'><a href='?a=1'><button>ON</button></a></td>";
        buf = buf .."<td colspan='2'><a href='?a=2'><button>OFF</button></a></td>";
        buf = buf .."</tr>";
        buf = buf .."<tr>";
        buf = buf .."<td colspan='2'>&nbsp;</td>";
        buf = buf .."<td colspan='2'>&nbsp;</td>";
        buf = buf .."</tr>";
        buf = buf .."<tr>";
        buf = buf .."<td colspan='2'><a href='?b=1'><button>SET</button></a></td>";
        buf = buf .."<td colspan='2'><a href='?b=2'><button>RESET</button></a></td>";
        buf = buf .."</tr>";      
        buf = buf .."</table>";
        buf = buf .."</body>";
        buf = buf .."</html>";
       
        client:send(buf);
        client:close();
        
        collectgarbage();
    end)
end)

end
