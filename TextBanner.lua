-- TextBanner.lua

-- TextBanner is a text elem with a background
-- supported background types are round,square,back (for back buttons),bottomRound,topRound

TextBanner = class(RectObj)

function TextBanner:init(text,x,y,w,h,args)
    RectObj.init(self,x,y,w,h)

    args = args or {}
    args.text = args.text or {}
    args.text.textMode = args.text.textMode or CENTER
    args.text.fill = args.te