//+------------------------------------------------------------------+
//|                                                     DojiBand.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   double Lot=0.01;
   int magic=0;
   extern double oran=1.5;
   double profit=25;
   
   datetime buy_time;
   datetime sell_time;
   
   string buy_sinyal="";
   string sell_sinyal="";
   
   double acb=0;
   
   extern double carpan=2;
   
   extern double profits=25;
   extern double Lots=0.01;
   
   extern int minumum_candle_point=100;
   extern int minumum_area_point=500;
   
   //double fark=0;
   double farks=0;
   
   extern double tp_oran=100; // TP Oran Yüzde
    
   
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   if ( IsTesting() == True ) {} else {
   if ( int(TimeMonth(TimeCurrent())) != 5 ) ExpertRemove();
   }
   
   profit=profits;
   Lot=Lots;
   
   acb=AccountBalance();
   
   buy_time=Time[1];
   sell_time=Time[1];
   
   ObjectsDeleteAll();
   
   
   //DojiBandEa();
   
   return(INIT_SUCCEEDED);
   

   
   for (int i=0;i<800;i++) {
   
   
   double Band_Low = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,i+1);
   double Band_High = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,i+1);
   double Band_Main = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,i+1);
 
 
   double Band_Lows = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,i+2);
   double Band_Highs = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,i+2);
   double Band_Mains = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,i+2);
   



   
   double high_price=iHigh(sym,per,i+1);
   double high_prices=iHigh(sym,per,i+2);
   
   double low_price=iLow(sym,per,i+1);
   double low_prices=iLow(sym,per,i+2);
   
    double open_price=iOpen(sym,per,i+1);
   double open_prices=iOpen(sym,per,i+2);
   
    double close_price=iClose(sym,per,i+1);
   double close_prices=iClose(sym,per,i+2);
   
   double body=0;
   double bodys=0;
   double body_low=0;
   double body_lows=0;
   double body_high=0;
   double body_highs=0;
   
   
   if ( close_price > open_price ) {
   
   body_high=high_price-close_price;
   body_low=open_price-low_price;
   body=close_price-open_price;
   
   }
   if ( open_price >= close_price ) {
   
   body_high=high_price-open_price;
   body_low=close_price-low_price;
   body=open_price-close_price;
   
   }
   
   if ( close_prices > open_prices ) {
   
   body_highs=high_prices-close_prices;
   body_lows=open_prices-low_prices;
   body=close_price-open_price;  
   
   bodys=close_prices-open_prices;
   
   
   
   
   }
   if ( open_prices >= close_prices ) {
   
   body_highs=high_prices-open_prices;
   body_lows=close_prices-low_prices;
   bodys=open_prices-close_prices;
   
   }
   
   
   
   if ( body_low > body_high && body_lows > body_highs ) {
   
   if ( DivZero(body_low,body) >= 3 ||  DivZero(body_lows,bodys) >= 3 ) {
   
   if ( body < body_low && bodys < body_lows //&& body < body_high && bodys < body_highs
    ) {
   
   if ( low_price < Band_Low && low_prices < Band_Lows ) { 
   
   if ( high_price < Band_Main && high_prices < Band_Mains ) {
   
   double candle_high;
   double candle_low;
   
   if ( high_price > high_prices ) {
   candle_high =high_price;
   
   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i+1],candle_high,Time[i+1]+7*PeriodSeconds(),candle_high);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   
   } 
   else {
   candle_high=high_prices;

   ObjectCreate(ChartID(),"TLINE"+(Time[i]+2),OBJ_TREND,0,Time[i+2],candle_high,Time[i+2]+7*PeriodSeconds(),candle_high);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_WIDTH,2);
   
   
   }
      
      
if ( low_price < low_prices ) {
   candle_low =low_price;
   
   ObjectCreate(ChartID(),"LLINE"+(Time[i]+1),OBJ_TREND,0,Time[i+1],candle_low,Time[i+1]+7*PeriodSeconds(),candle_low);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   
   } 
   else {
   candle_low=low_prices;

   ObjectCreate(ChartID(),"LLINE"+(Time[i]+2),OBJ_TREND,0,Time[i+2],candle_low,Time[i+2]+7*PeriodSeconds(),candle_low);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_WIDTH,2);
   
   
   }
      
   bool cancel_setup=false;   
      
   if ( i > 3 ) {
   
   for (int b=i;b>i-7;b--) {
   
   if ( iLow(sym,per,b) < candle_low ) cancel_setup=true;
   
   if ( cancel_setup == true ) continue;
   
   if ( b < 1 ) continue;
   
   double Band_Mainb = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,b);
  
   if ( iLow(sym,per,b) > candle_low && iOpen(sym,per,b) < Band_Mainb && iHigh(sym,per,b) > candle_high ) {
   

   ObjectCreate(ChartID(),"OLINE"+(Time[b]),OBJ_TREND,0,Time[b],iClose(sym,per,b),Time[b]+7*PeriodSeconds(),iClose(sym,per,b));
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_WIDTH,2);
  
   ObjectCreate(ChartID(),"VLINE"+(Time[b]),OBJ_VLINE,0,Time[b],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[b]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[b]),OBJPROP_STYLE,STYLE_DOT);
   
   }
   
   
   }
   
   
   }   
      
      
   ObjectCreate(ChartID(),"VLINE"+(Time[i]+1),OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   
   ObjectCreate(ChartID(),"VLINE"+(Time[i]+2),OBJ_VLINE,0,Time[i+2],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   
   }
   
   }
   
   }
   
   
   }
   
   
   }
   
   
   //continue;
 
 
   if ( body_high > body_low && body_highs > body_lows ) {
   
   if ( DivZero(body_high,body) >= 3 ||  DivZero(body_highs,bodys) >= 3 ) {
   
   if ( body < body_high && bodys < body_highs //&& body < body_high && bodys < body_highs
    ) {
   
   if ( high_price > Band_High && high_prices > Band_Highs ) { 
   
   if ( low_price > Band_Main && low_prices > Band_Mains ) {
   
   double candle_high;
   double candle_low;
   
   if ( high_price > high_prices ) {
   candle_high =high_price;
   
   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i+1],candle_high,Time[i+1]+7*PeriodSeconds(),candle_high);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   
   } 
   else {
   candle_high=high_prices;

   ObjectCreate(ChartID(),"TLINE"+(Time[i]+2),OBJ_TREND,0,Time[i+2],candle_high,Time[i+2]+7*PeriodSeconds(),candle_high);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_WIDTH,2);
   
   
   }
      
      
if ( low_price < low_prices ) {
   candle_low =low_price;
   
   ObjectCreate(ChartID(),"LLINE"+(Time[i]+1),OBJ_TREND,0,Time[i+1],candle_low,Time[i+1]+7*PeriodSeconds(),candle_low);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   
   } 
   else {
   candle_low=low_prices;

   ObjectCreate(ChartID(),"LLINE"+(Time[i]+2),OBJ_TREND,0,Time[i+2],candle_low,Time[i+2]+7*PeriodSeconds(),candle_low);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_WIDTH,2);
   
   
   }
      

   bool cancel_setup=false;   
      
   if ( i > 3 ) {
   
   for (int b=i;b>i-7;b--) {
   
   if ( iHigh(sym,per,b) > candle_high ) cancel_setup=true;
   
   if ( cancel_setup == true ) continue;
   
   if ( b < 1 ) continue;
   
   double Band_Mainb = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,b);
  
   if ( iHigh(sym,per,b) < candle_high && iOpen(sym,per,b) > Band_Mainb && iLow(sym,per,b) < candle_low ) {
   

   ObjectCreate(ChartID(),"OLINE"+(Time[b]),OBJ_TREND,0,Time[b],iClose(sym,per,b),Time[b]+7*PeriodSeconds(),iClose(sym,per,b));
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_WIDTH,2);
  
   ObjectCreate(ChartID(),"VLINE"+(Time[b]),OBJ_VLINE,0,Time[b],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[b]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[b]),OBJPROP_STYLE,STYLE_DOT);
   
   }
   
   
   }
   
   
   }   
  
  
  
      
   ObjectCreate(ChartID(),"VLINE"+(Time[i]+1),OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   
   ObjectCreate(ChartID(),"VLINE"+(Time[i]+2),OBJ_VLINE,0,Time[i+2],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   
   }
   
   }
   
   }
   
   
   }
   
   
   }
   
   
      
   
   
   Print(i);
   
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

if ( AccountBalance() < acb ) {
Lot=Lot*carpan;
double fark=acb-AccountBalance();
farks=farks+fark;
profit=profits+farks;
acb=AccountBalance();
}

if ( AccountBalance() > acb ) {
Lot=Lots;
//double fark=acb-AccountBalance();
profit=profits;
acb=AccountBalance();
farks=0;
Print(Lot);
}



Comment("Lots",Lot," Profit:",profit);

   DojiBandEa();
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---

if ( IsTesting() ) OnTick();
   
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
// Thank You For Life 26.01.2024



void DojiBandEa() {

for (int i=0;i<9;i++) {
   
   
   double Band_Low = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,i+1);
   double Band_High = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,i+1);
   double Band_Main = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,i+1);
 
 
   double Band_Lows = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,i+2);
   double Band_Highs = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,i+2);
   double Band_Mains = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,i+2);
   



   
   double high_price=iHigh(sym,per,i+1);
   double high_prices=iHigh(sym,per,i+2);
   
   double low_price=iLow(sym,per,i+1);
   double low_prices=iLow(sym,per,i+2);
   
    double open_price=iOpen(sym,per,i+1);
   double open_prices=iOpen(sym,per,i+2);
   
    double close_price=iClose(sym,per,i+1);
   double close_prices=iClose(sym,per,i+2);
   
   double body=0;
   double bodys=0;
   double body_low=0;
   double body_lows=0;
   double body_high=0;
   double body_highs=0;
   
   
   if ( close_price > open_price ) {
   
   body_high=high_price-close_price;
   body_low=open_price-low_price;
   body=close_price-open_price;
   
   }
   if ( open_price >= close_price ) {
   
   body_high=high_price-open_price;
   body_low=close_price-low_price;
   body=open_price-close_price;
   
   }
   
   if ( close_prices > open_prices ) {
   
   body_highs=high_prices-close_prices;
   body_lows=open_prices-low_prices;
   body=close_price-open_price;  
   
   bodys=close_prices-open_prices;
   
   
   
   
   }
   if ( open_prices >= close_prices ) {
   
   body_highs=high_prices-open_prices;
   body_lows=close_prices-low_prices;
   bodys=open_prices-close_prices;
   
   }
   
   
   
   if ( body_low > body_high && body_lows > body_highs && ( body/Point > minumum_candle_point  && bodys/Point > minumum_candle_point)  ) {
   
   if ( DivZero(body_low,body) >= oran ||  DivZero(body_lows,bodys) >= oran ) {
   
   if ( body < body_low && bodys < body_lows //&& body < body_high && bodys < body_highs
    ) {
   
   if ( low_price < Band_Low && low_prices < Band_Lows ) { 
   
   if ( high_price < Band_Main && high_prices < Band_Mains ) {
   
   double candle_high;
   double candle_low;
   
   if ( high_price > high_prices ) {
   candle_high =high_price;
   
   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i+1],candle_high,Time[i+1]+7*PeriodSeconds(),candle_high);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   
   } 
   else {
   candle_high=high_prices;

   ObjectCreate(ChartID(),"TLINE"+(Time[i]+2),OBJ_TREND,0,Time[i+2],candle_high,Time[i+2]+7*PeriodSeconds(),candle_high);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_WIDTH,2);
   
   
   }
      
      
if ( low_price < low_prices ) {
   candle_low =low_price;
   
   ObjectCreate(ChartID(),"LLINE"+(Time[i]+1),OBJ_TREND,0,Time[i+1],candle_low,Time[i+1]+7*PeriodSeconds(),candle_low);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   
   } 
   else {
   candle_low=low_prices;

   ObjectCreate(ChartID(),"LLINE"+(Time[i]+2),OBJ_TREND,0,Time[i+2],candle_low,Time[i+2]+7*PeriodSeconds(),candle_low);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_WIDTH,2);
   
   
   }
      
   bool cancel_setup=false;   
   
   if( ( candle_high-candle_low)/Point < minumum_area_point ) cancel_setup=true; 
      
   if ( i >= 0 ) {
   
   for (int b=i;b>i-7;b--) {
   
   if ( iLow(sym,per,b) < candle_low ) cancel_setup=true;
   
   if ( cancel_setup == true ) continue;
   
   if ( b < 0 ) continue;
   
   double Band_Mainb = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,b);
  
   if ( iLow(sym,per,b) > candle_low && iOpen(sym,per,b) < Band_Mainb && iHigh(sym,per,b) > candle_high ) {
    //Time[1] > buy_time
   if ( OrdersTotal() == 0 && StringFind(buy_sinyal,DoubleToString(candle_high,Digits)) == -1 ) {   
   //OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Bid-2000*Point,Ask+1000*Point,"",magic,0,clrNONE);Ask+1000*Point
   
 /*  
   double pip=PipPrice(Symbol(),profit,0,Lot);
   

   
   double usd=PipPrice(Symbol(),0,mesafe,1);
   Lot=(usd/50)*0.01;
   Print("Usd:",(usd/50)*0.01);
   Lot=NormalizeDouble(DivZero(usd,50)*0.01,2);
   /*
   double usd_oran=DivZero(usd,mesafe);   
   
Print("usd_oran:",(usd_oran/100),"/",Lot);
   */
   
   double pip_mesafe=(Ask-candle_low)/Point;
double pip_usd=PipPrice(Symbol(),0,1,1);
double pip_profit=profits;
double pip_oran=DivZero(pip_profit,pip_usd);
//double pip_mesafe=1340;
double pip_lot=DivZero(pip_oran,pip_mesafe);
pip_lot=NormalizeDouble(pip_lot,2);
   Lot=pip_lot;
   
   Print("Lot:",Lot);
   
   double tp_yuzde=DivZero(pip_mesafe,100);
   double tp_level=tp_yuzde*tp_oran;
   pip_mesafe=int(tp_level);
   
   
   OrderSend(Symbol(),OP_BUY,Lot,Ask,0,candle_low,Ask+pip_mesafe*Point,"",magic,0,clrNONE);
   buy_time=Time[1];
   buy_sinyal=buy_sinyal+DoubleToString(candle_high,Digits);
   
   ObjectCreate(ChartID(),"OLINE"+(Time[b]),OBJ_TREND,0,Time[b],iClose(sym,per,b),Time[b]+7*PeriodSeconds(),iClose(sym,per,b));
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_WIDTH,2);
  
   ObjectCreate(ChartID(),"VLINE"+(Time[b]),OBJ_VLINE,0,Time[b],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[b]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[b]),OBJPROP_STYLE,STYLE_DOT);   
   
   }
       

  
   
      


   
   }
   
   
   }
   
   
   }   
      
      
   ObjectCreate(ChartID(),"VLINE"+(Time[i]+1),OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   
   ObjectCreate(ChartID(),"VLINE"+(Time[i]+2),OBJ_VLINE,0,Time[i+2],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   
   }
   
   }
   
   }
   
   
   }
   
   
   }
   
   
   //continue;
 
 
   if ( body_high > body_low && body_highs > body_lows && ( body/Point > minumum_candle_point  && bodys/Point > minumum_candle_point) ) {
   
   if ( DivZero(body_high,body) >= oran ||  DivZero(body_highs,bodys) >= oran ) {
   
   if ( body < body_high && bodys < body_highs //&& body < body_high && bodys < body_highs
    ) {
   
   if ( high_price > Band_High && high_prices > Band_Highs ) { 
   
   if ( low_price > Band_Main && low_prices > Band_Mains ) {
   
   double candle_high;
   double candle_low;
   
   if ( high_price > high_prices ) {
   candle_high =high_price;
   
   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i+1],candle_high,Time[i+1]+7*PeriodSeconds(),candle_high);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   
   } 
   else {
   candle_high=high_prices;

   ObjectCreate(ChartID(),"TLINE"+(Time[i]+2),OBJ_TREND,0,Time[i+2],candle_high,Time[i+2]+7*PeriodSeconds(),candle_high);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+2),OBJPROP_WIDTH,2);
   
   
   }
      
      
if ( low_price < low_prices ) {
   candle_low =low_price;
   
   ObjectCreate(ChartID(),"LLINE"+(Time[i]+1),OBJ_TREND,0,Time[i+1],candle_low,Time[i+1]+7*PeriodSeconds(),candle_low);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   
   } 
   else {
   candle_low=low_prices;

   ObjectCreate(ChartID(),"LLINE"+(Time[i]+2),OBJ_TREND,0,Time[i+2],candle_low,Time[i+2]+7*PeriodSeconds(),candle_low);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"LLINE"+(Time[i]+2),OBJPROP_WIDTH,2);
   
   
   }
      
      
      
      

   bool cancel_setup=false;   
   
   
   if( ( candle_high-candle_low)/Point < minumum_area_point ) cancel_setup=true; 
      
   if ( i >= 0 ) {
   
   for (int b=i;b>i-7;b--) {
   
   if ( iHigh(sym,per,b) > candle_high ) cancel_setup=true;
   
   if ( cancel_setup == true ) continue;
   
   if ( b < 0 ) continue;
   
   double Band_Mainb = iBands(Symbol(),ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,b);
  
   if ( iHigh(sym,per,b) < candle_high && iOpen(sym,per,b) > Band_Mainb && iLow(sym,per,b) < candle_low ) {
   //&& Time[1] > sell_time
   if ( OrdersTotal() == 0 && StringFind(sell_sinyal,DoubleToString(candle_low,Digits)) == -1 ) {   
   //OrderSend(Symbol(),OP_SELL,Lot,Bid,0,Ask+2000*Point,Bid-1000*Point,"",magic,0,clrNONE);
   
   double pip=PipPrice(Symbol(),profit,0,Lot);
   //Bid-1000*Point
   
   
   double pip_mesafe=(candle_high-Bid)/Point;
double pip_usd=PipPrice(Symbol(),0,1,1);
double pip_profit=profits;
double pip_oran=DivZero(pip_profit,pip_usd);
//double pip_mesafe=1340;
double pip_lot=DivZero(pip_oran,pip_mesafe);
pip_lot=NormalizeDouble(pip_lot,2);
   Lot=pip_lot;   
   
   double tp_yuzde=DivZero(pip_mesafe,100);
   double tp_level=tp_yuzde*tp_oran;
   pip_mesafe=int(tp_level);
   
   
   OrderSend(Symbol(),OP_SELL,Lot,Bid,0,candle_high,Bid-pip_mesafe*Point,"",magic,0,clrNONE);
   sell_time=Time[1];
   sell_sinyal=sell_sinyal+DoubleToString(candle_low,Digits);
   
   
   ObjectCreate(ChartID(),"OLINE"+(Time[b]),OBJ_TREND,0,Time[b],iClose(sym,per,b),Time[b]+7*PeriodSeconds(),iClose(sym,per,b));
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),"OLINE"+(Time[b]),OBJPROP_WIDTH,2);
  
   ObjectCreate(ChartID(),"VLINE"+(Time[b]),OBJ_VLINE,0,Time[b],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[b]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[b]),OBJPROP_STYLE,STYLE_DOT);   
   
   
   }  
   


   
   }
   
   
   }
   
   
   }   
  
  
  
      
   ObjectCreate(ChartID(),"VLINE"+(Time[i]+1),OBJ_VLINE,0,Time[i+1],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   
   ObjectCreate(ChartID(),"VLINE"+(Time[i]+2),OBJ_VLINE,0,Time[i+2],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+2),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]+2),OBJPROP_STYLE,STYLE_DOT);
   
   }
   
   }
   
   }
   
   
   }
   
   
   }
   
   
      
   
   
   //Print(i);
   
   }
   
   
   
   

}


////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandırır ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {


string OrderSymbols = sym;
double sonuc = 0;

//Print("Spread:",MarketInfo(OrderSymbols,MODE_SPREAD));


//if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;//DivZero((SymbolInfoDouble(Symbol(),SYMBOL_ASK)-SymbolInfoDouble(Symbol(),SYMBOL_BID)),Point);
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
        //if ( lots==0 ) lots=0.01;
        
   double BS_spread_one = DivZero(BS_spread_price,BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    
    /*
    if ( lots != 0 ) {
    lots=DivZero(Order_Profit,pips);    
    DoubleToString(lots,2);
    fiyat=0;
    pips=0;
    sonuc=lots;
    
    Print(lots);
    }*/
    
    //if ( BS_spread_one == 0 ) {Alert("BS_spread_one Hatası:",OrderSymbols);return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = DivZero(fiyat,BS_spread_one);   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kaç piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kaç $ kazandırır ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}

return sonuc;


}
