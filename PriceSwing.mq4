//+------------------------------------------------------------------+
//|                                                    PriceKing.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

/////////////////////////////////////////////////////////
int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

extern ENUM_MA_METHOD MaMethod=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price


extern ENUM_TIMEFRAMES system_time_period = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price

extern ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT;
extern ENUM_TIMEFRAMES MaTimeB = PERIOD_CURRENT;

//extern int MA_W=21;
//extern int MB_W=55;

extern int MA_W=50;
extern int MB_W=10;
/////////////////////////////////////////////////////////

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  ObjectsDeleteAll();
  
  /*
  ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
  ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrRed);
  
   //color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrBlack);    

   //color_up = ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,clrBlack);    
      
   //color_down = ChartGetInteger(ChartID(),CHART_COLOR_CHART_DOWN);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,clrBlack);
   
   //color_bull = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BULL);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,clrBlack);    
      
   //color_bear = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_LINE,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrBlack);
   ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);
          
  */
//--- create timer
   //EventSetTimer(60);
   
   /*
   string sym=Symbol();
   int digits=MarketInfo(sym,MODE_DIGITS);
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int str_len=StringLen(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 5 ) {
   results=StringSubstr(prices,str_len-(digits-2),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }
   
   Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }*/
   
   /*
   string sym=Symbol();
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 2 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-2),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }
   
   Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }*/
   
    string buttonID="ButtonBuySinyal";
 
   for ( int t=1;t<11;t++) {
   buttonID="ButtonSymbolSinyal"+t; // Support LeveL Show
   ObjectDelete(ChartID(),buttonID);                                  
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,330);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,30*t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,150);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,8);   
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   }
   
   

 for ( int t=11;t<21;t++) {
   buttonID="ButtonSymbolSinyal"+t; // Support LeveL Show
   ObjectDelete(ChartID(),buttonID);                                  
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,490);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,30*(t-10));
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,150);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   }
   
 for ( int t=21;t<31;t++) {
   buttonID="ButtonSymbolSinyal"+t; // Support LeveL Show
   ObjectDelete(ChartID(),buttonID);                                  
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,650);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,30*(t-20));
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,150);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   }
   
   

 for ( int t=31;t<41;t++) {
   buttonID="ButtonSymbolSinyal"+t; // Support LeveL Show
   ObjectDelete(ChartID(),buttonID);                                  
   ObjectCreate(ChartID(),buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XDISTANCE,810);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YDISTANCE,30*(t-30));
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_XSIZE,150);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_YSIZE,30);
   ObjectSetString(ChartID(),buttonID,OBJPROP_FONT,"Arial Black");
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,t);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,"BUY");
   }
   
   
   OnTick();
   
   
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

int distance=250;
int distance_multiplier=1; 
ENUM_TIMEFRAMES per=Period();

bool bar5=false;
bool bar4=false;
bool bar3=false;
bool bar2=false;

void OnTick()
  {
//---
   
   //return;
   
   if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) != 1 ) return;
   

       int t=0;
       string pairswl[];
       string sym="";
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //if ( IsTesting() || Tsym == Symbol() ) lengthwl=1;
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
     sym=pairswl[iwl];
     
   t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);     
      
      Print(sym);
      per=Period();
      
 //Sleep(100);
      
      
      int sb=30;
      
      bool first_high_find=false;
      bool first_low_find=false;
      
      int high_swing_pip=0;
      int low_swing_pip=0;
      int high_swing_ma_pip=0;
      int low_swing_ma_pip=0;
      int high_swing_mb_pip=0;
      int low_swing_mb_pip=0;     
      
       
      for (int s=sb;s<1000;s++) {
      
      
      //ObjectDelete("SWHIGH"+s);
      //ObjectDelete("SWLOW"+s);
   
      
      int lsay=0;
      int rsay=0;
      bool find=false;      
      
      double high_price=iHigh(sym,per,s);
      double low_price=iLow(sym,per,s);
      
      
      // Left
      find=false;
      for(int l=s+1;l<s+sb;l++) {
      
      if ( high_price >= iHigh(sym,per,l) && find == false ) {
      lsay=lsay+1;
      } else {
      find=true;
      }      
      
      }

      // Right
      find=false;
      
      for(int l=s-1;l>s-sb;l--) {
      
      if ( l < 0 ) continue;
      
      if ( high_price >= iHigh(sym,per,l) && find == false ) {
      rsay=rsay+1;
      } else {
      find=true;
      }      
      
      }
            
      
      if ( lsay >= 20 && rsay >= 20 
      
      ) {

      
   double swing_high=iHigh(sym,per,s);
   datetime swing_high_time=iTime(sym,per,s);
   
   
   

      // Work Right
      find=false;
      
      for(int l=s-1;l>0;l--) {
 
      if ( iHigh(sym,per,l) < swing_high && find == false ) {
      //rsay=rsay+1;
      } else {
      find=true;
      }      
      
      }
      
        if ( find == false && first_high_find == false  ) { 
        
   //double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, s);
   //double mb=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, s);      
           
        
        first_high_find=true;
      
      if ( Symbol() == sym ) {
      
   string name="SWHIGH"+s;
   ObjectCreate(ChartID(),"SWHIGH"+s,OBJ_TREND,0,swing_high_time,swing_high,swing_high_time+100*PeriodSeconds(),swing_high);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY_RIGHT,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGold);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,(swing_high-Bid)/Point);
   
 
     /*
     ObjectCreate(ChartID(),"MAL"+s,OBJ_TREND,0,Time[s],ma,Time[s]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+s,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+s,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MAL"+s,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MAL"+s,OBJPROP_BACK,true);
     ObjectDelete(ChartID(),"MAL"+s);*/
     }
     
     
   high_swing_pip=(swing_high-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);
   //high_swing_ma_pip=(ma-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);
   //high_swing_mb_pip=(mb-MarketInfo(sym,MODE_BID))/MarketInfo(sym,MODE_POINT);     
     
        
      }
      
      
      
      
      }
      
      
      
      




      lsay=0;
      rsay=0;
      find=false;      
      
      high_price=iHigh(sym,per,s);
      low_price=iLow(sym,per,s);
      
      
      // Left
      find=false;
      for(int l=s+1;l<s+sb;l++) {
      
      if ( low_price <= iLow(sym,per,l) && find == false ) {
      lsay=lsay+1;
      } else {
      find=true;
      }      
      
      }

      // Right
      find=false;
      
      for(int l=s-1;l>s-sb;l--) {
      
      if ( l < 0 ) continue;
      
      if ( low_price <= iLow(sym,per,l) && find == false ) {
      rsay=rsay+1;
      } else {
      find=true;
      }      
      
      }
            
      
      if ( lsay >= 20 && rsay >= 20 
      
      ) {

      
   double swing_low=iLow(sym,per,s);
   datetime swing_low_time=iTime(sym,per,s);
   
   
   

      // Work Right
      find=false;
      
      for(int l=s-1;l>0;l--) {
 
      if ( iLow(sym,per,l) > swing_low && find == false ) {
      //rsay=rsay+1;
      } else {
      find=true;
      }      
      
      }
      
        if ( find == false && first_low_find == false
          ) { 
          
   //double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, s);
   //double mb=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, s);      
             
        
        first_low_find=true;
        
        
        if ( Symbol() == sym ) {
      
   string name="SWLOW"+s;
   ObjectCreate(ChartID(),"SWLOW"+s,OBJ_TREND,0,swing_low_time,swing_low,swing_low_time+100*PeriodSeconds(),swing_low);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY_RIGHT,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGold);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,(Bid-swing_low)/Point);
   

   
     /*
     ObjectCreate(ChartID(),"MAL"+s,OBJ_TREND,0,Time[s],ma,Time[s]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+s,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+s,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MAL"+s,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MAL"+s,OBJPROP_BACK,true);
     ObjectDelete(ChartID(),"MAL"+s);*/
     }
     
     
   low_swing_pip=(MarketInfo(sym,MODE_BID)-swing_low)/MarketInfo(sym,MODE_POINT);
   //low_swing_ma_pip=(MarketInfo(sym,MODE_BID)-ma)/MarketInfo(sym,MODE_POINT);
   //low_swing_mb_pip=(MarketInfo(sym,MODE_BID)-mb)/MarketInfo(sym,MODE_POINT);
        
     

   
      }
      
      
      
      
      }
      
      
            
      
      
      
      
      }
            
      
      if ( high_swing_pip < low_swing_pip ) {

     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" "+high_swing_pip+"/"+low_swing_pip);            
      
      }
      
      if ( low_swing_pip < high_swing_pip ) {
      
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" "+high_swing_pip+"/"+low_swing_pip);      
      
      }
      
 
            //Comment("HighSwingPip:",high_swing_pip,"\n LowSwingPip:",low_swing_pip,"\n HighSwing Ma/Mb:\n",high_swing_ma_pip,"/",high_swing_mb_pip,"\n LowSwing Ma/Mb:\n",low_swing_ma_pip,"/",low_swing_mb_pip);
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
      
continue;      
      
      bar5=false;
      bar4=false;
      bar3=false;
      bar2=false;
      

ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);      

distance=250;
if ( StringFind(sym,"ZAR",0) != -1 ) distance=10000;
if ( StringFind(sym,"MXN",0) != -1 ) distance=2500;
if ( StringFind(sym,"BTC",0) != -1 ) distance=25000;
if ( StringFind(sym,"ETH",0) != -1 ) distance=2500;
if ( StringFind(sym,"DE40",0) != -1 ) distance=500;
if ( StringFind(sym,"XAU",0) != -1 ) distance=500;
if ( StringFind(sym,"BRENT",0) != -1 ) distance=100;
if ( StringFind(sym,"WTI",0) != -1 ) distance=100;
if ( StringFind(sym,"USTECH",0) != -1 ) distance=1000;
if ( StringFind(sym,"US30",0) != -1 ) distance=1000;
if ( StringFind(sym,"EURNZD",0) != -1 ) distance=500;
if ( StringFind(sym,"EURAUD",0) != -1 ) distance=500;

if ( 
     iClose(sym,per,5) > iOpen(sym,per,5) &&
     iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iClose(sym,per,1) > iOpen(sym,per,1) &&
     iOpen(sym,per,0) > iClose(sym,per,0) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,0)-iLow(sym,per,5))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,0)-iLow(sym,per,5))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+5+" "+mesafe);
     bar5=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
     
     
     
if ( bar5 == false ) {
if ( 
     iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iClose(sym,per,1) > iOpen(sym,per,1) &&
     iOpen(sym,per,0) > iClose(sym,per,0) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,0)-iLow(sym,per,4))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,0)-iLow(sym,per,4))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+4+" "+mesafe);
     bar4=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
     
     
     
if ( bar4==false && bar5==false ) {
if ( iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iClose(sym,per,1) > iOpen(sym,per,1) &&
     iOpen(sym,per,0) > iClose(sym,per,0) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,0)-iLow(sym,per,3))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,0)-iLow(sym,per,3))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+3+" "+mesafe);
     bar3=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
     
     

if ( bar4==false && bar5==false && bar3 == false ) {
if ( 
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iClose(sym,per,1) > iOpen(sym,per,1) &&
     iOpen(sym,per,0) > iClose(sym,per,0) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,0)-iLow(sym,per,2))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,0)-iLow(sym,per,2))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+2+" "+mesafe);
     bar2=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
     
  
if ( bar4==false && bar5==false && bar3 == false && bar2==false ) {
if ( 
     iClose(sym,per,1) > iOpen(sym,per,1) &&
     iOpen(sym,per,0) > iClose(sym,per,0) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,0)-iLow(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,0)-iLow(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+1+" "+mesafe);
     bar2=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
     
 
if ( 
     iClose(sym,per,5) < iOpen(sym,per,5) && 
     iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iClose(sym,per,1) < iOpen(sym,per,1) &&
     iOpen(sym,per,0) < iClose(sym,per,0) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,5)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,5)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+5+" "+mesafe);
     bar5=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
     

if ( bar5==false) { 
if ( 
     //iClose(sym,per,5) < iOpen(sym,per,5) && 
     iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iClose(sym,per,1) < iOpen(sym,per,1) &&
     iOpen(sym,per,0) < iClose(sym,per,0) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,4)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,4)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+4+" "+mesafe);
     bar4=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
     }
     
if ( bar5==false && bar4==false) { 
if ( 
     //iClose(sym,per,5) < iOpen(sym,per,5) && 
     //iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iClose(sym,per,1) < iOpen(sym,per,1) &&
     iOpen(sym,per,0) < iClose(sym,per,0) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,3)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,3)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+3+" "+mesafe);
     bar3=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
     }
     
     
if ( bar5==false && bar4==false && bar3==false ) { 
if ( 
     //iClose(sym,per,5) < iOpen(sym,per,5) && 
     //iClose(sym,per,4) < iOpen(sym,per,4) &&
     //iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iClose(sym,per,1) < iOpen(sym,per,1) &&
     iOpen(sym,per,0) < iClose(sym,per,0) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,2)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,2)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+2+" "+mesafe);
     bar2=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
     }
     
     
if ( bar5==false && bar4==false && bar3==false && bar2==false ) { 
if ( 
     //iClose(sym,per,5) < iOpen(sym,per,5) && 
     //iClose(sym,per,4) < iOpen(sym,per,4) &&
     //iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iClose(sym,per,1) < iOpen(sym,per,1) &&
     iOpen(sym,per,0) < iClose(sym,per,0) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,1)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,1)-iClose(sym,per,0))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" L"+1+" "+mesafe);
     //bar1=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
     }
     
     
     
               
     


     

















if ( 
     iClose(sym,per,6) > iOpen(sym,per,6) &&
     iClose(sym,per,5) > iOpen(sym,per,5) &&
     iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,1)-iLow(sym,per,6))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,1)-iLow(sym,per,6))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+5+" "+mesafe);
     bar5=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
     
     
if ( bar5==false ) {
if ( 
     //iClose(sym,per,6) > iOpen(sym,per,6) &&
     iClose(sym,per,5) > iOpen(sym,per,5) &&
     iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,1)-iLow(sym,per,5))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,1)-iLow(sym,per,5))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+4+" "+mesafe);
     bar4=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
     
          

if ( bar5==false && bar4==false ) {
if ( 
     //iClose(sym,per,6) > iOpen(sym,per,6) &&
     //iClose(sym,per,5) > iOpen(sym,per,5) &&
     iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,1)-iLow(sym,per,4))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,1)-iLow(sym,per,4))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+3+" "+mesafe);
     bar3=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
  
  


if ( bar5==false && bar4==false && bar3==false ) {
if ( 
     //iClose(sym,per,6) > iOpen(sym,per,6) &&
     //iClose(sym,per,5) > iOpen(sym,per,5) &&
     //iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,1)-iLow(sym,per,3))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,1)-iLow(sym,per,3))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+2+" "+mesafe);
     bar2=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
  
  
    
if ( bar5==false && bar4==false && bar3==false && bar2==false ) {
if ( 
     //iClose(sym,per,6) > iOpen(sym,per,6) &&
     //iClose(sym,per,5) > iOpen(sym,per,5) &&
     //iClose(sym,per,4) > iOpen(sym,per,4) &&
     //iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,1)-iLow(sym,per,2))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iClose(sym,per,1)-iLow(sym,per,2))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+1+" "+mesafe);
     bar2=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
  
  
  


if ( 
     iClose(sym,per,6) < iOpen(sym,per,6) &&
     iClose(sym,per,5) < iOpen(sym,per,5) &&
     iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,6)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,6)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+5+" "+mesafe);
     bar5=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
      

if ( bar5==false ) {
if ( 
     //iClose(sym,per,6) < iOpen(sym,per,6) &&
     iClose(sym,per,5) < iOpen(sym,per,5) &&
     iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,5)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,5)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+4+" "+mesafe);
     bar4=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }     
}      
      
      
      
if ( bar5==false && bar4==false ) {
if ( 
     //iClose(sym,per,6) < iOpen(sym,per,6) &&
     //iClose(sym,per,5) < iOpen(sym,per,5) &&
     iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,4)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,4)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+3+" "+mesafe);
     bar3=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }     
}      
      
   
if ( bar5==false && bar4==false && bar3==false ) {
if ( 
     //iClose(sym,per,6) < iOpen(sym,per,6) &&
     //iClose(sym,per,5) < iOpen(sym,per,5) &&
     //iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,3)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,3)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+2+" "+mesafe);
     bar2=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }     
}      
      



if ( bar5==false && bar4==false && bar3==false && bar2==false ) {
if ( 
     //iClose(sym,per,6) < iOpen(sym,per,6) &&
     //iClose(sym,per,5) < iOpen(sym,per,5) &&
     //iClose(sym,per,4) < iOpen(sym,per,4) &&
     //iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,2)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,2)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" C"+1+" "+mesafe);
     //bar1=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }     
}      
       
         
        
  
  
      
    continue;


    
       
     
     
if ( iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,1)-iLow(sym,per,4))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {  
     
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" "+3);
     bar3=true;
     } else {
     
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
     
     
     

if ( bar3 == false ) {
if ( //iClose(sym,per,4) > iOpen(sym,per,4) &&
     iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,1)-iLow(sym,per,3))/MarketInfo(sym,MODE_POINT) >= distance*distance_multiplier //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {
     int mesafe=(iClose(sym,per,1)-iLow(sym,per,3))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" "+2+" "+mesafe);
     bar2=true;
     } else {
     
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}


if ( bar2 == false ) {
if ( //iClose(sym,per,4) > iOpen(sym,per,4) &&
     //iClose(sym,per,3) > iOpen(sym,per,3) &&
     iClose(sym,per,2) > iOpen(sym,per,2) &&
     iOpen(sym,per,1) > iClose(sym,per,1) &&
     
     //(iClose(sym,per,1)-iOpen(sym,per,4))/Point >= distance &&
     (iClose(sym,per,1)-iLow(sym,per,2))/MarketInfo(sym,MODE_POINT) >= distance*distance_multiplier //&&
     
     //sell_time!=iTime(sym,per,1)
     
     ) {
     int mesafe=(iClose(sym,per,1)-iLow(sym,per,2))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" "+1+" "+mesafe);
     } else {
     
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }     
}
     
     
          
          
          
     
      
      


if ( iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,4)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,4)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" "+3+" "+mesafe);
     bar3=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
      
      

if ( bar3 == false ) {
if ( //iClose(sym,per,4) < iOpen(sym,per,4) &&
     iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,3)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance*distance_multiplier //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {  
     int mesafe=(iHigh(sym,per,3)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" "+2+" "+mesafe);
     bar2=true;
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
     
     }
}     
     
     

if ( bar2==false ) {
if ( //iClose(sym,per,4) < iOpen(sym,per,4) &&
     //iClose(sym,per,3) < iOpen(sym,per,3) &&
     iClose(sym,per,2) < iOpen(sym,per,2) &&
     iOpen(sym,per,1) < iClose(sym,per,1) &&
     
     //(iOpen(sym,per,4)-iClose(sym,per,1))/Point >= distance &&
     (iHigh(sym,per,2)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT) >= distance*distance_multiplier //&&
     
     //buy_time!=iTime(sym,per,1)
     
     ) {
     int mesafe=(iHigh(sym,per,2)-iClose(sym,per,1))/MarketInfo(sym,MODE_POINT);
     ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
     ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+" "+1+" "+mesafe);
     } else {
     
     //ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrSlateGray);
          
     
     }
     }
     
     
          
     
           
      
      
      continue;
      
      
   int digits=MarketInfo(sym,MODE_DIGITS);
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int str_len=StringLen(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 5 ) {
   results=StringSubstr(prices,str_len-(digits-2),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   if ( MarketInfo(sym,MODE_PROFITCALCMODE) == 0 ) {
   
   int kalan_miktar=0;
   /*if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }*/
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
      
   
   
   t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
      
   
   
   }
   }
   
   
   if ( StringFind(sym,"XAUUSD",0) != -1 ) {
   
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 2 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-2),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   /*if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }*/
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
      
   
t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
   //Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }
   
   
   }
   
   
   
 if ( StringFind(sym,"DE5540",0) != -1 ) {
   
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   string results="";
   if ( digits == 1 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-1),digits);
   
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   /*if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }*/
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
      
   
t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   
  
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
   //Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }
   
   
   }
   
   
 if ( StringFind(sym,"BRENT",0) != -1 || StringFind(sym,"USTECH",0) != -1 || StringFind(sym,"DE40",0) != -1 || StringFind(sym,"US30",0) != -1  || StringFind(sym,"US500",0) != -1 || StringFind(sym,"XAG",0) != -1  ) {
   
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   if ( StringFind(sym,"BRENT",0) != -1 ) prices=prices+0; // Brenth
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   
   string results="";
   if ( digits >= 1 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-1),digits);
   results=StringSubstr(prices,str_len-3,3);
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   /*if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }*/
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
      
   
   
   
   
t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   //Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
   //Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }
   
   
   }
   
   
   
   
  if ( StringFind(SymbolInfoString(sym,SYMBOL_PATH),"Crypto",0) != -1 )   {
   
   int digits=MarketInfo(sym,MODE_DIGITS);
   //digits=5;
   double price=MarketInfo(sym,MODE_BID);
   string prices=DoubleToString(price,digits);
   if ( StringFind(sym,"BRENT",0) != -1 ) prices=prices+0; // Brenth
   int rplc=StringReplace(prices,".","");
   int str_len=StringLen(prices);
   
   //Comment(prices);
   
   string result=StringSubstr(prices,str_len-digits,digits);
   
   string results="";
   if ( digits >= 1 ) {
   digits=5;
   results=StringSubstr(prices,str_len-(digits-1),digits);
   results=StringSubstr(prices,str_len-3,3);
   int price_level=StringToInteger(results);
   double yuzde=NormalizeDouble(price_level/10,2);
   
   int kalan_miktar=0;
   if ( yuzde >= 50 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level;
   }
   
   
   if ( yuzde >= 50 ) { // 500 den büyükse
   //kalan_miktar=1000-price_level;
   
   if ( price_level >= 750 ) {
   kalan_miktar=1000-price_level;
   } else {
   kalan_miktar=price_level-250;
   }
   
   
   
   
   } else {
   //kalan_miktar=price_level;
   
   
   if ( price_level >= 250 ) {
   kalan_miktar=500-price_level;
   } else {
   kalan_miktar=price_level-0;
   }   
   
   
   
   }
   
      
   
   
   
t=t+1;
   string buttonID="ButtonSymbolSinyal"+t;
   ObjectSetString(ChartID(),buttonID,OBJPROP_TEXT,sym+":"+kalan_miktar);
   ObjectSetString(ChartID(),buttonID,OBJPROP_TOOLTIP,sym);
   //Print(sym,":",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   if ( kalan_miktar >= 900 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrRed);
   }
   
   if ( kalan_miktar <= 100 ) {
   ObjectSetInteger(ChartID(),buttonID,OBJPROP_BGCOLOR,clrGreen);
   }
   
   //Comment("Price King:",digits,"/",results,"/",yuzde,"/",kalan_miktar);
   
   }
   
   
   }
   
   
   
   
   
   
   
      
      }
      
   
      
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


if ( StringFind(sparam,"ButtonSymbolSinyal",0) != -1 ) {

string obj_tooltip=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP);

//Alert(obj_tooltip);

//ChartOpen(obj_tooltip,Period());
ChartSetSymbolPeriod(ChartID(),obj_tooltip,Period());

Sleep(100);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,false);


}


   
  }
//+------------------------------------------------------------------+

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///// Symbol Listesi
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int getAvailableCurrencyPairss(string& availableCurrencyPairs[])
{
//---   
   bool selected = false;
   const int symbolsCount = SymbolsTotal(selected);
   int currencypairsCount;
   ArrayResize(availableCurrencyPairs, symbolsCount);
   int idxCurrencyPair = 0;
   for(int idxSymbol = 0; idxSymbol < symbolsCount; idxSymbol++)
     {      
         string symbol = SymbolName(idxSymbol, selected);
         
         //if ( MarketInfo(symbol,MODE_BID) > 0) {
         //if ( MarketInfo(symbol,MODE_PROFITCALCMODE) == 0 ) {
         //Print(idxSymbol,") symbol = ",symbol);
         //}
         //}
         //if(IsTradeAllowed()) {Print(symbol,"Trade allowed");} else {Print(symbol,"Trade not allowed");}
         //Print(symbol,"=",MarketInfo(symbol,MODE_TRADEALLOWED));
         //if( MarketInfo(symbol,MODE_TRADEALLOWED) ) {Print(symbol,"Trade allowed");} else {Print(symbol,"Trade not allowed");}
         
         
         //string firstChar = StringSubstr(symbol, 0, 1);
         //if(firstChar != "#" && StringLen(symbol) == 6)
         availableCurrencyPairs[idxCurrencyPair++] = symbol; 
     
     }
     currencypairsCount = idxCurrencyPair-1;
     
     //Print(idxCurrencyPair); 
     ArrayResize(availableCurrencyPairs, currencypairsCount);
     return currencypairsCount;
}

// Market Watch List - Piyasa Gozlem Kur Listesi
int market_watch_list(string& availableCurrencyPairs[])
{
   int idxCurrencyPair = 0;
   int HowManySymbols=SymbolsTotal(true);
   ArrayResize(availableCurrencyPairs, HowManySymbols);
   string ListSymbols=" ";
   for(int i=0;i<HowManySymbols;i++)
     {
      ListSymbols=StringConcatenate(ListSymbols,SymbolName(i,true),"\n");
      //Print("SymbolName(i,true)",SymbolName(i,true));
      string symbol = SymbolName(i,true);
      
      availableCurrencyPairs[idxCurrencyPair++] = symbol;

      
     }
     
     HowManySymbols=idxCurrencyPair-1;

     //Print("HowManySymbols",HowManySymbols);
    
return HowManySymbols;
    
}     
  
  
  