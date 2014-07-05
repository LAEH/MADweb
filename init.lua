#!/usr/bin/env th

-- local color  = require 'color'
local fun = require 'fun'
local dom = {}
local repoDir = sys.fpath()..'/'

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                                                                           ●
--●                                                                           ●
--●    Basis Elements                                                         ●
--●                                                                           ●
--●                                                                           ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

local js = {
   app = [[
   <script type="text/javascript" src="js/app.js"/></script>
   ]],
   jquery = '<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>',
   load = '<script type="text/javascript">'..'$(document).ready(function() {'
      ..'app.initialize();'..'});'..'</script>'
}
local stylesheet = '<link rel="stylesheet" type="text/css" href="css/scss/screen.css"/>'

dom.index = [[
   <iframe
      src="topFrame.html"
      id="topFrame"
      name="topFrame"
      style="
      position:fixed;
      top:0px;
      left:0;
      width:100%;
      height:120px">
   </iframe>
   <iframe
      src="display-intro.html"
      id="displayFrame"
      name="displayFrame"
      style="
      position:fixed;
      top:120px;
      left:0;
      width:100%;
      height:100%;">
   </iframe>
]]


function addClass(class)
   return ' class="' .. class .. '"'
end

function addStyle(style)
   return ' style="' .. style .. '"'
end

function addImg(url)
   return 'style="background-image: url('..url..')"'
end


function addLink(opt)
   local opt = opt or {}
   local link = opt.link
   local content = opt.content
   return '<a href="'..link.. '" target="displayFrame">'..content..'</a>'
end

function dom.DIV(opt)
   local opt = opt or {}
   local url = opt.url
   local link = opt.link
   local text = opt.text
   local style = opt.style
   local class = opt.class
   local content = opt.content
   local DIV = {}
   table.insert(DIV, '<DIV')
   if class then table.insert(DIV, addClass(class)) end
   if style then table.insert(DIV, addStyle(style)) end
   if url then
      local img ='background-image: url(' .. url .. ');'
      local style = ' style="'..img..'"'
      table.insert(DIV, addImg(url))
   end
   table.insert(DIV, '>')
   if text then table.insert(DIV, text) end
   if content then table.insert(DIV, content) end
   table.insert(DIV, '</DIV>')
   DIV = table.concat(DIV)
   if link then
      return addLink({
         link = link,
         content = DIV,
      })
   else
      return DIV
   end
end


function dom.knitDoc(opt)
   local opt = opt or {}
   local content = opt.content or error('!!content')
   return '<html>'
      ..'<head>'
      ..stylesheet
      ..js.jquery
      ..js.app
      ..'</head>'
      ..'<body>'
      ..content
      ..'</body>'
      ..js.load
      ..'</html>'
end

function dom.makeDoc(opt)
   local opt = opt or {}
   local docName = opt.docName or error('!!file')
   local html = opt.html or error('!!html')
   local file = io.open(docName,'w')
   file:write(html)
   file:close()
   -- os.execute('open index.html')
end

function dom.makeIndex(opt)
   dom.makeDoc ({
      docName = 'index.html',
      html = dom.knitDoc({
         content = dom.index
      }),
   })
end

local menu = {
   {
      twoLetters = 'In',
      prettyName = 'Intro',
      link = 'display-intro.html',
   },
   {
      twoLetters = 'Cu',
      prettyName = 'Currated',
      link = 'display-mix.html',
   },
   {
      twoLetters = 'Ar',
      prettyName = 'Arto',
      link = 'display-arto.html',
   },
   {
      twoLetters = 'Mu',
      prettyName = 'color',
      link = 'display-color.html',
   },

}

function dom.top(opt)
   local top={}
   --Top Bar
   table.insert(top, dom.DIV({
      class='topBar',
      content = dom.DIV({
         class = 'logo',
         url = 'in/nevermove/logo.png',
      }),
   }))

   -- Action Bar
   local menuDIVS = {}
   for i,btn in ipairs(menu) do
      table.insert(menuDIVS,
         dom.DIV({
            class = 'btn menu',
            link = btn.link,
            content = table.concat({
               dom.DIV({
                  class = 'twoLetters',
                  text = btn.twoLetters,
               }),
               dom.DIV({
                  class = 'prettyName',
                  text = btn.prettyName,
               })
            })
         })
      )
   end
   table.insert(top, dom.DIV({
      class='actionbar',
      content = table.concat(menuDIVS)
   }))

   dom.makeDoc ({
      docName = 'topFrame.html',
      html = dom.knitDoc({
         content = table.concat(top)
      }),
   })
end
-- dom.makeIndex()
-- dom.top()
return dom

