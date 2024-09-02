//+------------------------------------------------------------------+
//|                                                     Session8.mq4 |
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

ENUM_TIMEFRAMES per=PERIOD_H1;

bool touch=true;

int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
   //ENUM_TIMEFRAMES per=PERIOD_H1;
   
   for(int i=1;i<500;i++) {
   
   
   //if ( TimeHour(iTime(Symbol(),PERIOD_H1,i)) == 7 ) {
   //if ( TimeHour(iTime(Symbol(),PERIOD_H1,i)) == 6 ) {
   if ( TimeHour(iTime(Symbol(),PERIOD_H1,i)) == 9 ) {
   
   string name="V"+i;
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Time[i],Ask);
   
   name="TH"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,i),iHigh(Symbol(),PERIOD_H1,i),iTime(Symbol(),PERIOD_H1,i-1),iHigh(Symbol(),PERIOD_H1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   

   name="TL"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,i),iLow(Symbol(),PERIOD_H1,i),iTime(Symbol(),PERIOD_H1,i-1),iLow(Symbol(),PERIOD_H1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   

   name="TE"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,i-1),iHigh(Symbol(),PERIOD_H1,i),iTime(Symbol(),PERIOD_H1,i-1),iLow(Symbol(),PERIOD_H1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   
   datetime end_time=iTime(Symbol(),PERIOD_H1,i-1);
   
   int end_shift=iBarShift(Symbol(),per,end_time);

   datetime start_time=iTime(Symbol(),PERIOD_H1,i);
   
   int start_shift=iBarShift(Symbol(),per,start_time);
   
   
      

   name="V"+i;
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Time[end_shift],Ask);
      

   double high_price=iHigh(Symbol(),PERIOD_H1,i);
   double low_price=iLow(Symbol(),PERIOD_H1,i);
   

   
bool find_high=false;   
bool find_low=false;

//ENUM_TIMEFRAMES per=PERIOD_H1;

for ( int b=end_shift-1;b>0;b--) {

if ( find_high == false ) {
if ( (iLow(Symbol(),per,b) > high_price || touch == false ) &&
 iOpen(Symbol(),per,b) > high_price && iClose(Symbol(),per,b) > high_price ) {
find_high=true;

   name="RH"+b;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),per,b),iOpen(Symbol(),per,b),iTime(Symbol(),per,b)+100*PeriodSeconds(),iClose(Symbol(),per,b));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
  
   name="RHT"+b;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),per,start_shift),iOpen(Symbol(),per,b),iTime(Symbol(),per,b)+100*PeriodSeconds(),iClose(Symbol(),per,b));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSteelBlue);

}
}

if ( find_low == false ) {
if ( (iHigh(Symbol(),per,b) < low_price || touch == false ) && 

iOpen(Symbol(),per,b) < low_price && iClose(Symbol(),per,b) < low_price ) {
find_low=true;

   name="RL"+b;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),per,b),iOpen(Symbol(),per,b),iTime(Symbol(),per,b)+100*PeriodSeconds(),iClose(Symbol(),per,b));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
  
     name="RLT"+b;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),per,start_shift),iOpen(Symbol(),per,b),iTime(Symbol(),per,b)+100*PeriodSeconds(),iClose(Symbol(),per,b));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSteelBlue);

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
int saat=9;
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
Print(sparam);

if ( int(sparam) >= 1 && int(sparam) <= 10 ) {
saat=int(sparam);
Session8(sparam);
Comment(sparam);
}


if ( int(sparam) == 11 ) {
saat=saat+1;
if ( saat == 23 ) saat=0;
Session8(saat);
Comment(saat);
}


if ( sparam == 25 ) {

if ( per == PERIOD_M5 ) {per=PERIOD_H1;} else {per=PERIOD_M5;}
Session8(saat);
}

if ( sparam == 20 ) {

if ( touch == true ) {touch=false;} else { touch=true;}

Comment("Touch:",touch);
Session8(saat);
}

   
  }
//+------------------------------------------------------------------+


void Session8(int hour) {

ObjectsDeleteAll();
   
   //ENUM_TIMEFRAMES per=PERIOD_H1;
   
   
   for(int i=1;i<500;i++) {
   
   
   //if ( TimeHour(iTime(Symbol(),PERIOD_H1,i)) == 7 ) {
   //if ( TimeHour(iTime(Symbol(),PERIOD_H1,i)) == 6 ) {
   if ( TimeHour(iTime(Symbol(),PERIOD_H1,i)) == hour ) {
   
   string name="V"+i;
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Time[i],Ask);
   
   name="TH"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,i),iHigh(Symbol(),PERIOD_H1,i),iTime(Symbol(),PERIOD_H1,i-1),iHigh(Symbol(),PERIOD_H1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   

   name="TL"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,i),iLow(Symbol(),PERIOD_H1,i),iTime(Symbol(),PERIOD_H1,i-1),iLow(Symbol(),PERIOD_H1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   

   name="TE"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_H1,i-1),iHigh(Symbol(),PERIOD_H1,i),iTime(Symbol(),PERIOD_H1,i-1),iLow(Symbol(),PERIOD_H1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   
   datetime end_time=iTime(Symbol(),PERIOD_H1,i-1);
   
   int end_shift=iBarShift(Symbol(),per,end_time);

   datetime start_time=iTime(Symbol(),PERIOD_H1,i);
   
   int start_shift=iBarShift(Symbol(),per,start_time);
   
   
      

   name="V"+i;
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Time[end_shift],Ask);
      

   double high_price=iHigh(Symbol(),PERIOD_H1,i);
   double low_price=iLow(Symbol(),PERIOD_H1,i);
   

   
bool find_high=false;   
bool find_low=false;

for ( int b=end_shift-1;b>0;b--) {

if ( find_high == true && find_low == true ) continue;

if ( find_high == false ) {
if ( ( iLow(Symbol(),per,b) > high_price || touch == true ) &&
 iOpen(Symbol(),per,b) > high_price && iClose(Symbol(),per,b) > high_price ) {
find_high=true;

   name="RH"+b;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),per,b),iOpen(Symbol(),per,b),iTime(Symbol(),per,b)+100*PeriodSeconds(),iClose(Symbol(),per,b));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
  
   name="RHT"+b;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),per,start_shift),iOpen(Symbol(),per,b),iTime(Symbol(),per,b)+100*PeriodSeconds(),iClose(Symbol(),per,b));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSteelBlue);
   

}
}

if ( find_low == false ) {
if ( (iHigh(Symbol(),per,b) < low_price || touch == true )  && 

iOpen(Symbol(),per,b) < low_price && iClose(Symbol(),per,b) < low_price ) {
find_low=true;

   name="RL"+b;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),per,b),iOpen(Symbol(),per,b),iTime(Symbol(),per,b)+100*PeriodSeconds(),iClose(Symbol(),per,b));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
  
   name="RLT"+b;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),per,start_shift),iOpen(Symbol(),per,b),iTime(Symbol(),per,b)+100*PeriodSeconds(),iClose(Symbol(),per,b));
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSteelBlue);
     

}
}




}
   
 
   
   }
   
   
   
   
   
   
   
   
   
   
   
   }
   
   }