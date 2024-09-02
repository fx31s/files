//+------------------------------------------------------------------+
//|                                                    PairSpeed.mq4 |
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
   
   ObjectsDeleteAll();
   

  string   yenitarihs= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent())))+" 00:00"; 
  //string   yenitarihs= TimeYear(TimeCurrent())+".05.02 03:03"; 
  datetime some_times = StringToTime(yenitarihs); 
  
  some_times = some_times - PeriodSeconds()*1440;
  
  
     
     int shift=iBarShift(Symbol(),PERIOD_M1,some_times);
     
     Print(some_times,"/",shift);
   
   
   string sym1="EURUSD";
   string sym2="GBPUSD";


if ( Symbol() == ".USTECHCash" ) {
   sym1=".USTECHCash";
   sym2=".US500Cash";  
}    

if ( Symbol() == "NAS100" ) {
   sym1="NAS100";
   sym2="SP500";  
}   


if ( Symbol() == "XAUUSD" ) {
   sym1="XAUUSD";
   sym2="XAGUSD";  
}
   
if ( Symbol() == "EURJPY" ) {   
   sym1="EURJPY";
   sym2="USDJPY";  
}
     
   
   
   ENUM_TIMEFRAMES per=PERIOD_M1;
   
   bool find=false;
   
   for (int i=1;i<shift;i++) {
   
   if ( find==true)continue;
   
   int shift_1=iBarShift(sym1,PERIOD_M1,Time[i]);
   int shift_2=iBarShift(sym2,PERIOD_M1,Time[i]);
   
   int shifts_1=iBarShift(sym1,PERIOD_M1,Time[1]);
   int shifts_2=iBarShift(sym2,PERIOD_M1,Time[1]);

    
   
   //int shift_2=iBarShift(sym2,PERIOD_M1,iTime(sym2,PERIOD_M1,i));
   
   double sym1_op=iOpen(sym1,per,shift_1);
   double sym1_cp=iClose(sym1,per,shifts_1);
   
   double sym2_op=iOpen(sym2,per,shift_2);
   double sym2_cp=iClose(sym2,per,shifts_2);
      
 double farks=(sym1_cp-sym1_op);
  int pips=farks/MarketInfo(sym1,MODE_POINT);      

  double fark=(sym2_cp-sym2_op);
  int pip=fark/MarketInfo(sym2,MODE_POINT);
  
  //Print(i,"/",pips,"/",pip,"/",pips-pip);
  

if ( MathAbs(pips-pip) >= 500 ) {


if ( pips < 0 && pip < 0 ) {

if ( pips > pip ) {

Alert(Symbol(),"EUR SELL","USD BUY");

}

if ( pips < pip ) {

Alert(Symbol(),"EUR BUY","USD SELL");

}


}



if ( pips > 0 && pip > 0 ) {

if ( pips > pip ) {

Alert(Symbol(),"EUR BUY","USD SELL");

}

if ( pips < pip ) {

Alert(Symbol(),"EUR SELL","USD BUY");

}


}







/*
//if ( sym1_cp > sym2_cp && pips > pip ) {
if ( sym1_cp > sym2_cp && pips > pip ) {

Alert("EURSELL"," - USDBUY");

}

//if ( sym2_cp > sym1_cp && pip > pips ) {
if ( sym2_cp > sym1_cp && pip > pips ) {

Alert("EURBUY"," - USDSELL");


}
*/




//if ( pips >= 600 ) {

//ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);

ObjectCreate(ChartID(),"TLINE"+i,OBJ_TREND,0,Time[1],Ask,Time[i],Open[i]);
ObjectSetInteger(ChartID(),"TLINE"+i,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLINE"+i,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"TLINE"+i,OBJPROP_STYLE,STYLE_DOT);

if ( pip > 0 ) {
ObjectCreate(ChartID(),"TLINES"+i,OBJ_TREND,0,Time[1],Ask-(pip*Point),Time[i],Open[i]);
ObjectSetInteger(ChartID(),"TLINES"+i,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLINES"+i,OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),"TLINES"+i,OBJPROP_STYLE,STYLE_DOT);
}

if ( pip < 0 ) {
ObjectCreate(ChartID(),"TLINESS"+i,OBJ_TREND,0,Time[1],Ask+(pip*Point),Time[i],Open[i]);
ObjectSetInteger(ChartID(),"TLINESS"+i,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLINESS"+i,OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),"TLINESS"+i,OBJPROP_STYLE,STYLE_DOT);
}

Print("pip",pip,"/ pips:",pips);

find=true;

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
   
  }
//+------------------------------------------------------------------+
