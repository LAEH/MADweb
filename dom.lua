#!/usr/bin/env th

local dom = {}

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                                                                           ●
--●                                                                           ●
--●                                                                           ●
--●                                                                           ●
--●                                                                           ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

dom = {
   index = [[
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
   ]],
   stylesheet = [[
      <link rel="stylesheet" type="text/css" href="css/scss/screen.css"/>
   ]],
   js = {
      app = [[
         <script type="text/javascript" src="js/app.js"/></script>
      ]],
      jquery = [[
         <script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>
      ]],
      load = [[
         <script type="text/javascript">
            $(document).ready(function() {
               app.initialize();
            });
         </script>
      ]]
   }
}


--●●●●●●●●●●●●●
--●           ●
--●           ●
--●           ●
--●           ●
--●           ●
--●●●●●●●●●●●●●

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

--●●●●●●●●●●●●●
--●           ●
--●           ●
--●           ●
--●           ●
--●           ●
--●●●●●●●●●●●●●

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

--●●●●●●●●●●●●●
--●           ●
--●           ●
--●           ●
--●           ●
--●           ●
--●●●●●●●●●●●●●

function dom.HTMLdoc(opt)
   opt = opt or {}
   local fileName = opt.fileName or error('!!fileName')
   local bodyContent = opt.bodyContent or error('!!bodyContent')
   local htmlString =  [[
      <html>
         <head>]]
            ..dom.stylesheet
            ..dom.js.jquery
            ..dom.js.app..[[
         </head>
         <body>
            ]]..bodyContent..[[
         </body>
         ]]..dom.js.load..[[
      </html>
   ]]
   local file = io.open(fileName,'w')
   file:write(htmlString)
   file:close()
   os.execute('open '..fileName)
end

--●●●●●●●●●●●●●
--●           ●
--●           ●
--●           ●
--●           ●
--●           ●
--●●●●●●●●●●●●●

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

function iFrameTopString(opt)
   local topStrings = {}
   ---- TOP BAR
   table.insert(topStrings, dom.DIV({
      class='topBar',
      content = dom.DIV({
         class = 'logo',
         url = 'in/nevermove/logo.png',
      }),
   }))

   ---- ACTION BAR
   local actionBarStrings = {}
   for i,btn in ipairs(menu) do
      table.insert(actionBarStrings,
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
   table.insert(topStrings, dom.DIV({
      class='actionbar',
      content = table.concat(actionBarStrings)
   }))

   local iFrameTopString = table.concat(topStrings)
   return iFrameTopString
end
local iTopString = iFrameTopString()
print(iTopString)

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                                                                           ●
--●                                                                           ●
--●                                                                     PAGES ●
--●                                                                           ●
--●                                                                           ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

-- INDEX
dom.HTMLdoc({
   fileName = 'index.html',
   bodyContent = dom.index,
})

-- TOP NAVIGATION

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

return dom

