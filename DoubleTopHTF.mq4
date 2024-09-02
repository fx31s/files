//+------------------------------------------------------------------+
//|                                                 DoubleTopHTF.mq4 |
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
   
   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();   
   
   Comment(sym);
   
   
   //for (int i=Bars-100;i>7;i--) {
   for (int i=500;i>7;i--) {
   
   ////////////////////////////
   // Left
   ////////////////////////////
   
   double high_price=iHigh(sym,per,i);
   double op_price=iOpen(sym,per,i);
   double cl_price=iClose(sym,per,i);
   double low_price=iLow(sym,per,i);
   
   
   if ( iClose(sym,per,i+5) > iOpen(sym,per,i+5) && iClose(sym,per,i+4) < iOpen(sym,per,i+4) && iClose(sym,per,i+3) > iOpen(sym,per,i+3) && iClose(sym,per,i+2) < iOpen(sym,per,i+2) && iClose(sym,per,i+1) < iOpen(sym,per,i+1) ) {

      ObjectCreate(ChartID(),"RUP"+i,OBJ_RECTANGLE,0,Time[i],Close[i+5],Time[i]-5*PeriodSeconds(),High[i+5]);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrDarkGray);    
      
     
   
}


   if ( iClose(sym,per,i+5) > iOpen(sym,per,i+5) && iClose(sym,per,i+4) < iOpen(sym,per,i+4) && iClose(sym,per,i+3) > iOpen(sym,per,i+3) && iClose(sym,per,i+2) > iOpen(sym,per,i+2) && iClose(sym,per,i+1) < iOpen(sym,per,i+1) ) {

      ObjectCreate(ChartID(),"RUP"+i,OBJ_RECTANGLE,0,Time[i],Close[i+5],Time[i]-5*PeriodSeconds(),High[i+5]);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_BACK,true);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_STYLE,STYLE_DOT);  
      ObjectSetInteger(ChartID(),"RUP"+i,OBJPROP_COLOR,clrLightGray);    
      
     
   
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
