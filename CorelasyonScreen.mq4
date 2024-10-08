//+------------------------------------------------------------------+
//|                                                   Corelasyon.mq4 |
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
  
  ObjectsDeleteAll(ChartID(),-1,-1);
  
  for(int i=1;i<Bars;i++) {
  
   
  string   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent())))+" 01:17"; 
  datetime some_time = StringToTime(yenitarih); 
  
  some_time=Time[i];
  
  
  //Print(some_time);
  
  int limit=10;
  
  string sym1="EURUSD";
  string sym2="GBPUSD";
  string sym3="EURGBP";

  if ( Symbol () == "EURUSD" ) {
  sym1="EURJPY";
  sym2="USDJPY";  
  sym3="EURUSD";
  limit=100;
  }
  
  
    
    
  
  int shift=iBarShift(sym1,PERIOD_M1,some_time);
  
  
  ObjectCreate(ChartID(),"CTIME",OBJ_VLINE,0,some_time,Ask);
  
  double sym1prc=iClose(sym1,PERIOD_M1,shift);
  double sym2prc=iClose(sym2,PERIOD_M1,shift);
  double sym3prc=iClose(sym3,PERIOD_M1,shift);
  
  
  //if ( Symbol() == sym1 ) ObjectCreate(ChartID(),"CPRICE",OBJ_HLINE,0,some_time,sym1prc);
  //if ( Symbol() == sym2 ) ObjectCreate(ChartID(),"CPRICE",OBJ_HLINE,0,some_time,sym2prc);
  //if ( Symbol() == sym3 ) ObjectCreate(ChartID(),"CPRICE",OBJ_HLINE,0,some_time,sym3prc);
     
  double sym4prc=DivZero(sym1prc,sym2prc);
     
  //if ( Symbol() == sym3 ) ObjectCreate(ChartID(),"CREALPRICE",OBJ_HLINE,0,some_time,sym4prc);
  
  Comment(sym4prc/Point);
  
  if ( sym4prc > sym3prc ) {
  
  double fark=(sym4prc-sym3prc);
  int pip=fark/Point;
  //Comment("EUR BUY,GBP SELL:",pip); 
  Comment(sym1," BUY,",sym2," SELL:",pip);
  
  if ( pip >= limit ) ObjectCreate(ChartID(),"CTIME"+some_time,OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"CTIME"+some_time,OBJPROP_COLOR,clrLimeGreen);
  }
  
  if ( sym4prc < sym3prc ) {
  
  double fark=(sym3prc-sym4prc);
  int pip=fark/Point;  
  Comment(sym1," SELL,",sym2," BUY:",pip);  
  
  if ( pip >= limit )  ObjectCreate(ChartID(),"CTIME"+some_time,OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"CTIME"+some_time,OBJPROP_COLOR,clrCrimson);
  
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

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
