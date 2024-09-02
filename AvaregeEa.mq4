//+------------------------------------------------------------------+
//|                                                    AvaregeEa.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   string buttonID="ControlPanel";
   

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,300);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,30);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,297);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,185);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   buttonID="ControlPanelText";

   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,35);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Control Panel");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);      
   
   buttonID="ControlPanelTexts";

   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrLimeGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,35);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"GRID EA");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);   
   
   buttonID="OnlyBuy";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,65);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Only Buy");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="Any";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,65);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"ANY");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      
   buttonID="OnlySell";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,65);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Only Sell");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      
      

   buttonID="CloseAllBuy";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close All Buy");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="Run";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,43);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Bold");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Run");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="Pause";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,148);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,43);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Pause");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
         

   buttonID="OnlyAllSell";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Bold");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close All Sell");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   


  

   buttonID="Close Profit Buy";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close Profit Buy");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
   buttonID="BuyZone";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,43);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"BUY      ");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,3);
   
    
    
   buttonID="BuyZoneLabel";

   ObjectCreate(0,buttonID,OBJ_LABEL,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_FILL,True);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,175);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,14);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"zone");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,1);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrAqua);
      

   buttonID="BuyZoneAutoLabel";

   ObjectCreate(0,buttonID,OBJ_LABEL,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_FILL,True);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,174);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,152);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,14);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"auto");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,1);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrAqua);
   
   
      
      

   buttonID="SellZone";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,148);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,43);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"SELL     ");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      


   buttonID="SellZoneLabel";

   ObjectCreate(0,buttonID,OBJ_LABEL,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_FILL,True);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,127);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,14);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"zone");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,1);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrAqua);
      

   buttonID="SellZoneAutoLabel";

   ObjectCreate(0,buttonID,OBJ_LABEL,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_FILL,True);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,127);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,152);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,14);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"auto");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_ZORDER,1);
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrAqua);
   
   
      

   buttonID="Close Profit Sell";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,135);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close Profit Sell");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
              

   buttonID="Buy";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"BUY 0");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="Sell";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"SELL 0");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   

   buttonID="Up";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrAqua);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"+");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 



   buttonID="Edit";

   ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlack);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,39);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"0.01");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
      

   buttonID="Down";

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,125);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"-");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
         
   
       
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//--- destroy timer
   EventKillTimer();
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
