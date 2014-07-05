#!/usr/bin/env th

local color  = require 'color'
local fun = require 'fun'
local dom = require 'dom'
local palette  = require 'palette'
local display = {}
local repoDir = sys.fpath()..'/'

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                                                                           ●
--●                                                                           ●
--●                                                                           ●
--●                                                                           ●
--●                                                                           ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                           ●
--●   'display-intro.html'    ●
--●                           ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

function display.intro()
   dom.makeDoc ({
      docName = 'display-intro.html',
      html = dom.knitDoc({
         content = dom.DIV({
            class = 'display intro',
            url   = 'in/nevermove/dagrad.jpg',
         })
      }),
   })
end
display.intro()

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                           ●
--●   'display-mix.html'      ●
--●                           ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

display.images = {}
function display.images.chaos(imagesDirectoryName)
   local boxes ={}
   local files = dir.getfiles('in/'..imagesDirectoryName, '*.jpg')
   for i,file in ipairs(files) do
      local opts
      if fun.trueFalse(2,1) then opts = {
         url = file,
         class = 'img'
      }
      else opts = {
         class = 'color',
         style = 'background-color:'..color.rdm(),
      }
      end
      if fun.trueFalse(1,1) then
         local box4 = {}
         opts.class = opts.class..' small'
         for i=1, 4 do
            opts.url = fun.permute(files)[1]
            table.insert(box4,dom.DIV({
               class = 'box4',
               content = dom.DIV(opts)
            }))
         end
         table.insert(boxes, dom.DIV ({
            class = 'box',
              style = 'background-color:'..color.rdm(),
            content = table.concat(box4)
         }))
      else
         table.insert(boxes, dom.DIV ({
            class = 'box',
            content = dom.DIV(opts)
         }))
      end
   end
   local flow = dom.DIV({
      class = 'display mix',
      content = table.concat(boxes)
   })
   dom.makeDoc ({
      docName = 'display-'..imagesDirectoryName..'.html',
      html = dom.knitDoc({
         content = flow,
      }),
   })
end
display.images.chaos('mix')
display.images.chaos('arto')
display.images.chaos('gradient')

return display
