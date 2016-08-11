-- http://www.hammerspoon.org/go/#winresize
-- hammerspoon 不能实现的区分左右cmd shift等，也不能实别Fn键，
-- 这些可以与karabiner 通过Hammerspoon with URLs实现通信,即，
-- 通过karabiner 来按键，而 hammerspoon来实现相应的事件
-- 如
-- 在命令行下调用open -g "hammerspoon://someAlert?someParam=hello"
-- hs.urlevent.bind("someAlert", function(eventName, params)
--                     if params["someParam"] then
--                        hs.alert.show(params["someParam"])
--                     end                   
-- end)

-- hs.hotkey的一个缺点是 当焦点在桌面上（即menu里显示当前激活的是finder ，但其实finder的窗口并不在最前方时，hotkey按下时回调函数没回调成功）
-- 但是 karabiner可以检测到这样的按键，故建议用karabiner来回调



-- 当此文件变化时自动reload debug用
function reloadConfig(files)
    doReload = false
    for _,file in pairs(files) do
        if file:sub(-4) == ".lua" then
            doReload = true
        end
    end
    if doReload then
        hs.reload()
    end
end
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()
hs.alert.show("HammerSpoon Config loaded")
--- end........当此文件变化时自动reload
-------------------------------------------------------------------------- 
-- 手动reload 此文件
hs.hotkey.bind({"cmd", "alt"}, "R", function()
      hs.reload()
      hs.alert.show("HammerSpoon Config loaded")
end)





---------------------------------------------------------------
-- 定位鼠标位置
local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-40, mousepoint.y-40, 80, 80))
    mouseCircle:setStrokeColor({["red"]=1,["blue"]=0,["green"]=0,["alpha"]=1})
    mouseCircle:setFill(false)
    mouseCircle:setStrokeWidth(5)
    mouseCircle:show()

    -- Set a timer to delete the circle after 3 seconds
    mouseCircleTimer = hs.timer.doAfter(3, function() mouseCircle:delete() end)
end
hs.hotkey.bind({"cmd","alt","shift"}, "D", mouseHighlight)
---------------------------------------------------------------

---占左半屏------------------------------------------------------------
function moveWinLeft()
      local win = hs.window.focusedWindow()
      local curFrame = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      curFrame.x = max.x
      curFrame.y = max.y
      curFrame.w = max.w / 2
      curFrame.h = max.h
      win:setFrame(curFrame)     
end
-- hs.hotkey.bind({"cmd"}, "LEFT", function()
--       moveWinLeft()
-- end)
-- open -g hammerspoon://moveWinLeft
-- karabiner 绑定Fn+Left 键，因 hammerspoon 不支持Fn的绑定
hs.urlevent.bind("moveWinLeft", function(eventName, params) moveWinLeft() end)

---cmd right 占右半屏------------------------------------------------------------
function moveWinRight()
      local win = hs.window.focusedWindow()
      local curFrame = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      curFrame.x = max.x +max.w/2
      curFrame.y = max.y
      curFrame.w = max.w / 2
      curFrame.h = max.h
      win:setFrame(curFrame)     
end
-- hs.hotkey.bind({"cmd"}, "RIGHT", function()moveWinRight() end)
hs.urlevent.bind("moveWinRight", function(eventName, params) moveWinRight() end)
  
---cmd up 占上半屏------------------------------------------------------------
function moveWinUp()
      local win = hs.window.focusedWindow()
      local curFrame = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      curFrame.x = max.x
      curFrame.y = max.y
      curFrame.w = max.w
      curFrame.h = max.h/2
      win:setFrame(curFrame)     
end
-- hs.hotkey.bind({"cmd"}, "UP", function() moveWinUp() end)
hs.urlevent.bind("moveWinUp", function(eventName, params) moveWinUp() end)

---cmd down 占下半屏------------------------------------------------------------
function moveWinDown()
      local win = hs.window.focusedWindow()
      local curFrame = win:frame()
      local screen = win:screen()
      local max = screen:frame()

      curFrame.x = max.x
      curFrame.y = max.y+max.h/2
      curFrame.w = max.w
      curFrame.h = max.h/2
      win:setFrame(curFrame)     
end
hs.urlevent.bind("moveWinDown", function(eventName, params) moveWinDown() end)
-- hs.hotkey.bind({"cmd"}, "DOWN", function() moveWinDown() end)



---------------------------------------------------------------
-- 指定某些app 打开后的大小布局
local laptopScreen = hs.screen.allScreens()[1]:name()
local windowLayout = {
   -- 第4 5 6 个参数都是用来描述窗口大小位置的，这三个参数只能设置其中一个
   -- 区别是第4个 是按百分比排位置如 hs.layout.left50={x=0, y=0, w=0.5, h=1}
   -- 是第5个是按象素指定大小 （此时不考虑menu与dock的）
   -- 是第6个是按象素指定大小 （此时考虑menu与dock的）
   {"Safari",  nil,          laptopScreen, hs.layout.maximized,   nil , nil},
   -- {"Safari",  nil,          laptopScreen, hs.layout.left50,    nil, nil},
   -- {"邮件",    nil,          laptopScreen, hs.layout.right50,   nil, nil},
   {"Emacs",  nil,     laptopScreen, hs.layout.maximized, nil, nil},
   -- {"Emacs",  nil,     laptopScreen, nil, nil, hs.geometry.rect(100, 100, 800, 480)},
   -- {"iTunes",  "MiniPlayer", laptopScreen, nil, nil, hs.geometry.rect(0, -48, 400, 48)},
}
hs.layout.apply(windowLayout)
---------------------------------------------------------------
-- -- 如果 windowLayout里有配相应app的初始大小，则将对应win设置成此大小
-- function moveToInitPos (win,appName)
--    for k,v in pairs(windowLayout) do
--       if v[1]==appName then
--          hs.alert.show(appName)
--          if v[4] ~= nil then
--             win:moveToUnit(v[4])
--          elseif v[5] ~= nil then
--             win:setFrame(v[5])
--          elseif v[6] ~= nil then
--             win:setFrame(v[6])
--          end
--          return true
--       end
--    end
--    return false
-- end


local toggleMaximizedMap={}
math.randomseed(os.time()) 
-- hs.geometry.rect(0, -48, 400, 48)
function toggleMaximized()
   local win = hs.window.focusedWindow()
   local app = win:application()
   local winKey=app:bundleID() .. tostring(win:id())
   local curFrame = win:frame()
   local originFrame=toggleMaximizedMap[winKey]
   local screen = win:screen()
   local max = screen:frame()
   -- hs.window.setFrameCorrectness=true
   win:maximize(0)           -- 0s duration (无动画马上最大化)
   local maximizedFrame= win:frame() -- 最大化后的尺寸
   if math.abs(maximizedFrame.w-curFrame.w)<10 and math.abs(maximizedFrame.h-curFrame.h)<10 then -- 只要窗口大小跟全屏后的尺寸相差不大就认为是全屏状态
      if  originFrame then
         win:setFrame(originFrame,0) -- 恢复成初始窗口大小
      else                      -- 没有存窗口的初始大小，则随机将其调到一个位置
         win:moveToUnit(hs.geometry.rect(math.random()*0.1,math.random()*0.1, 0.718, 0.718),0.1)
      end
   else                         -- 当前是非最大化状态，
      toggleMaximizedMap[winKey]=hs.geometry.copy(curFrame) -- 存储当前窗口大小
   end
end
hs.hotkey.bind({"cmd"}, "M", toggleMaximized)

---------------------------------------------------------------

---------------------------------------------------------------
-- toggle App
function toggleApp(appBundleID)
-- local win = hs.window.focusedWindow()
   -- local app = win:application()
   local app =hs.application.frontmostApplication()
   if app ~= nil and app:bundleID() == appBundleID    then
      hs.alert.show("222" .. tostring(#app:visibleWindows()))        
      app:hide()
      -- win:sendToBack()
   elseif app==nil then
      hs.alert.show("fff" )        
      hs.application.launchOrFocusByBundleID(appBundleID)
   else
      hs.alert.show("eee" .. tostring(#app:visibleWindows()) .. app:title())        
      -- app:activate()
      hs.application.launchOrFocusByBundleID(appBundleID)
      app=hs.application.get(appBundleID)
      
      local win=app:mainWindow()
      hs.alert.show("fff"  .. tostring(app) .. appBundleID .. tostring(win))        
      win:raise()
      win:focus()
      
      local wins=app:visibleWindows()
         hs.alert.show("oooooo" )        
      if #wins>0 then
         hs.alert.show("ggg" )        
         for k,win in pairs(wins) do
            if win:isMinimized() then
               win:unminimize()
            end
         end
      else
         hs.alert.show("mmmhhh" )        
         hs.application.open(appBundleID)
         app:activate()
      end
      
   end
end

hs.hotkey.bind({"cmd"}, "E", function() toggleApp("com.apple.finder") end )
hs.hotkey.bind({"cmd"}, "f3", function() toggleApp("com.googlecode.iterm2") end )
hs.hotkey.bind({"cmd"}, "f1", function() toggleApp("com.apple.Safari") end )

function toggleEmacs()        --    toggle emacsclient if emacs daemon not started start it  
   -- local win = hs.window.focusedWindow()
   -- local app = win:application()
   
   local app =hs.application.frontmostApplication()

   -- hs.alert.show("hhh" .. app:title())        
   if app ~= nil and app:title() == "Emacs"  and #app:visibleWindows()>0 and not app:isHidden() then
      app:hide()
   else 
      local app=hs.application.get("Emacs")
      if app then
         local wins=app:allWindows()
         if #wins>0 then
            app:activate()
            for k,win in pairs(wins) do
               if win:isMinimized() then
                  win:unminimize()
               end
            end
            -- app:unhide()
            -- hs.alert.show("e1")        
         else
            -- hs.alert.show("e2")        
            -- ~/.emacs.d/bin/ecexec 是对emacsclient 的包装，你可以直接用emacsclient 来代替
            -- 这个脚本会检查emacs --daemon 是否已启动，未启动则启动之
            hs.execute("~/.emacs.d/bin/ecexec --no-wait -c") -- 创建一个窗口
            -- 这里可能需要等待一下，以确保窗口创建成功后再继续，否则可能窗口不前置
            app=hs.application.get("Emacs")
            if app ~=nil then
               app:activate()      -- 将刚创建的窗口前置
            end
         end
      else
         -- hs.alert.show("notexist")        
         -- ~/.emacs.d/bin/ecexec 是对emacsclient 的包装，你可以直接用emacsclient 来代替
         -- 这个脚本会检查emacs --daemon 是否已启动，未启动则启动之
         hs.execute("~/.emacs.d/bin/ecexec --no-wait -c") -- 创建一个窗口
         -- app=hs.application.get("Emacs")
         -- app:activate()      -- 将刚创建的窗口前置
         
         -- hs.execute("~/.emacs.d/bin/ec")
      end
      -- end
   end
end

-- hs.hotkey.bind({"cmd"}, "D", function() toggleEmacs() end )
hs.urlevent.bind("toggleEmacs", function(eventName, params) toggleEmacs() end)