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
   
   //Alert("Selam");
   
  
  ObjectsDeleteAll(ChartID(),-1,-1);
  
  //string   yenitarihs= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent())))+" 00:00"; 
  string   yenitarihs= TimeYear(TimeCurrent())+".04.25 00:00"; 
  datetime some_times = StringToTime(yenitarihs); 
  
  //some_times = some_times - PeriodSeconds()*1000;
  
  Print(some_times);
  
  
  int shifts=iBarShift(Symbol(),PERIOD_M1,some_times);
  
  ObjectCreate(ChartID(),"CTIMES",OBJ_VLINE,0,some_times,Ask);
  
  long ChartIDS=ChartNext(ChartFirst());
  
  ObjectsDeleteAll(ChartIDS,-1,-1);

  //Alert(chartid,"/",ChartSymbol(chartid));

   ObjectCreate(ChartIDS,"CTIMES",OBJ_VLINE,0,some_times,Ask);
  
  bool find=false;
  
  for(int i=shifts;i>70;i--) {
  
  if ( i < 70 ) continue;
  //if ( find==true) continue;
  
  find=true;
  
   //ObjectCreate(ChartID(),"CTIME"+i,OBJ_VLINE,0,Time[i],Ask);
  
  string sym1="EURUSD";
  string sym2="GBPUSD";
  
  


  if ( iOpen(sym2,PERIOD_M1,i) > iClose(sym2,PERIOD_M1,i-60) ) {

  double sym2_op=iOpen(sym2,PERIOD_M1,i);
  double sym2_cp=iClose(sym2,PERIOD_M1,i-60);
  
  double fark=(sym2_op-sym2_cp);
  int pip=fark/MarketInfo(sym2,MODE_POINT);
  int pips=0;
 
  if ( pip >= 90 ) {
  /*
  ObjectCreate(ChartID(),"SYM1"+i,OBJ_TREND,0,Time[i],sym2_op,Time[i-60],sym2_cp);
  ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_RAY,false);
  ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,i+"/"+pip);*/


  
  //Print(sym1,"/",sym1_op,"/",sym1_cp);
  
  int shift1=iBarShift(sym1,PERIOD_M1,Time[i]);
  int shift2=iBarShift(sym1,PERIOD_M1,Time[i-60]);
  
  double sym1_op=iOpen(sym1,PERIOD_M1,shift1);
  double sym1_cp=iClose(sym1,PERIOD_M1,shift2);  
  
  
  double farks=(sym1_cp-sym1_op);
  pips=farks/MarketInfo(sym1,MODE_POINT);   
  

    
  
  if ( pips >= 60 ) {
  
  ObjectCreate(ChartIDS,"SYM1"+i,OBJ_TREND,0,iTime(sym1,PERIOD_M1,shift1),sym1_op,iTime(sym1,PERIOD_M1,shift2),sym1_cp);
  ObjectSetInteger(ChartIDS,"SYM1"+i,OBJPROP_RAY,false);
  ObjectSetString(ChartIDS,"SYM1"+i,OBJPROP_TOOLTIP,i+"/"+pips);  
  
  
  ObjectCreate(ChartID(),"SYM1"+i,OBJ_TREND,0,Time[i],sym2_op,Time[i-60],sym2_cp);
  ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_RAY,false);
  ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,i+"/"+pip);
  

ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_COLOR,clrCrimson);
ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,pips);  
  
  } else {
  //if ( pips == 0 ) ObjectDelete(ChartID(),"SYM1"+i);
  }
  

  
  
  /*
  if ( iOpen(sym1,PERIOD_M1,i) > iClose(sym1,PERIOD_M1,i-60) ) {

  if ( pips >= 20 ) {
  
  Print(pips);
  
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,pips);
  } 

    
  
  }*/
  
  //if ( pips == 0 ) ObjectDelete(ChartID(),"SYM1"+i);
  
  
  }    
    
   
  }
  
///////////////////////////////////////////////////////////////////////////////////////////////  
  


//continue;
  
  if ( iOpen(sym2,PERIOD_M1,i) < iClose(sym2,PERIOD_M1,i-60) ) {

  double sym2_op=iOpen(sym2,PERIOD_M1,i);
  double sym2_cp=iClose(sym2,PERIOD_M1,i-60);
  
  double fark=(sym2_cp-sym2_op);
  int pip=fark/Point;
  int pips=0;
 
  if ( pip >= 90 ) {
  /*
  ObjectCreate(ChartID(),"SYM1"+i,OBJ_TREND,0,Time[i],sym2_op,Time[i-60],sym2_cp);
  ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_RAY,false);
  ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,i+"/"+pip);*/


  
  //Print(sym1,"/",sym1_op,"/",sym1_cp);
  
  int shift1=iBarShift(sym1,PERIOD_M1,Time[i]);
  int shift2=iBarShift(sym1,PERIOD_M1,Time[i-60]);
  
  double sym1_op=iOpen(sym1,PERIOD_M1,shift1);
  double sym1_cp=iClose(sym1,PERIOD_M1,shift2);  
  
  
  double farks=(sym1_op-sym1_cp);
  pips=farks/MarketInfo(sym1,MODE_POINT);   
  

    
  
  if ( pips >= 60 ) {
  
  ObjectCreate(ChartIDS,"SYM1"+i,OBJ_TREND,0,iTime(sym1,PERIOD_M1,shift1),sym1_op,iTime(sym1,PERIOD_M1,shift2),sym1_cp);
  ObjectSetInteger(ChartIDS,"SYM1"+i,OBJPROP_RAY,false);
  ObjectSetString(ChartIDS,"SYM1"+i,OBJPROP_TOOLTIP,i+"/"+pips);  
  
  
  ObjectCreate(ChartID(),"SYM1"+i,OBJ_TREND,0,Time[i],sym2_op,Time[i-60],sym2_cp);
  ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_RAY,false);
  ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,i+"/"+pip);
  

ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,pips);  
  
  } else {
  //if ( pips == 0 ) ObjectDelete(ChartID(),"SYM1"+i);
  }
  

  
  
  /*
  if ( iOpen(sym1,PERIOD_M1,i) > iClose(sym1,PERIOD_M1,i-60) ) {

  if ( pips >= 20 ) {
  
  Print(pips);
  
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,pips);
  } 

    
  
  }*/
  
  //if ( pips == 0 ) ObjectDelete(ChartID(),"SYM1"+i);
  
  
  }    
    
   
  }
   
   
   
   
   
   
   
   
   
   
   
  continue;
  
  
  
  if ( iOpen(sym1,PERIOD_M1,i) > iClose(sym1,PERIOD_M1,i-60) ) {
 
  double sym1_op=iOpen(sym1,PERIOD_M1,i);
  double sym1_cp=iClose(sym1,PERIOD_M1,i-60);

  double sym2_op=iOpen(sym2,PERIOD_M1,i-60);
  double sym2_cp=iClose(sym2,PERIOD_M1,i);
   
 
  double fark=(sym1_op-sym1_cp);
  int pip=fark/Point;
  
  
  
  
  if ( pip >= 60 ) {
  ObjectCreate(ChartID(),"SYM1"+i,OBJ_TREND,0,Time[i],sym1_op,Time[i-60],sym1_cp);
  ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_RAY,false);
  
  /*
if ( iClose(sym2,PERIOD_M1,i-60) > iOpen(sym2,PERIOD_M1,i) ) {
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_COLOR,clrBlue);
}  */

  if ( iOpen(sym2,PERIOD_M1,i) < iClose(sym2,PERIOD_M1,i-60) ) {

  double sym2_op=iOpen(sym2,PERIOD_M1,i);
  double sym2_cp=iClose(sym2,PERIOD_M1,i-60);
  
  double fark=(sym2_cp-sym2_op);
  int pip=fark/MarketInfo(sym2,MODE_POINT);
 
  //if ( pip >= 10 ) {
  //ObjectCreate(ChartID(),"SYM1"+i,OBJ_TREND,0,Time[i],sym2_op,Time[i-60],sym2_cp);
  //ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_RAY,false);
  
  //ObjectCreate(ChartID(),"SYM1"+i,OBJ_TREND,0,Time[i],sym1_op,Time[i-60],sym1_cp);
  //ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_RAY,false);
  

ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),"SYM1"+i,OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),"SYM1"+i,OBJPROP_TOOLTIP,pip);
  
  
  //}
      
    
   
  }
  




  
  
  }
   

   
   
  

  }
  
  if ( iOpen(sym1,PERIOD_M1,i) < iClose(sym1,PERIOD_M1,i-60) ) {

  }
  
  
  
    
  
  
   
  
  }  
  
  
  
  
  return INIT_SUCCEEDED;
  
  
  
  string   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent())))+" 00:00"; 
  datetime some_time = StringToTime(yenitarih); 

  string sym1="EURUSD";
  string sym2="GBPUSD"; 
  string sym3="EURGBP";  
  
  int shift=iBarShift(sym1,PERIOD_M1,some_time);

  double sym1prc=iClose(sym1,PERIOD_M1,shift);
  double sym2prc=iClose(sym2,PERIOD_M1,shift); 
  double sym3prc=iClose(sym3,PERIOD_M1,shift); 
    
  double sym4prc=DivZero(sym1prc,sym2prc);
  
   if ( sym4prc > sym3prc ) { 
   
 double fark=(sym4prc-sym3prc);
  int pip=fark/Point;
  //Comment("EUR BUY,GBP SELL:",pip); 
  Comment(sym1," BUY,",sym2," SELL:",pip);
 
   }
 
   if ( sym4prc < sym3prc ) {
   
  double fark=(sym3prc-sym4prc);
  int pip=fark/Point;  
  Comment(sym1," SELL,",sym2," BUY:",pip); 
  
   }

  string sym1j="EURJPY";
  string sym2j="USDJPY"; 
  string sym3j="EURUSD";
  
  double sym1jprc=iClose(sym1j,PERIOD_M1,shift);
  double sym2jprc=iClose(sym2j,PERIOD_M1,shift); 
  double sym3jprc=iClose(sym3j,PERIOD_M1,shift); 
  
   double sym4jprc=DivZero(sym1jprc,sym2jprc);  // EURUSD    
   
   
   if ( sym4jprc > sym3jprc ) { 
   
 double fark=(sym4jprc-sym3jprc);
  int pip=fark/Point;
  //Comment("EUR BUY,GBP SELL:",pip); 
  Comment(sym1j," BUY,",sym2j," SELL:",pip);
 
   }
 
   if ( sym4jprc < sym3jprc ) {
   
  double fark=(sym3prc-sym4prc);
  int pip=fark/Point;  
  Comment(sym1j," SELL,",sym2j," BUY:",pip); 
  
   }
   
      
  
  
  return INIT_SUCCEEDED;
  
  
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
