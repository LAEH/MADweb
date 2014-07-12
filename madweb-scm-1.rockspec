package = "MADweb"
version = "scm-1"

source = {
   url = "git://github.com/LAEH/MADweb",
   branch = "master"
}

description = {
   summary = "MADweb",
   detailed = [[
      Sublime Text Developement Context
   ]],
   homepage = "https://github.com/LAEH/MADweb",
   license = "BSD"
}

dependencies = {
}

build = {
   type = "builtin",
   modules = {
      ['MADweb.init'] = 'init.lua',
      ['MADweb.schemes'] = 'schemes.lua',
      ['MADweb.schemes'] = 'syntax.lua',
      ['MADweb.preferences'] = 'preferences.lua',
   }
}
