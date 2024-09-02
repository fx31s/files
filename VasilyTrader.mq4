//+------------------------------------------------------------------+
//|                                                 VasilyTrader.mq4 |
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
   
   
   EntryPoint();
   
   
   
   
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



if ( sparam == 45 ) {

ObjectsDeleteAll();
EntryPoint();


}





   
  }
//+------------------------------------------------------------------+
int ortalama_last_bar= -1;
double Ortalama;
 
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
  
  
  


void EntryPoint() {

int seb=20;

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();

double bar_ortalama=BarOrtalama(1,300,sym,per);

Comment("Bar Ortalama:",int(bar_ortalama/Point));



for(int i=1500;i>=0;i--) {

double high_price=iHigh(sym,per,i);
double low_price=iLow(sym,per,i);
double open_price=iOpen(sym,per,i);
double close_price=iClose(sym,per,i);
datetime time=iTime(sym,per,i);

//////////////////////////////////////////////////////////////////////////////////
/// LOW
//////////////////////////////////////////////////////////////////////////////////
bool find=false;
int shift=i;

for(int t=i+1;t<i+seb;t++) {

if ( iLow(sym,per,t) < low_price ) {
find=true;
}

}


bool find_right=false;

for(int t=i-1;t>i-seb;t--) {

if ( t < 0 ) continue;

if ( iLow(sym,per,t) < low_price ) {
find_right=true;
}

}





if (find==false && find_right==false) {
ObjectCreate(ChartID(),"Low"+time,OBJ_VLINE,0,time,Ask);


ObjectCreate(ChartID(),"T"+time,OBJ_TREND,0,time,low_price,time+100*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),"T"+time,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+time,OBJPROP_COLOR,clrLightGray);


if ( iOpen(sym,per,i) < iClose(sym,per,i) ) ObjectCreate(ChartID(),"TL"+time,OBJ_TREND,0,time,open_price,time+100*PeriodSeconds(),open_price);
if ( iOpen(sym,per,i) > iClose(sym,per,i) ) ObjectCreate(ChartID(),"TL"+time,OBJ_TREND,0,time,close_price,time+100*PeriodSeconds(),close_price);
ObjectSetInteger(ChartID(),"TL"+time,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+time,OBJPROP_COLOR,clrLightGray);

}
////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
// HIGH
//////////////////////////////////////////////////////////////////////////////////
find=false;
shift=i;

for(int t=i+1;t<i+seb;t++) {

if ( iHigh(sym,per,t) > high_price ) {
find=true;
}

}


find_right=false;

for(int t=i-1;t>i-seb;t--) {

if ( t < 0 ) continue;

if ( iHigh(sym,per,t) > high_price ) {
find_right=true;
}

}





if (find==false && find_right==false) {
ObjectCreate(ChartID(),"High"+time,OBJ_VLINE,0,time,Ask);


ObjectCreate(ChartID(),"T"+time,OBJ_TREND,0,time,high_price,time+100*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),"T"+time,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+time,OBJPROP_COLOR,clrLightGray);


if ( iOpen(sym,per,i) > iClose(sym,per,i) ) ObjectCreate(ChartID(),"TH"+time,OBJ_TREND,0,time,open_price,time+100*PeriodSeconds(),open_price);
if ( iOpen(sym,per,i) < iClose(sym,per,i) ) ObjectCreate(ChartID(),"TH"+time,OBJ_TREND,0,time,close_price,time+100*PeriodSeconds(),close_price);
ObjectSetInteger(ChartID(),"TH"+time,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TH"+time,OBJPROP_COLOR,clrLightGray);

}
////////////////////////////////////////////////////////////////////////////////



//Print(i);



}




}