package = "MADsublime"
version = "scm-1"

source = {
   url = "git://github.com/LAEH/MADsublime",
   branch = "master"
}

description = {
   summary = "MADsublime",
   detailed = [[
      Sublime Text Developement Context
   ]],
   homepage = "https://github.com/LAEH/MADsublime",
   license = "BSD"
}

dependencies = {
}

build = {
   type = "builtin",
   modules = {
      ['MADsublime.init'] = 'init.lua',
      ['MADsublime.schemes'] = 'schemes.lua',
      ['MADsublime.schemes'] = 'syntax.lua',
      ['MADsublime.preferences'] = 'preferences.lua',
   }
}
