//+------------------------------------------------------------------+
//|                                                       Resize.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

  int ChartWidth = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
 int ChartHeight = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
 
   int ChartMainWidth = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
  int ChartMainHeight = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
  
  input bool AutoButtonResize=true; // Chart Ekranina Otomatik Yerlestirme


  long chart_active = 0;

bool OBJECTHIDE = false;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
 
 
   string buttonID="ControlPanel";
   
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,300);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,30);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,297);   
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,185);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,215);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,250);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   buttonID="ControlPanelBack";
   ObjectDelete(0,buttonID);   
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrSeaGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,295);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,59);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,289);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,147);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,182);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,217);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrMidnightBlue);
   
   
   buttonID="ControlPanelText";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,33);
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
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrLimeGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,155);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,33);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"HARVESTER EA");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);   
   
   buttonID="OnlyBuy";
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   
   
         

   buttonID="CloseAllSell";
   ObjectDelete(0,buttonID);
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
   
   


  

   buttonID="CloseProfitBuy";
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   
   
      

   buttonID="CloseProfitSell";
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
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
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlack);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,MarketInfo(Symbol(),MODE_MINLOT));
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
      

   buttonID="Down";
   ObjectDelete(0,buttonID);
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
   
   
   
   
   
         

   buttonID="CloseAllBuyPen";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close All Buy Pen");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="CloseAllSellPen";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Close All Sell Pen");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   

   buttonID="UpPoint";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLimeGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
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



   buttonID="EditPoint";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlack);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,100);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
      

   buttonID="DownPoint";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrange);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,125);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,205);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"-");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_ALIGN,ALIGN_CENTER);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="ClearTP";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,25);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"CTP");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   

   buttonID="MartinGale";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,260);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"MartinGale");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   

   buttonID="Downer";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,55);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,45);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Downer");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 


   buttonID="SetTP";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Set TP");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      
   

   buttonID="UsdProfit";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLimeGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"$");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 



   buttonID="MartinGaleProfit";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_EDIT,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,170);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,40);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"100");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
      

   buttonID="PipsProfit";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrange);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,125);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,240);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,20);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"P");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_ALIGN,ALIGN_CENTER);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);    




   buttonID="ControlPanelP";
   
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrNavy);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,300);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,330);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,297);   
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,185);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,215);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,182);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   buttonID="ControlPanelBackP";
   ObjectDelete(0,buttonID);   
   ObjectCreate(0,buttonID,OBJ_RECTANGLE_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrSeaGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,295);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,359);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,289);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,147);
   //ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,182);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,147);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   ObjectSetInteger(0,buttonID,OBJPROP_BORDER_COLOR,clrMidnightBlue);
   

  
   buttonID="ControlPanelTextP";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,333);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Result Table");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,False);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);      
   
   buttonID="ControlPanelTextsP";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_LABEL,0,300,300);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrLimeGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrMidnightBlue);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,145);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,333);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,150);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");   
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"PROFIT & LOT");
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,13);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER);   
   
      
   

   buttonID="BuyLot";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,365);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Buy");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="BuyLotTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,365);
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

   buttonID="BuyProfitTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrChartreuse);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,365);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
      



   buttonID="SellLot";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,400);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Sell");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="SellLotTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,400);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="SellProfitTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrOrangeRed);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,400);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   





   buttonID="BsLot";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,435);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Result");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="BsLotTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,435);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="BsProfitTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightSlateGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,435);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   





   buttonID="TodayLot";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,290);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,470);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"Today");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="TodayLotTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrGreen);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,195);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,470);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 

   buttonID="TodayProfitTotal";
   ObjectDelete(0,buttonID);
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrBlack);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrLightSlateGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,100);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,470);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"");
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_RIGHT_UPPER); 
   
   
   
   
   long cid=ChartID();
   
   
   //return 0;
   
   
   
   
int heightScreen=ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
int widthScreen=ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);

Comment("Height:",heightScreen,"Width:",widthScreen);

string obje_listesi="ButtonSinyal";

       int obj_total=ObjectsTotal(cid);
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(cid,i);
     
//int indexof = StringFind(name,obje_listesi, 0);
//if ( indexof != -1 ) continue;

//if(ObjectType(name)!=OBJ_BUTTON || name == "ButtonSHOWHIDE") continue;
if(ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_LABEL && ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_BUTTON && ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_RECTANGLE_LABEL && ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_EDIT) continue;
//if(ObjectGetInteger(cid,name,OBJPROP_TYPE) == OBJ_FIBO ) continue;

int ObjWidth = ObjectGetInteger(cid,name,OBJPROP_XSIZE,0);
int ObjHeight = ObjectGetInteger(cid,name,OBJPROP_YSIZE,0);
int ObjX = ObjectGetInteger(cid,name,OBJPROP_XDISTANCE,0);
int ObjY = ObjectGetInteger(cid,name,OBJPROP_YDISTANCE,0);
int ObjFont = ObjectGetInteger(cid,name,OBJPROP_FONTSIZE,0);
//Print(i," object - ",name,"Size:",ButtonWidth,"/",ButtonHeight,"Sinyal:",obje_listesi,"indexof",indexof);

int oran=150;

int ObjWidthOran = DivZero(ObjWidth,100)*oran;
int ObjHeightOran = DivZero(ObjHeight,100)*oran;
int ObjFontOran = DivZero(ObjFont,100)*oran;
int ObjXOran = DivZero(ObjX,100)*oran;
int ObjYOran = DivZero(ObjY,100)*oran;


int ChartWidths=ObjWidthOran;
int ChartHeights=ObjHeightOran;
int ChartFonts=ObjFontOran;
int ChartXs=ObjXOran;
int ChartYs=ObjYOran;

 ObjectSetInteger(cid,name,OBJPROP_XSIZE,ChartWidths);
 ObjectSetInteger(cid,name,OBJPROP_YSIZE,ChartHeights);
 ObjectSetInteger(cid,name,OBJPROP_FONTSIZE,ChartFonts);
 ObjectSetInteger(cid,name,OBJPROP_XDISTANCE,ChartXs);
 ObjectSetInteger(cid,name,OBJPROP_YDISTANCE,ChartYs);
 //ObjectSetInteger(cid,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
 
 
     
     
     
     
     }


   
   
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


  if(id==CHARTEVENT_CHART_CHANGE) {
  
  /*
  
  if ( ChartGetInteger(0,CHART_BRING_TO_TOP) == 1 ) {
  
  //if ( ( ChartWidth != ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0) || ChartHeight != ChartGetInteger(chart_active,CHART_HEIGHT_IN_PIXELS,0) ) && AutoButtonResize ) {
  if ( ( MathAbs(ChartMainWidth - ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0)) > 30 || MathAbs(ChartMainHeight - ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0)) > 30 ) ) {
  
  //Alert(chart_active,"Chart Width:",ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0),"/",ChartMainWidth,"Height:",ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0),"/",ChartMainHeight);

 ChartMainWidth = ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);
 ChartMainHeight = ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);

  if ( AutoButtonResize ) Yerlestir(0,"ButtonSinyal",2);

 }
  
  }
  
  */
  
  }
  
  

  if ( id == 9 || id==CHARTEVENT_CHART_CHANGE ) {
  
  //Alert(id);
  
  //if ( scrollchart == true ) ChartMove();
  
  }
  
  
  
   
  }
//+------------------------------------------------------------------+

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Yerlestir
//////////////////////////////////////////////////////////////////////////////////////////////////////////////
void Yerlestir(long cid,string obje_listesi,int ChartResizeOran) {

int ChartWidthLimit = ChartWidth /ChartResizeOran;
int ChartWidths = 20;
int ChartHeightLimit = ChartHeight /ChartResizeOran;
int ChartHeights = 50;

//long cid=0;
//cid = chart_active;

/*
     if ( ObjectGetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT) == "SHOW" ) {
     OBJECTHIDE=true;//ObjectSetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT,"HIDE");
     Print("Gizle");
     ObjectSetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT,"HIDE");
     } else {
     Print("Goster");
     OBJECTHIDE=false;
     ObjectSetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT,"SHOW");     
     //if ( ObjectGetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT) == "HIDE" ) OBJECTHIDE=false;//ObjectSetString(cid,"ButtonSHOWHIDE",OBJPROP_TEXT,"SHOW");
     }*/
     
/*
   //--- The number of windows on the chart (at least one main window is always present) 
   int windows=(int)ChartGetInteger(cid,CHART_WINDOWS_TOTAL); 
   //--- Check all windows 
   for(int w=0;w<windows;w++) 
     { 
      //--- the number of indicators in this window/subwindow 
      int total=ChartIndicatorsTotal(cid,w); 
      //--- Go through all indicators in the window 
      for(int i=0;i<total;i++) 
        { 
         //--- get the short name of an indicator 
         string name=ChartIndicatorName(cid,w,i);
         

Print(name);   

int indexof = StringFind(name,"yay", 0);

     if ( indexof != -1 ) ChartIndicatorDelete(cid,w,name); 
     
     //IndicatorSetInteger

//if ( OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
//if ( !OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 );


         
        } 
     }
     
     */

/*
       int obj_totali=ChartIndicatorsTotal(cid,0);
  string namei;
  for(int i=0;i<obj_totali;i++)
    {
     namei = ChartIndicatorName(cid,i,0);
     
     Print(i," indicator - ",namei);
    
     
if ( OBJECTHIDE ) ObjectSetInteger(cid,namei, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
if ( !OBJECTHIDE ) ObjectSetInteger(cid,namei, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 );
     
     
     }*/
  

Print(chart_active); 
 
       int obj_total=ObjectsTotal(cid);
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(cid,i);
     //Print(i," object - ",name);





/*int OBJ_PERIOD

if ( Period() == PERIOD_M5 ) OBJ_PERIOD=OBJ_PERIOD_M5;
if ( Period() == PERIOD_M15 ) OBJ_PERIOD=OBJ_PERIOD_M15;
if ( Period() == PERIOD_M30 ) OBJ_PERIOD=OBJ_PERIOD_M30;
if ( Period() == PERIOD_H1 ) OBJ_PERIOD=OBJ_PERIOD_H1;*/

int indexof = StringFind(name,obje_listesi, 0);
if ( indexof != -1 ) continue;
//if(ObjectType(name)!=OBJ_BUTTON || name == "ButtonSHOWHIDE") continue;
if(ObjectGetInteger(cid,name,OBJPROP_TYPE) != OBJ_BUTTON ) continue;
if(ObjectGetInteger(cid,name,OBJPROP_TYPE) == OBJ_FIBO ) continue;

int ButtonWidth = ObjectGetInteger(cid,name,OBJPROP_XSIZE,0);
int ButtonHeight = ObjectGetInteger(cid,name,OBJPROP_YSIZE,0);
//Print(i," object - ",name,"Size:",ButtonWidth,"/",ButtonHeight,"Sinyal:",obje_listesi,"indexof",indexof);



 ObjectSetInteger(cid,name,OBJPROP_XDISTANCE,ChartWidths);
 ObjectSetInteger(cid,name,OBJPROP_YDISTANCE,ChartHeights);
 ObjectSetInteger(cid,name,OBJPROP_CORNER,CORNER_LEFT_UPPER);
   
ChartWidths = ChartWidths + 5 + ButtonWidth;

if ( ChartWidths > ChartWidthLimit ) { ChartWidths = 50;ChartHeights=ChartHeights+5+ButtonHeight;}

if ( OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
if ( !OBJECTHIDE ) ObjectSetInteger(cid,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 );




    }




}
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
