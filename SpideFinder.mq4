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

int spike=10; // Spike Size
int spike_min=2; // Spike Total
int spike_bar=5; // Spike Search
int spike_line=200; // Spike Line Buy Sell

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
   
   if ( (high_price-close_price)/Point > spike ) {
   
   
   int total_spike=0;
   int shift=0;
   bool high_up_open_close = false;
   
   
   for(int r=i+1;r<i+spike_bar;r++){
   
   double high_prices=iHigh(sym,per,r);
   double low_prices=iLow(sym,per,r);
   double open_prices=iOpen(sym,per,r);
   double close_prices=iClose(sym,per,r);
   
//////////////////////////////////////////////////////////////////   
   if ( close_prices > open_prices ) {
   
   if ( (high_prices-close_prices)/Point > spike && high_prices > close_price && open_prices < high_price && close_prices < high_price) {
   total_spike=total_spike+1;
   shift=r;
   }
  
   }
   
   
   if ( open_prices > close_prices ) {
   
   if ( (high_prices-open_prices)/Point > spike && high_prices > close_price && open_prices < high_price && close_prices < high_price) {
   total_spike=total_spike+1;
   shift=r;
   }
   
   }
      
//////////////////////////////////////////////////////////////////      
      
   if ( close_prices > open_prices //&& total_spike < 2
    ) {
   
   if ( open_prices > high_price || close_prices > high_price ) {   
   high_up_open_close=true;   
   }
   
   
   }
   

   
   if ( open_prices > close_prices //&& total_spike < 2
   ) {
   
   if ( open_prices > high_price || close_prices > high_price ) {   
   high_up_open_close=true;   
   }
   
   }
   
   
   
         
      
   
   
   
   }
   
   
   if ( total_spike >= spike_min && high_up_open_close == false ) {
   
   if ( close_price > open_price ) {
   ObjectCreate(ChartID(),"V"+i,OBJ_RECTANGLE,0,Time[i],close_price,Time[shift],high_price);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrRed);
   
   ObjectCreate(ChartID(),"VT"+i,OBJ_TREND,0,Time[i],open_price,Time[shift]+spike_line*PeriodSeconds(),open_price);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_COLOR,clrCrimson);
   
   
   //ObjectCreate(ChartID(),"VL"+i,OBJ_VLINE,0,Time[i],Ask);
   }
   
   
   }
   
   
   
   }
   
   }
   
   
   
   
   



   if ( open_price > close_price ) {
   
   if ( (high_price-open_price)/Point > spike ) {
   
   
   int total_spike=0;
   int shift=0;
   bool high_up_open_close = false;
   
   
   for(int r=i+1;r<i+spike_bar;r++){
   
   double high_prices=iHigh(sym,per,r);
   double low_prices=iLow(sym,per,r);
   double open_prices=iOpen(sym,per,r);
   double close_prices=iClose(sym,per,r);
   
//////////////////////////////////////////////////////////////////   
   if ( close_prices > open_prices ) {
   
   if ( (high_prices-close_prices)/Point > spike && high_prices > open_price && open_prices < high_price && close_prices < high_price) {
   total_spike=total_spike+1;
   shift=r;
   }
  
   }
   
   
   if ( open_prices > close_prices ) {
   
   if ( (high_prices-open_prices)/Point > spike && high_prices > open_price && open_prices < high_price && close_prices < high_price) {
   total_spike=total_spike+1;
   shift=r;
   }
   
   }
      
//////////////////////////////////////////////////////////////////      
      
   if ( close_prices > open_prices //&& total_spike < 2
    ) {
   
   if ( open_prices > high_price || close_prices > high_price ) {   
   high_up_open_close=true;   
   }
   
   
   }
   

   
   if ( open_prices > close_prices //&& total_spike < 2
   ) {
   
   if ( open_prices > high_price || close_prices > high_price ) {   
   high_up_open_close=true;   
   }
   
   }
   
   
   
         
      
   
   
   
   }
   
   
   if ( total_spike >= spike_min && high_up_open_close == false ) {
   
   if ( open_price > close_price ) {
   ObjectCreate(ChartID(),"V"+i,OBJ_RECTANGLE,0,Time[i],open_price,Time[shift],high_price);
   ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrRed);
   
   ObjectCreate(ChartID(),"VT"+i,OBJ_TREND,0,Time[i],close_price,Time[shift]+spike_line*PeriodSeconds(),close_price);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_COLOR,clrCrimson);
   
   
   //ObjectCreate(ChartID(),"VL"+i,OBJ_VLINE,0,Time[i],Ask);
   }
   
   
   }
   
   
   
   }
   
   }
   
 
   //continue;
   
   
   
   
   if ( close_price > open_price ) {
   
   if ( (open_price-low_price)/Point > spike ) {
   
   
   int total_spike=0;
   int shift=0;
   bool low_down_open_close = false;
   
   
   for(int r=i+1;r<i+spike_bar;r++){
   
   double high_prices=iHigh(sym,per,r);
   double low_prices=iLow(sym,per,r);
   double open_prices=iOpen(sym,per,r);
   double close_prices=iClose(sym,per,r);
   
//////////////////////////////////////////////////////////////////   
   if ( close_prices > open_prices ) {
   
   if ( (open_prices-low_prices)/Point > spike && low_prices < open_price && open_prices > low_price && close_prices > low_price) {
   total_spike=total_spike+1;
   shift=r;
   }
  
   }
   
   
   if ( open_prices > close_prices ) {
   
   if ( (close_prices-low_prices)/Point > spike && low_prices < open_price && open_prices > low_price && close_prices > low_price) {
   total_spike=total_spike+1;
   shift=r;
   }
   
   }
      
//////////////////////////////////////////////////////////////////      
      
   if ( close_prices > open_prices //&& total_spike < 2
    ) {
   
   if ( open_prices < low_price || close_prices < low_price ) {   
   low_down_open_close=true;   
   }
   
   
   }
   

   
   if ( open_prices > close_prices //&& total_spike < 2
   ) {
   
   if ( open_prices < low_price || close_prices < low_price ) {   
   low_down_open_close=true;   
   }
   
   }
   
   
   
         
      
   
   
   
   }
   
   
   if ( total_spike >= spike_min && low_down_open_close == false ) {
   
   if ( close_price > open_price ) {
   ObjectCreate(ChartID(),"V"+i,OBJ_RECTANGLE,0,Time[i],open_price,Time[shift],low_price);
   
   ObjectCreate(ChartID(),"VT"+i,OBJ_TREND,0,Time[i],close_price,Time[shift]+spike_line*PeriodSeconds(),close_price);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"VT"+i,OBJPROP_COLOR,clrChartreuse);
   
   
   //ObjectCreate(ChartID(),"VL"+i,OBJ_VLINE,0,Time[i],Ask);
   }
   
   
   }
   
   
   
   }
   
   }
   
   
   
   
   if ( open_price >= close_price ) {
   
   if ( (close_price-low_price)/Point > spike ) {
   //ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   



   int total_spike=0;
   int shift=0;
   bool low_down_open_close = false;
   
   
   for(int r=i+1;r<i+spike_bar;r++){
   
   double high_prices=iHigh(sym,per,r);
   double low_prices=iLow(sym,per,r);
   double open_prices=iOpen(sym,per,r);
   double close_prices=iClose(sym,per,r);
   
//////////////////////////////////////////////////////////////////   
   if ( close_prices > open_prices ) {
   
   if ( (open_prices-low_prices)/Point > spike && low_prices < close_price && open_prices > low_price && close_prices > low_price) {
   total_spike=total_spike+1;
   shift=r;
   }
  
   }
   
   
   if ( open_prices > close_prices ) {
   
   if ( (close_prices-low_prices)/Point > spike && low_prices < close_price && open_prices > low_price && close_prices > low_price) {
   total_spike=total_spike+1;
   shift=r;
   }
   
   }
      
//////////////////////////////////////////////////////////////////      
      
   if ( close_prices > open_prices //&& total_spike < 2
    ) {
   
   if ( open_prices < low_price || close_prices < low_price ) {   
   low_down_open_close=true;   
   }
   
   
   }
   

   
   if ( open_prices > close_prices //&& total_spike < 2
   ) {
   
   if ( open_prices < low_price || close_prices < low_price ) {   
   low_down_open_close=true;   
   }
   
   }
   
   
   
         
      
   
   
   
   }
   
   
   if ( total_spike >= spike_min && low_down_open_close == false
    ) {
   
   if ( open_price > close_price ) {
   ObjectCreate(ChartID(),"V"+i,OBJ_RECTANGLE,0,Time[i],close_price,Time[shift],low_price);
   
   ObjectCreate(ChartID(),"VT"+i,OBJ_TREND,0,Time[i],open_price,Time[shift]+spike_line*PeriodSeconds(),open_price);
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
