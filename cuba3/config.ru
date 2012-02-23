# require "mote"
require File.expand_path("vendor/cuba/lib/cuba", File.dirname(__FILE__))
require File.expand_path("vendor/cuba/lib/cuba/render", File.dirname(__FILE__))

# Cuba.plugin Mote::Helpers
Cuba.plugin Cuba::Render

Cuba.define do
  on "" do
    res.write render("./views/home.erb")
  end
end

run Cuba
