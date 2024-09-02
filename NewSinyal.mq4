//+------------------------------------------------------------------+
//|                                                    NewSinyal.mq4 |
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
//---

ObjectsDeleteAll();

string sym=Symbol();
ENUM_TIMEFRAMES per=PERIOD_CURRENT;


for (int i=1;i<500;i++){


if ( iHigh(sym,per,i+1) > iClose(sym,per,i) && iClose(sym,per,i+1) < iClose(sym,per,i) && iOpen(sym,per,i+1) < iClose(sym,per,i) &&  iOpen(sym,per,i) < iClose(sym,per,i) 

 &&  iOpen(sym,per,i+1) > iClose(sym,per,i+1)

) {

ObjectCreate(ChartID(),"SHORT"+i,OBJ_TREND,0,Time[i],Close[i],Time[i]+10*PeriodSeconds(),Close[i]);
ObjectSetInteger(ChartID(),"SHORT"+i,OBJPROP_RAY,false);


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
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
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
