#!/usr/bin/env th

local col = require 'async.repl'.colorize
local MADweb = {}

local js = {
   app = [[
      <script type="text/javascript" src="js/app.js"/></script>
   ]],
   jquery = '<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>',
   load = '<script type="text/javascript">'..'$(document).ready(function() {'
      ..'app.initialize();'..'});'..'</script>'
}
local stylesheet = '<link rel="stylesheet" type="text/css" href="css/scss/screen.css"/>'



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

function MADweb.DIV(opt)
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


function MADweb.knitDoc(opt)
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

function MADweb.makeDoc(opt)
   local opt = opt or {}
   local docName = opt.docName or error('!!file')
   local html = opt.html or error('!!html')
   local file = io.open(docName,'w')
   file:write(html)
   file:close()
   -- os.execute('open '..docName)
end


--┏━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┓
--┃                                                                           ┃
--┃                                             Exemple : Parsing a direcoruy ┃
--┃                                                                           ┃
--┗━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━┛

function imagesDirectoryDisplay(directory)
   local directory = directory or 'img/rick/'
   local files = dir.getfiles(directory, '*.jpg')
   local imgDIVstrings = {}
   for i, file in ipairs(files)  do
      table.insert(imgDIVstrings,
         MADweb.DIV({
            class = 'image',
            url = file,
         })

      )
   end
   local imagesWrap = MADweb.DIV({
      class='imagesWrap',
      content = table.concat(imgDIVstrings)
   })
   MADweb.makeDoc ({
      docName = 'exemple.html',
      html = MADweb.knitDoc({
         content = imagesWrap
      }),
   })
end
imagesDirectoryDisplay()
return MADweb

