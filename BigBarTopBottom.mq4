//+------------------------------------------------------------------+
//|                                              BigBarTopBottom.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double Ortalama;
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
   Ortalama=BarOrtalama(1,300,sym,per);
   
   Comment(Ortalama);
   
   
   for(int i=1;i<900;i++) {
   
   //Print(i);
   

   
   double high_price=iHigh(sym,per,i);
   double high_prices=iHigh(sym,per,i-1);
   
   double low_price=iLow(sym,per,i);
   double low_prices=iLow(sym,per,i-1);
   
    double open_price=iOpen(sym,per,i);
   double open_prices=iOpen(sym,per,i-1);
   
    double close_price=iClose(sym,per,i);
   double close_prices=iClose(sym,per,i-1);
   
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
   
   
   
   double scr_high_price=-1;
   double scr_low_price=1000000;
   int scr_high_shift=i;
   int scr_low_shift=i;
   
   bool high_find=false;
   bool low_find=false;
   
   for(int r=i+1;r<i+480;r++) {
   
   /*
   
   if ( high_find == true ) continue;
   
   if ( scr_high_price < iHigh(sym,per,r) ) {
   
  
   
   for(int s=r+1;s<r+500;s++) {
   
   if ( s > Bars-50 ) continue;
   
   if ( scr_high_price > High[s] ) {
   high_say=high_say+1;    
   } else {
   find=true;
   }  
   }   
   
   if ( high_say > 100 ) {  
   scr_high_price=iHigh(sym,per,r);
   scr_high_shift=r;
   high_find=true;
   }
*/

   int high_say=0;
   bool find=false; 

for(int s=r+1;s<r+50;s++) {

   if ( find == true ) continue;
   
   if ( iHigh(sym,per,r) > High[s] ) {
   high_say=high_say+1;    
   } else {
   find=true;
   }

}



if ( high_say > 30 && high_find==false ) {
   
if ( scr_high_price < iHigh(sym,per,r) ) {
      scr_high_price=iHigh(sym,per,r);
   scr_high_shift=r;
   high_find=true;
   }
   
   }


   int low_say=0;
   bool finds=false; 

for(int s=r+1;s<r+50;s++) {

   if ( finds == true ) continue;
   
   if ( iLow(sym,per,r) < Low[s] ) {
   low_say=low_say+1;    
   } else {
   finds=true;
   }

}
   
   
   
   if ( low_say > 30 && low_find == false ) {
   
   if ( scr_low_price > iLow(sym,per,r)  ) {
   scr_low_price=iLow(sym,per,r);
   scr_low_shift=r;
   low_find=true;
   }
      
      }
   
   }
   
   
   double yuzde=DivZero(scr_high_price-scr_low_price,100);
   
   
   
   
   
   if ( DivZero(body,Ortalama) >= 2 ) {
   

   ObjectCreate(ChartID(),"VLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   
   
   if ( open_price > close_price ) {
   
   double candle_level=DivZero(scr_high_price-close_price,yuzde);
   
   int shift=DivZero((Time[i]-Time[scr_high_shift]),PeriodSeconds(per));
   
   //if ( shift < 200 ) {
   if ( shift < 150 && candle_level < 70 
   ) {
   
   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],Close[i],Time[scr_high_shift],scr_high_price);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
   
   }
   
   }   
   
   
   

   if ( close_price > open_price ) {
   
   
   double candle_level=DivZero(close_price-scr_low_price,yuzde);
   
      int shift=DivZero((Time[i]-Time[scr_low_shift]),PeriodSeconds(per));
   
   //if ( shift < 200 ) {
   if ( shift < 150 && candle_level < 70
     ) {
   
   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],Close[i],Time[scr_low_shift],scr_low_price);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_COLOR,clrRed);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_WIDTH,2);
   ObjectSetString(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_TOOLTIP,candle_level+"/"+shift);
   
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
   
  }
//+------------------------------------------------------------------+
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
// Thank You For Life 26.01.2024

