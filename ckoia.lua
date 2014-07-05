#!/usr/bin/env th

require 'sys'
local fun = require 'fun'
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                                 ●
--●                      CATEGORIES ●
--●                                 ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●


local ckoia = {
   {
      twoLetters = 'NA',
      prettyName = 'Nature',
      link = 'display-color.html',
   },
   {
      twoLetters = 'NA',
      prettyName = 'nature',
      link ='display-NA.html'
   },
   {
      twoLetters = 'HU',
      prettyName = 'human',
      link ='display-HU.html'
   },
   {
      twoLetters = 'CO',
      prettyName = 'construction',
      link ='display-CO.html'
   },
   {
      twoLetters = 'ST',
      prettyName = 'stuff',
      link ='display-ST.html'
   },
   {
      twoLetters = 'FD',
      prettyName = 'food',
      link ='display-FD.html'
   },
   {
      twoLetters = 'IN',
      prettyName = 'interior',
      link ='display-IN.html'
   },
   {
      twoLetters = 'TX',
      prettyName = 'texture',
      link ='display-TX.html'
   },
   {
      twoLetters = 'GR',
      prettyName = 'graphics',
      link ='display-GR.html'
   },
   {
      twoLetters = 'XX',
      prettyName = 'Porn',
      link ='display-XX.html',
   }
}

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                                 ●
--●                     DISTORTIONS ●
--●                                 ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

local categories = {'NA','HU','CO','ST','FD','IN','TX','GR','XX'}
local stantonDirectory = path.join(os.getenv('HOME'),'CKOiA', 'up/')
local conceptsDirectories = dir.getdirectories(stantonDirectory)

function createCategoriesDirectories()
   for _,category in ipairs(categories) do
      local categoryDirectory = 'out/'..category..'/'
      os.execute("mkdir -p " .. categoryDirectory)
   end
end
-- createCategoriesDirectories()

local imageDistortions = {
   {scale = 1},
   {rot = 1},
   {color = 1},
   {flip = 1},
   {blur = 1},
   {frame = 1},
}

local upCategoryDirectories  = dir.getdirectories(stantonDirectory)
function distortSamples()
   for _,upCategoryDirectory in ipairs(upCategoryDirectories) do
      local categoryName = path.basename(upCategoryDirectory)
      local categoryConceptsDirectories = dir.getdirectories(upCategoryDirectory)
      for i, upConceptDirectory in ipairs(categoryConceptsDirectories) do
         local conceptName = path.basename(upConceptDirectory)
         local outConceptDirectory = 'out/'..categoryName..'/'..conceptName
         os.execute("mkdir -p "..outConceptDirectory)
         local conceptFiles = fun.permute(dir.getfiles(upConceptDirectory,'*.jpg'))
         for j=1, 10 do
            local outImageDirectory = outConceptDirectory..'/'..j
            os.execute("mkdir -p "..outImageDirectory)
            local imageTensor = pixels.load(conceptFiles[j])
            local scaledImage = image.scale(imageTensor, 256)
            local squareImage = pixels.crop(scaledImage)
            for k,imageDistortion in ipairs(imageDistortions) do
               local distortedImage = pixels.distort(squareImage, imageDistortion):clone()
               pixels.save(outImageDirectory..'/i'..k..'.jpg',distortedImage)
            end
            pixels.save(outImageDirectory..'/i0.jpg',imageTensor)
         end
         collectgarbage()
      end
   end
end
-- distortSamples()


--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                                 ●
--●                        WEB VIEW ●
--●                                 ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
function ckoiaDisplay()
   local categoriesDirectories = dir.getdirectories('out/')
   for i=1, math.min(#categoriesDirectories,3) do
      local rows = {}
      local category = categoriesDirectories[i]
      local conceptDirectories = dir.getdirectories(category)
      for j=1,math.min(#conceptDirectories,3) do
         local imagesDirectories = dir.getdirectories(conceptDirectories[j])
         for k=1,math.min(#imagesDirectories,3) do
            local imgs = {}
            local files = dir.getfiles(imagesDirectories[k])
            for _,file in ipairs(files) do
               table.insert(imgs,
                  dom.DIV({
                     class = 'image',
                     url = file
                  })
               )
            end
            table.insert(rows,
               dom.DIV({
                  class = 'row',
                  content = table.concat(imgs)
               })
            )
         end
      end
      local allrows = table.concat(rows)
      print(allrows)
      local all = dom.DIV({
         class = 'display CKOiA '..path.basename(category),
         content = allrows
      })
      dom.makeDoc ({
         docName = 'display-'..path.basename(category)..'.html',
         html = dom.knitDoc({
            content = all,
         })
      })
   end
end
-- ckoiaDisplay()

--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●
--●                                 ●
--●                           GRAPH ●
--●                                 ●
--●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●●

local all = {}
local  upDirectories = dir.getdirectories('/Users/LA/CKOiA/up')

for _,catDirectory in ipairs(upDirectories) do
   local catDirectories = dir.getdirectories(catDirectory)
   for _,category in ipairs(catDirectories) do
      local folder = path.basename(category)
      local res = fun.stringSplit(folder, "%.")
      table.insert(all,res)
   end
end
-- print(all)
