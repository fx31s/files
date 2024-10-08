//+------------------------------------------------------------------+
//|                                                   SmartMoney.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double Ortalama;


ENUM_TIMEFRAMES zaman[9];

bool pause=false;

datetime mnt;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
        /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
  }
  ////////////////////////////   
   
   
   if ( pause == true ) {
   
   return(INIT_SUCCEEDED);
   
   }
      
   
   
   if ( ChartID() != ChartFirst() ) {
   
   if ( ObjectFind(ChartID(),"Draw") == -1 ) {      
   Analiz();
   ObjectCreate(ChartID(),"Draw",OBJ_ARROW,0,Time[0],Ask);
   }
   return INIT_SUCCEEDED;
   }
   
   
ObjectsDeleteAll();

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
   
   

   int bss=-1;
   
  zaman[0]=PERIOD_M1;
  zaman[1]=PERIOD_M5;
  zaman[2]=PERIOD_M15;
  zaman[3]=PERIOD_M30;
  zaman[4]=PERIOD_H1;
  zaman[5]=PERIOD_H4;
  zaman[6]=PERIOD_D1;
  zaman[7]=PERIOD_W1;
  zaman[8]=PERIOD_MN1;   
   
   
      string pairswls[];
      int lengthwls = market_watch_list(pairswls);
      //Alert(lengthwl);
      //lengthwls=0;
      
    
      
      
      for(int iwl=0; iwl <= lengthwls; iwl++)
      {
      
      string sym=pairswls[iwl];
      
      //bss=0;
      
      
  for(int z=0;z<ArraySize(zaman);z++) {
  
  

ENUM_TIMEFRAMES per=Period();
  per=zaman[z];        
      
      bss=bss+1;

   string buttonID="ButtonSinyal"+bss; // Support LeveL Show
   
   string text=sym+" "+TFtoStr(per)+" "+iwl;
   color renk=clrGreen;

   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,renk);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,10+(125*z));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,10+(25*iwl));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,120);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);    
  
  
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,text);
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,TFtoStr(per));
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER);  
   
         



   double high_prc;
   double low_prc;
   int high_shift;
   int low_shift;
   //bool low_fnd=false;
   //bool high_fnd=false;
   
   bool low_fnd_hl=false;
   bool high_fnd_hl=false;   

   bool low_fnd_lh=false;
   bool high_fnd_lh=false;   
      
   
   bool low_to_high=true;
   bool high_to_low=true;
   
   double low_to_high_level=0;
   double high_to_low_level=0;
   
   bool low_to_high_find=false;
   bool high_to_low_find=false;
   
   
   int BarData=800;
   
   //if ( Bars(Symbol(),Period()) < BarData ) BarData=Bars(Symbol(),Period())-50;
   
   if ( Bars(sym,per) < BarData ) BarData=Bars(sym,per)-50;
   
   if ( BarData > 800 ) BarData=800;
   
   for (int i=1;i<BarData;i++) {
   
   
   
   //string sym=Symbol();
   //ENUM_TIMEFRAMES per=Period();
   

   double high_price=iHigh(sym,per,i);
   double high_prices=iHigh(sym,per,i-1);
   
   double low_price=iLow(sym,per,i);
   double low_prices=iLow(sym,per,i-1);
   
    double open_price=iOpen(sym,per,i);
   double open_prices=iOpen(sym,per,i-1);
   
    double close_price=iClose(sym,per,i);
   double close_prices=iClose(sym,per,i-1);
   
   
if ( low_to_high == true && high_to_low_find == false 
) {

  int low_say=0;
   bool find=false; 

for(int s=i+1;s<i+105;s++) {

if ( s > BarData ) continue;

   if ( find == true ) continue;
   
   if ( iLow(sym,per,i) <= iLow(sym,per,s) ) {
   low_say=low_say+1;    
   } else {
   find=true;
   }

}


   int lowr_say=0;
   bool findr=false; 

for(int s=i-1;s>i-25;s--) {

if ( s < 0 ) {
lowr_say=lowr_say+15;
continue;
}

   if ( findr == true ) continue;
   
   if ( iLow(sym,per,i) <= iLow(sym,per,s) ) {
   lowr_say=lowr_say+1;    
   } else {
   findr=true;
   }

}



if ( lowr_say >= 20 && low_say >= 100 &&   ( low_fnd_lh == false || low_prc > iLow(sym,per,i) ) 

) {
  /* ObjectCreate(ChartID(),"VVLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VVLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VVLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   */
   low_prc=iLow(sym,per,i);
   low_shift=i;
   low_fnd_lh=true;
 }      
   
      
   
      
    int high_say=0;
   find=false; 

for(int s=i+1;s<i+105;s++) {

if ( s > BarData ) continue;

   if ( find == true ) continue;
   
   if ( iHigh(sym,per,i) > iHigh(sym,per,s) ) {
   high_say=high_say+1;    
   } else {
   find=true;
   }

}


   int highr_say=0;
   findr=false; 
   

for(int s=i-1;s>i-105;s--) {

if ( s < 0 ) {
//highr_say=highr_say+10;
continue;
}


   if ( findr == true ) continue;
   
   if ( iHigh(sym,per,i) > iHigh(sym,per,s) ) {
   highr_say=highr_say+1;    
   } else {
   findr=true;
   }

}


if ( highr_say >= 100 && high_say >= 100 && high_fnd_lh == false && low_fnd_lh == true ) {
   /*ObjectCreate(ChartID(),"VLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   */
   high_prc=iHigh(sym,per,i);
   high_shift=i;
   high_fnd_lh=true;

   low_to_high_find=true;
   
   /*ObjectCreate(ChartID(),"HHLINE"+(Time[i]),OBJ_HLINE,0,Time[i],high_prc);
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);  
   
   ObjectCreate(ChartID(),"LLLINE"+(Time[i]),OBJ_HLINE,0,Time[i],low_prc);
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);        
   
   ObjectCreate(ChartID(),"SwingLH",OBJ_TREND,0,Time[high_shift],high_prc,Time[low_shift],low_prc);
   ObjectSetInteger(ChartID(),"SwingLH",OBJPROP_RAY,False);

   ObjectCreate(ChartID(),"SwingEqLH",OBJ_TREND,0,Time[high_shift],low_prc+DivZero(high_prc-low_prc,2),Time[low_shift],low_prc+DivZero(high_prc-low_prc,2));
   ObjectSetInteger(ChartID(),"SwingEqLH",OBJPROP_RAY,True);
   ObjectSetInteger(ChartID(),"SwingEqLH",OBJPROP_COLOR,clrBlue);*/
   
   

   double live_price=MarketInfo(sym,MODE_BID)-low_prc;
   
   //double live_price=high_prc-Bid;
   
   //double yuzde=DivZero(high_prc-low_prc,100);
   
   double yuzde=DivZero(high_prc-low_prc,100);

   double oran=DivZero(live_price,yuzde);   
   
   low_to_high_level=oran;
   
   
   //ObjectSetString(ChartID(),"SwingLH",OBJPROP_TOOLTIP,oran);
   
   
   
   
    
   }
   
   }
   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//if ( high_to_low == true && low_to_high_find == false ) {
if ( high_to_low == true  ) {

 
      
    int high_say=0;
   bool find=false; 

for(int s=i+1;s<i+105;s++) {

if ( s > BarData ) continue;

   if ( find == true ) continue;
   
   if ( iHigh(sym,per,i) > iHigh(sym,per,s) ) {
   high_say=high_say+1;    
   } else {
   find=true;
   }

}


   int highr_say=0;
   bool findr=false; 
   

for(int s=i-1;s>i-25;s--) {

if ( s < 0 ) {
highr_say=highr_say+15;
continue;
}


   if ( findr == true ) continue;
   
   if ( iHigh(sym,per,i) > iHigh(sym,per,s) ) {
   highr_say=highr_say+1;    
   } else {
   findr=true;
   }

}


if ( highr_say >= 20 && high_say >= 100 && ( high_fnd_hl == false || high_prc < iHigh(sym,per,i) )  ) {
  /* ObjectCreate(ChartID(),"VLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);*/   
   high_prc=iHigh(sym,per,i);
   high_shift=i;
   high_fnd_hl=true;
   
  
   }
   
   
   
   


  int low_say=0;
   find=false; 

for(int s=i+1;s<i+105;s++) {

if ( s > BarData ) continue;

   if ( find == true ) continue;
   
   if ( iLow(sym,per,i) <= iLow(sym,per,s) ) {
   low_say=low_say+1;    
   } else {
   find=true;
   }

}


   int lowr_say=0;
   findr=false; 

for(int s=i-1;s>i-105;s--) {

if ( s < 0 ) {
//high_say=high_say+10;
continue;
}

   if ( findr == true ) continue;
   
   if ( iLow(sym,per,i) <= iLow(sym,per,s) ) {
   lowr_say=lowr_say+1;    
   } else {
   findr=true;
   }

}



if ( lowr_say >= 100 && low_say >= 100 && low_fnd_hl == false && high_fnd_hl == true

) {
  /* ObjectCreate(ChartID(),"VVLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VVLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VVLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   */
   low_prc=iLow(sym,per,i);
   low_shift=i;
   low_fnd_hl=true;
   

   high_to_low_find=true;
   
   
 /*  
   ObjectCreate(ChartID(),"HHLINE"+(Time[i]),OBJ_HLINE,0,Time[i],high_prc);
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);  
   
   ObjectCreate(ChartID(),"LLLINE"+(Time[i]),OBJ_HLINE,0,Time[i],low_prc);
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);     
   
   
   ObjectCreate(ChartID(),"SwingHL",OBJ_TREND,0,Time[low_shift],low_prc,Time[high_shift],high_prc);
   ObjectSetInteger(ChartID(),"SwingHL",OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"SwingHL",OBJPROP_WIDTH,1);
   

   ObjectCreate(ChartID(),"SwingEqHL",OBJ_TREND,0,Time[low_shift],low_prc+DivZero(high_prc-low_prc,2),Time[high_shift],low_prc+DivZero(high_prc-low_prc,2));
   ObjectSetInteger(ChartID(),"SwingEqHL",OBJPROP_RAY,True);
   ObjectSetInteger(ChartID(),"SwingEqHL",OBJPROP_COLOR,clrBlue);*/
   

   //double live_price=Bid-low_prc;
   
   //live_price=high_prc-Bid;
   
   double live_price=high_prc-MarketInfo(sym,MODE_BID);
   
   //double live_price=MarketInfo(sym,MODE_BID)-low_prc;
   
   //double yuzde=DivZero(high_prc-low_prc,100);
   
   double yuzde=DivZero((high_prc-low_prc),100);

   double oran=DivZero(live_price,yuzde);   
   
   high_to_low_level=oran;
   
   
   //ObjectSetString(ChartID(),"SwingHL",OBJPROP_TOOLTIP,oran);
      
   
 }      
   
         
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   }
   

   
   }
   





































text=sym+" "+TFtoStr(per)+" "+int(high_to_low_level)+" "+int(low_to_high_level);
ObjectSetString(0,buttonID,OBJPROP_TEXT,text);

if ( high_to_low_level > 20 && high_to_low_level < 30 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrCrimson);
if ( high_to_low_level > 40 && high_to_low_level < 60 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrCrimson);
      
if ( low_to_high_level > 20 && low_to_high_level < 30 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlue);
if ( low_to_high_level > 40 && low_to_high_level < 60 ) ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrBlue);
       
      
      
      }
      
      
      }
      
      
      
         
   
   
   
   
   
   
   
   
   
   return INIT_SUCCEEDED;
   
   Ortalama=BarOrtalama(1,300,Symbol(),Period());
   Comment("Ortalama:",Ortalama);
   
   
   
   
   ObjectsDeleteAll();
   
   int bs=0;
   
  zaman[0]=PERIOD_M1;
  zaman[1]=PERIOD_M5;
  zaman[2]=PERIOD_M15;
  zaman[3]=PERIOD_M30;
  zaman[4]=PERIOD_H1;
  zaman[5]=PERIOD_H4;
  zaman[6]=PERIOD_D1;
  zaman[7]=PERIOD_W1;
  zaman[8]=PERIOD_MN1;   
   
   
      string pairswl[];
      int lengthwl = market_watch_list(pairswl);
      //Alert(lengthwl);
      //lengthwl=0;
      
  for(int z=0;z<ArraySize(zaman);z++) {
  
  if ( z > 0 ) continue;

int per=Period();
  per=zaman[z];      
      
      
      for(int iwl=0; iwl <= lengthwl; iwl++)
      {
      
      string sym=pairswl[iwl];
      //if ( z == 0 && StringFind(sym,"XAU",0) == -1 ) continue;
      



    
    Ortalama=BarOrtalama(1,300,sym,per);
    
    
    
    for (int i=2;i<300;i++) {
    
 
 
  
  //if ( iClose(sym,per,1) > iOpen(sym,per,1) && iOpen(sym,per,2) > iClose(sym,per,2) && iOpen(sym,per,3) > iClose(sym,per,3) && iOpen(sym,per,4) > iClose(sym,per,4) ) {
  //if ( iClose(sym,per,2) < iClose(sym,per,3) && iClose(sym,per,3) < iClose(sym,per,4)  ) { 
  

  if ( DivZero((iClose(sym,per,i) - iOpen(sym,per,i)),Ortalama) >= 5 //&& iOpen(sym,per,2) > iClose(sym,per,2)
     ) {   
     
  if ( DivZero((iOpen(sym,per,i-1) - iClose(sym,per,i-1)),Ortalama) >= 2 || DivZero((iClose(sym,per,i-1) - iOpen(sym,per,i-1)),Ortalama) >= 2 
     ) {        
  
  bs=bs+1; 
  //Print(bs+" "+sym+" "+TFtoStr(per));
  
  int d=0;
  bool find=false;
  /*
  for (int s=i;s<20;s++) {
  
  if ( find == true ) continue;
  
  if ( iOpen(sym,per,s) > iClose(sym,per,s) ) {d=d+1;} else {find=true;}
  
  }     */  
  
   string buttonID="ButtonSinyal"+bs; // Support LeveL Show
   
   string text=sym+" "+TFtoStr(per)+" "+i;
   color renk=clrGreen;
   



   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,renk);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,50+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);    
  
  
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,text);
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,TFtoStr(per));
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER);   
  
  
  
  }
  }
  /*
  if ( iOpen(sym,per,1) > iClose(sym,per,1) && iClose(sym,per,2) > iOpen(sym,per,2) && iClose(sym,per,3) > iOpen(sym,per,3) && iClose(sym,per,4) > iOpen(sym,per,4) ) {
  if ( iClose(sym,per,2) > iClose(sym,per,3) > iClose(sym,per,3) > iClose(sym,per,4)  ) {*/
  
  if ( DivZero((iOpen(sym,per,i) - iClose(sym,per,i)),Ortalama) >= 5 //&& iOpen(sym,per,2) > iClose(sym,per,2)
     ) {   
     
  if ( DivZero((iOpen(sym,per,i-1) - iClose(sym,per,i-1)),Ortalama) >= 2 || DivZero((iClose(sym,per,i-1) - iOpen(sym,per,i-1)),Ortalama) >= 2
     ) {      
  
  
  
  bs=bs+1;
//  Print(bs+" "+sym+" "+TFtoStr(per));  
  
  int d=0;
  bool find=false;
  /*
  for (int s=i;s<20;s++) {
  
  if ( find == true ) continue;
  
  if ( iClose(sym,per,s) > iOpen(sym,per,s) ) {d=d+1;} else {find=true;}
  
  }  */
  
  
   string buttonID="ButtonSinyal"+bs; // Support LeveL Show
   
   string text=sym+" "+TFtoStr(per)+" "+i;
   color renk=clrLimeGreen;


   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,renk);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,50+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,90);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);   
   
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,text);
   ObjectSetString(0,buttonID,OBJPROP_TOOLTIP,TFtoStr(per));
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER);      
  
  }
  }

  }
  
  
  }
  
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


if ( sparam == 45 ) {
ObjectsDeleteAll(ChartID(),-1,-1);
OnInit();
}


if ( sparam == 25 ) {

if ( pause == true ) { pause=false;} else {pause=true;}

Comment("Pause:",pause);

}




if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE) {

string last_select_objectr=sparam;

//Alert(last_select_objectr);


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          if ( obj_prc1 > obj_prc2 ) {
          
          //Alert(last_select_objectr);
          
          double fark=obj_prc1-obj_prc2;
          
          for(int i=1;i<4;i++) {
          
          ObjectDelete(ChartID(),last_select_objectr+"LEVEL"+i);
          ObjectCreate(ChartID(),last_select_objectr+"LEVEL"+i,OBJ_TREND,0,Time[shift1],obj_prc1+(fark*i),Time[shift2],obj_prc1+(fark*i));
          if ( i == 2 ) ObjectSetInteger(ChartID(),last_select_objectr+"LEVEL"+i,OBJPROP_WIDTH,2);
          ObjectDelete(ChartID(),last_select_objectr+"LEVELD"+i);
          ObjectCreate(ChartID(),last_select_objectr+"LEVELD"+i,OBJ_TREND,0,Time[shift1],obj_prc2-(fark*i),Time[shift2],obj_prc2-(fark*i));
          if ( i == 2 ) ObjectSetInteger(ChartID(),last_select_objectr+"LEVELD"+i,OBJPROP_WIDTH,2);   
          
          
          }
          
          
          
          }
          

          if ( obj_prc2 > obj_prc1 ) {
          
          //Alert(last_select_objectr);
          
          double fark=obj_prc2-obj_prc1;
          
          for(int i=1;i<4;i++) {
          
          ObjectDelete(ChartID(),last_select_objectr+"LEVEL"+i);
          ObjectCreate(ChartID(),last_select_objectr+"LEVEL"+i,OBJ_TREND,0,Time[shift1],obj_prc2+(fark*i),Time[shift2],obj_prc2+(fark*i));
          if ( i == 2 ) ObjectSetInteger(ChartID(),last_select_objectr+"LEVEL"+i,OBJPROP_WIDTH,2);
          ObjectDelete(ChartID(),last_select_objectr+"LEVELD"+i);
          ObjectCreate(ChartID(),last_select_objectr+"LEVELD"+i,OBJ_TREND,0,Time[shift1],obj_prc1-(fark*i),Time[shift2],obj_prc1-(fark*i));
          if ( i == 2 ) ObjectSetInteger(ChartID(),last_select_objectr+"LEVELD"+i,OBJPROP_WIDTH,2);    
          
          
          }
          
          
          
          }
          
          
          
          
          
          
          }



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND) {

string last_select_objectr=sparam;

//Alert(last_select_objectr);


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          
          if ( obj_prc2 > obj_prc1 ) {
          
          
          ObjectMove(ChartID(),last_select_objectr,1,obj_time2,High[shift2]);
          ObjectMove(ChartID(),last_select_objectr,0,obj_time1,Low[shift1]);
          
          double fark=High[shift2]-Low[shift1];
          
          int i=shift1;
          int shift=shift2;


/*
   ObjectCreate(ChartID(),"TLINE"+(Time[i]),OBJ_TREND,0,Time[shift],High[shift],Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_STYLE,STYLE_SOLID);
   //if ( work == false )ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
   */
   ObjectDelete(ChartID(),"TTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],Low[i]+(fark/2),mnt,Low[i]+(fark/2));
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   //if ( work == false )ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);

   
   ObjectDelete(ChartID(),"TTTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],Low[i]+(fark/4),mnt,Low[i]+(fark/4));
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);

   ObjectDelete(ChartID(),"TTTTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTTTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],High[shift]-(fark/4),mnt,High[shift]-(fark/4));
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
             
          
          
          
          }



       if ( obj_prc1 > obj_prc2 ) {
          
          
          ObjectMove(ChartID(),last_select_objectr,1,obj_time2,Low[shift2]);
          ObjectMove(ChartID(),last_select_objectr,0,obj_time1,High[shift1]);
          
          double fark=High[shift1]-Low[shift2];
          
          int i=shift2;
          int shift=shift1;


/*
   ObjectCreate(ChartID(),"TLINE"+(Time[i]),OBJ_TREND,0,Time[shift],High[shift],Time[i],Low[i]);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_STYLE,STYLE_SOLID);
   //if ( work == false )ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]),OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
   */
   ObjectDelete(ChartID(),"TTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],Low[i]+(fark/2),mnt,Low[i]+(fark/2));
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   //if ( work == false )ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);

   
   ObjectDelete(ChartID(),"TTTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],Low[i]+(fark/4),mnt,Low[i]+(fark/4));
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);

   ObjectDelete(ChartID(),"TTTTLINE"+last_select_objectr);
   ObjectCreate(ChartID(),"TTTTLINE"+last_select_objectr,OBJ_TREND,0,Time[shift],High[shift]-(fark/4),mnt,High[shift]-(fark/4));
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_BACK,True);
   //ObjectSetInteger(ChartID(),"TTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),"TTTTLINE"+last_select_objectr,OBJPROP_RAY,False);
   //ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
             
          
          
          
          }
          
          
                    
          
          
          
          
          
          }


if ( sparam == 45 ) OnInit();


if ( ObjectType(sparam) == OBJ_BUTTON ) {
string text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);
string tooltip=ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP);


   string sep=" ";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(text,u_sep,results);
   
   //Alert(results[0]);
   

string sym=text;
int rplc=StringReplace(sym,tooltip,"");
 rplc+=StringReplace(sym," ","");
 
 for (int i=0;i<20;i++) {
 rplc+=StringReplace(sym,i,"");
 }
 

//Alert("Sym:",sym,"/ Text:",text,"/ Tooltip:",tooltip);

//Alert(text,"/--",tooltip);

int shift=results[2];

ENUM_TIMEFRAMES per=StrtoTF(tooltip);

sym=results[0];

long chartID=ChartOpen(sym,per);

ObjectCreate(chartID,"VLINE",OBJ_VLINE,0,iTime(sym,per,shift),Ask);
/*
ObjectCreate(chartID,"HLINEH",OBJ_HLINE,0,iTime(sym,per,shift-1),iHigh(sym,per,shift-1));
ObjectCreate(chartID,"HLINEL",OBJ_HLINE,0,iTime(sym,per,shift-1),iLow(sym,per,shift-1));
ObjectCreate(chartID,"HLINEO",OBJ_HLINE,0,iTime(sym,per,shift-1),iOpen(sym,per,shift-1));
ObjectCreate(chartID,"HLINEC",OBJ_HLINE,0,iTime(sym,per,shift-1),iClose(sym,per,shift-1));
*/
ObjectCreate(chartID,"HLINEH",OBJ_TREND,0,iTime(sym,per,shift-1),iHigh(sym,per,shift-1),iTime(sym,per,0),iHigh(sym,per,shift-1));
ObjectCreate(chartID,"HLINEL",OBJ_TREND,0,iTime(sym,per,shift-1),iLow(sym,per,shift-1),iTime(sym,per,0),iLow(sym,per,shift-1));
ObjectCreate(chartID,"HLINEO",OBJ_TREND,0,iTime(sym,per,shift-1),iOpen(sym,per,shift-1),iTime(sym,per,0),iOpen(sym,per,shift-1));
ObjectCreate(chartID,"HLINEC",OBJ_TREND,0,iTime(sym,per,shift-1),iClose(sym,per,shift-1),iTime(sym,per,0),iClose(sym,per,shift-1));

ObjectSetInteger(chartID,"HLINEH",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(chartID,"HLINEL",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(chartID,"HLINEO",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(chartID,"HLINEC",OBJPROP_COLOR,clrBlack);


Sleep(100);
Comment(text);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);




}

   
  }
//+------------------------------------------------------------------+


//////////////////////////////////////////////////////////
ENUM_TIMEFRAMES StrtoTF(string sinyal_sym_periyod){
ENUM_TIMEFRAMES Chart_Config_per=-1;
//sinyal_sym_periyod=StringToUpper(sinyal_sym_periyod);
   if ( sinyal_sym_periyod == "M1" ) Chart_Config_per = PERIOD_M1;
   if ( sinyal_sym_periyod == "M5" ) Chart_Config_per = PERIOD_M5;
   if ( sinyal_sym_periyod == "M15" ) Chart_Config_per = PERIOD_M15;
   if ( sinyal_sym_periyod == "M30" ) Chart_Config_per = PERIOD_M30;
   if ( sinyal_sym_periyod == "H1" ) Chart_Config_per = PERIOD_H1;
   if ( sinyal_sym_periyod == "H4" ) Chart_Config_per = PERIOD_H4;
   if ( sinyal_sym_periyod == "D1" ) Chart_Config_per = PERIOD_D1;
   if ( sinyal_sym_periyod == "W1" ) Chart_Config_per = PERIOD_W1;
   if ( sinyal_sym_periyod == "MN1" ) Chart_Config_per = PERIOD_MN1;
return Chart_Config_per;
}

string TFtoStr(int period) {
 switch(period) {
  case 1     : return("M1");  break;
  case 5     : return("M5");  break;
  case 15    : return("M15"); break;
  case 30    : return("M30"); break;
  case 60    : return("H1");  break;
  case 240   : return("H4");  break;
  case 1440  : return("D1");  break;
  case 10080 : return("W1");  break;
  case 43200 : return("MN1"); break;
  default    : 0;//return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader
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
  
  
  
   int ortalama_last_bar= -1;

 
double BarOrtalama(int StartVisibleBar,int FinishVisibleBarLenght,string Sym,int Per) { 

///FinishVisibleBarLenght=PERIOD_W1/Period();
//Print("FinishVisibleBarLenght",FinishVisibleBarLenght);
///if ( FinishVisibleBarLenght > Bars ) FinishVisibleBarLenght=Bars;



if ( ortalama_last_bar == WindowFirstVisibleBar() && StartVisibleBar == -1 ) return Ortalama;


if ( ortalama_last_bar != WindowFirstVisibleBar() ) {
ortalama_last_bar = WindowFirstVisibleBar();
}

//Print("FinishVisibleBarLenght2",FinishVisibleBarLenght);


int mumanaliz_shift;
int mumanaliz_shiftb;

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   
   
   if ( StartVisibleBar != -1 ) mumanaliz_shift=StartVisibleBar;
   
   if ( FinishVisibleBarLenght != -1 ) mumanaliz_shiftb=mumanaliz_shift+FinishVisibleBarLenght;
   
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   //bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   ///bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   bar_pip = bar_pip + MathAbs(iClose(Sym,Per,t)-iOpen(Sym,Per,t));
   
   }
  
   
   bar_ortalama = bar_pip / bar_toplam;
   
   return bar_ortalama;

}
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 



void Analiz() {



   
   ObjectsDeleteAll();
   
   
   double high_prc;
   double low_prc;
   int high_shift;
   int low_shift;
   //bool low_fnd=false;
   //bool high_fnd=false;
   
   bool low_fnd_hl=false;
   bool high_fnd_hl=false;   

   bool low_fnd_lh=false;
   bool high_fnd_lh=false;   
      
   
   bool low_to_high=true;
   bool high_to_low=true;
   
   bool low_to_high_find=false;
   bool high_to_low_find=false;
   
   //for (int i=1;i<800;i++) {
   
   int BarData=800;
   
   if ( Bars(Symbol(),Period()) < BarData ) BarData=Bars(Symbol(),Period())-50;
   
   if ( BarData > 800 ) BarData=800;
   
   for (int i=1;i<BarData;i++) {
   
   
      
   
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   

   double high_price=iHigh(sym,per,i);
   double high_prices=iHigh(sym,per,i-1);
   
   double low_price=iLow(sym,per,i);
   double low_prices=iLow(sym,per,i-1);
   
    double open_price=iOpen(sym,per,i);
   double open_prices=iOpen(sym,per,i-1);
   
    double close_price=iClose(sym,per,i);
   double close_prices=iClose(sym,per,i-1);
   
   
if ( low_to_high == true && high_to_low_find == false 
) {

  int low_say=0;
   bool find=false; 

for(int s=i+1;s<i+105;s++) {

if ( s > BarData ) continue;

   if ( find == true ) continue;
   
   if ( iLow(sym,per,i) <= Low[s] ) {
   low_say=low_say+1;    
   } else {
   find=true;
   }

}


   int lowr_say=0;
   bool findr=false; 

for(int s=i-1;s>i-25;s--) {

if ( s < 0 ) {
lowr_say=lowr_say+15;
continue;
}

   if ( findr == true ) continue;
   
   if ( iLow(sym,per,i) <= Low[s] ) {
   lowr_say=lowr_say+1;    
   } else {
   findr=true;
   }

}



if ( lowr_say >= 20 && low_say >= 100 &&   ( low_fnd_lh == false || low_prc > Low[i]) 

) {
   ObjectCreate(ChartID(),"VVLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VVLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VVLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   
   low_prc=Low[i];
   low_shift=i;
   low_fnd_lh=true;
 }      
   
      
   
      
    int high_say=0;
   find=false; 

for(int s=i+1;s<i+105;s++) {

if ( s > BarData ) continue;

   if ( find == true ) continue;
   
   if ( iHigh(sym,per,i) > High[s] ) {
   high_say=high_say+1;    
   } else {
   find=true;
   }

}


   int highr_say=0;
   findr=false; 
   

for(int s=i-1;s>i-105;s--) {

if ( s < 0 ) {
//highr_say=highr_say+10;
continue;
}


   if ( findr == true ) continue;
   
   if ( iHigh(sym,per,i) > High[s] ) {
   highr_say=highr_say+1;    
   } else {
   findr=true;
   }

}


if ( highr_say >= 100 && high_say >= 100 && high_fnd_lh == false && low_fnd_lh == true ) {
   ObjectCreate(ChartID(),"VLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   
   high_prc=High[i];
   high_shift=i;
   high_fnd_lh=true;

   low_to_high_find=true;
   
   ObjectCreate(ChartID(),"HHLINE"+(Time[i]),OBJ_HLINE,0,Time[i],high_prc);
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);  
   
   ObjectCreate(ChartID(),"LLLINE"+(Time[i]),OBJ_HLINE,0,Time[i],low_prc);
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);        
   
   ObjectCreate(ChartID(),"SwingLH",OBJ_TREND,0,Time[high_shift],high_prc,Time[low_shift],low_prc);
   ObjectSetInteger(ChartID(),"SwingLH",OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"SwingLH",OBJPROP_SELECTABLE,True);
   ObjectSetInteger(ChartID(),"SwingLH",OBJPROP_SELECTED,True);      

   ObjectCreate(ChartID(),"SwingEqLH",OBJ_TREND,0,Time[high_shift],low_prc+DivZero(high_prc-low_prc,2),Time[low_shift],low_prc+DivZero(high_prc-low_prc,2));
   ObjectSetInteger(ChartID(),"SwingEqLH",OBJPROP_RAY,True);
   ObjectSetInteger(ChartID(),"SwingEqLH",OBJPROP_COLOR,clrBlue);
   
   

   double live_price=Bid-low_prc;
   
   //double live_price=high_prc-Bid;
   
   //double yuzde=DivZero(high_prc-low_prc,100);
   
   double yuzde=DivZero(high_prc-low_prc,100);

   double oran=DivZero(live_price,yuzde);   
   
   
   ObjectSetString(ChartID(),"SwingLH",OBJPROP_TOOLTIP,oran);
   
   
   
   
    
   }
   
   }
   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////




//if ( high_to_low == true && low_to_high_find == false ) {
if ( high_to_low == true  ) {

 
      
    int high_say=0;
   bool find=false; 

for(int s=i+1;s<i+105;s++) {

if ( s > BarData ) continue;

   if ( find == true ) continue;
   
   if ( iHigh(sym,per,i) > High[s] ) {
   high_say=high_say+1;    
   } else {
   find=true;
   }

}


   int highr_say=0;
   bool findr=false; 
   

for(int s=i-1;s>i-25;s--) {

if ( s < 0 ) {
highr_say=highr_say+15;
continue;
}


   if ( findr == true ) continue;
   
   if ( iHigh(sym,per,i) > High[s] ) {
   highr_say=highr_say+1;    
   } else {
   findr=true;
   }

}


if ( highr_say >= 20 && high_say >= 100 && ( high_fnd_hl == false || high_prc < High[i]

)  ) {
   ObjectCreate(ChartID(),"VLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   
   high_prc=High[i];
   high_shift=i;
   high_fnd_hl=true;
   
  
   }
   
   
   
   


  int low_say=0;
   find=false; 

for(int s=i+1;s<i+105;s++) {

if ( s > BarData ) continue;

   if ( find == true ) continue;
   
   if ( iLow(sym,per,i) <= Low[s] ) {
   low_say=low_say+1;    
   } else {
   find=true;
   }

}


   int lowr_say=0;
   findr=false; 

for(int s=i-1;s>i-105;s--) {

if ( s < 0 ) {
//high_say=high_say+10;
continue;
}

   if ( findr == true ) continue;
   
   if ( iLow(sym,per,i) <= Low[s] ) {
   lowr_say=lowr_say+1;    
   } else {
   findr=true;
   }

}



if ( lowr_say >= 100 && low_say >= 100 && low_fnd_hl == false && high_fnd_hl == true

) {
   ObjectCreate(ChartID(),"VVLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VVLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VVLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   
   low_prc=Low[i];
   low_shift=i;
   low_fnd_hl=true;
   

   high_to_low_find=true;
   
   
   
   ObjectCreate(ChartID(),"HHLINE"+(Time[i]),OBJ_HLINE,0,Time[i],high_prc);
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_WIDTH,4);  
   ObjectSetInteger(ChartID(),"HHLINE"+(Time[i]),OBJPROP_COLOR,clrBlue);  
   
   ObjectCreate(ChartID(),"LLLINE"+(Time[i]),OBJ_HLINE,0,Time[i],low_prc);
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);     
   ObjectSetInteger(ChartID(),"LLLINE"+(Time[i]),OBJPROP_WIDTH,4);  
   
   ObjectCreate(ChartID(),"SwingHL",OBJ_TREND,0,Time[low_shift],low_prc,Time[high_shift],high_prc);
   ObjectSetInteger(ChartID(),"SwingHL",OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"SwingHL",OBJPROP_WIDTH,4);
   ObjectSetInteger(ChartID(),"SwingHL",OBJPROP_SELECTABLE,True);
   ObjectSetInteger(ChartID(),"SwingHL",OBJPROP_SELECTED,True);      
   

   ObjectCreate(ChartID(),"SwingEqHL",OBJ_TREND,0,Time[low_shift],low_prc+DivZero(high_prc-low_prc,2),Time[high_shift],low_prc+DivZero(high_prc-low_prc,2));
   ObjectSetInteger(ChartID(),"SwingEqHL",OBJPROP_RAY,True);
   ObjectSetInteger(ChartID(),"SwingEqHL",OBJPROP_COLOR,clrBlue);
   
  RefreshRates();

   //double live_price=Bid-low_prc;
   
   double live_price=high_prc-Bid;
   
   //double yuzde=DivZero(high_prc-low_prc,100);
   
   double yuzde=DivZero((high_prc-low_prc),100);

   double oran=DivZero(live_price,yuzde);   
   
   
   ObjectSetString(ChartID(),"SwingHL",OBJPROP_TOOLTIP,"HL:"+oran+"/"+(live_price/Point)+"/"+((high_prc-low_prc)/Point));
      
   
 }      
   
         
   
   
   
   
   
   
   
   
   
   
   
   
   
   
   }
   




























   
   
   
   
   }
   
   

}