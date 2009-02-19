include("ai/tpl/merchant.lua")


-- Sends a distress signal which causes faction loss
function sos ()
   msg = {
      "Mayday! We are under attack!",
      "Requesting assistance.  We are under attack!",
      "Merchant vessel under attack! Requesting help!",
      "Help! Ship under fire!",
      string.format("Mayday! Merchant %s being assaulted!", ai.shipclass())
   }
   ai.settarget( ai.target() )
   ai.distress( msg[ rnd.int(1,#msg) ])
end


function create ()

   -- Probably the ones with the most money
   ai.setcredits( rnd.int(ai.shipprice()/100, ai.shipprice()/25) )

   -- Communication stuff
   mem.bribe_no = "\"The Space Traders do not negotiate with criminals.\""
   mem.refuel = rnd.rnd( 3000, 5000 )
   standing = ai.getstanding( ai.getPlayer() ) or -1
   if standing > 50 then mem.refuel = mem.refuel * 0.75
   elseif standing > 80 then mem.refuel = mem.refuel * 0.5
   end
   mem.refuel_msg = string.format("\"I'll supply your ship with fuel for %d credits.\"",
         mem.refuel);

   -- Some stuff has more chance then others
   num = rnd.int(12)
   if num < 5 then
      cargo = "Food"
   elseif num < 8 then
      cargo = "Ore"
   elseif num < 10 then
      cargo = "Industrial Goods"
   elseif num < 12 then
      cargo = "Luxury Goods"
   else
      cargo = "Medicine"
   end
   ai.setcargo( cargo, rnd.int(0, ai.cargofree() ) )
end

