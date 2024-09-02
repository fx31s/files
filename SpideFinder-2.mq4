//+------------------------------------------------------------------+
//|                                                  SpideFinder.mq4 |
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
  
  
  string sym=Symbol();
  ENUM_TIMEFRAMES per=Period();
//--- create timer

   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
   for (int i=Bars-500;i>0;i--) {
   
   double high_price=iHigh(sym,per,i);
   double low_price=iLow(sym,per,i);
   double open_price=iOpen(sym,per,i);
   double close_price=iClose(sym,per,i);
   
   if ( close_price > open_price ) {
   
   if ( (open_price-low_price)/Point > 5 ) {
   
   
   int total_spike=0;
   int shift=0;
   bool low_down_open_close = false;
   
   
   for(int r=i+1;r<i+10;r++){
   
   double high_prices=iHigh(sym,per,r);
   double low_prices=iLow(sym,per,r);
   double open_prices=iOpen(sym,per,r);
   double close_prices=iClose(sym,per,r);
   
//////////////////////////////////////////////////////////////////   
   if ( close_prices > open_prices ) {
   
   if ( (open_prices-low_prices)/Point > 5 && low_prices < open_price && open_prices > low_price && close_prices > low_price) {
   total_spike=total_spike+1;
   shift=r;
   }
  
   }
   
   
   if ( open_prices > close_prices ) {
   
   if ( (close_prices-low_prices)/Point > 5 && low_prices < open_price && open_prices > low_price && close_prices > low_price) {
   total_spike=total_spike+1;
   shift=r;
   }
   
   }
      
//////////////////////////////////////////////////////////////////      
      
   if ( close_prices > open_prices //&& total_spike < 2
    ) {
   
   if ( open_prices < low_price && close_prices < low_price ) {   
   low_down_open_close=true;   
   }
   
   
   }
   

   
   if ( open_prices > close_prices //&& total_spike < 2
   ) {
   
   if ( open_prices < low_price && close_prices < low_price ) {   
   low_down_open_close=true;   
   }
   
   }
   
   
   
         
      
   
   
   
   }
   
   
   if ( total_spike >= 2 && low_down_open_close == false ) {
   
   if ( close_price > open_price ) {
   ObjectCreate(ChartID(),"V"+i,OBJ_RECTANGLE,0,Time[i],open_price,Time[shift],low_price);
   
   ObjectCreate(ChartID(),"VT"+i,OBJ_TREND,0,Time[i],close_price,Time[shift]+50*PeriodSeconds(),close_price);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_COLOR,clrChartreuse);
   
   
   //ObjectCreate(ChartID(),"VL"+i,OBJ_VLINE,0,Time[i],Ask);
   }
   
   
   }
   
   
   
   }
   
   }
   
   
   
   
   if ( open_price >= close_price ) {
   
   if ( (close_price-low_price)/Point > 5 ) {
   //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   



   int total_spike=0;
   int shift=0;
   bool low_down_open_close = false;
   
   
   for(int r=i+1;r<i+10;r++){
   
   double high_prices=iHigh(sym,per,r);
   double low_prices=iLow(sym,per,r);
   double open_prices=iOpen(sym,per,r);
   double close_prices=iClose(sym,per,r);
   
//////////////////////////////////////////////////////////////////   
   if ( close_prices > open_prices ) {
   
   if ( (open_prices-low_prices)/Point > 5 && low_prices < close_price && open_prices > low_price && close_prices > low_price) {
   total_spike=total_spike+1;
   shift=r;
   }
  
   }
   
   
   if ( open_prices > close_prices ) {
   
   if ( (close_prices-low_prices)/Point > 5 && low_prices < close_price && open_prices > low_price && close_prices > low_price) {
   total_spike=total_spike+1;
   shift=r;
   }
   
   }
      
//////////////////////////////////////////////////////////////////      
      
   if ( close_prices > open_prices //&& total_spike < 2
    ) {
   
   if ( open_prices < low_price && close_prices < low_price ) {   
   low_down_open_close=true;   
   }
   
   
   }
   

   
   if ( open_prices > close_prices //&& total_spike < 2
   ) {
   
   if ( open_prices < low_price && close_prices < low_price ) {   
   low_down_open_close=true;   
   }
   
   }
   
   
   
         
      
   
   
   
   }
   
   
   if ( total_spike >= 2 && low_down_open_close == false
    ) {
   
   if ( open_price > close_price ) {
   ObjectCreate(ChartID(),"V"+i,OBJ_RECTANGLE,0,Time[i],close_price,Time[shift],low_price);
   
   ObjectCreate(ChartID(),"VT"+i,OBJ_TREND,0,Time[i],open_price,Time[shift]+50*PeriodSeconds(),open_price);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_COLOR,clrChartreuse);
   
   
   //ObjectCreate(ChartID(),"VL"+i,OBJ_VLINE,0,Time[i],Ask);
   }
   
   
   }
   
   
      
   
   }
   
   }
   
   
      
   
   
   //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   
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
