//+------------------------------------------------------------------+
//|                                                consolidation.mq4 |
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


//Print(i);



double high_price=iHigh(sym,per,i);
double low_price=iLow(sym,per,i);
double open_price=iOpen(sym,per,i);
double close_price=iClose(sym,per,i);
datetime time=iTime(sym,per,i);


double range_high=high_price;
double range_low=low_price;

if ( close_price > open_price ) {
range_low=close_price;
}

if ( open_price > close_price ) {
range_high=open_price;
}




int c=0;
int touch=0;
bool find=false;
int shift=0;
datetime ctime;

////////////////////////////////////////////////////////////////////////
// High
////////////////////////////////////////////////////////////////////////
for(int r=i-1;r>i-10;r--) {

if ( r < 0 ) continue;

double high_prices=iHigh(sym,per,r);
double low_prices=iLow(sym,per,r);
double open_prices=iOpen(sym,per,r);
double close_prices=iClose(sym,per,r);
datetime times=iTime(sym,per,r);


if ( find == false ) {
if ( close_prices < high_price && open_prices < high_price ) {
c=c+1;
shift=r;
ctime=times;

if ( high_prices >= high_price || high_prices >= range_low   ) {
touch=touch+1;
}




} else {
find=true;
}
} 








}


if ( c>=6 && touch >=3 ) {


double down_price=low_price;
int down_shift=i;

for(int y=i;y>=shift;y--) {

double low_pricex=iLow(sym,per,y);

if ( down_price > low_pricex ) {down_price=low_pricex;
down_shift=y;
}


}

double range=high_price-down_price;
double range_oran=DivZero(range,bar_ortalama);


if ( range_oran < 3 ) {

ObjectCreate(ChartID(),"T"+ctime,OBJ_TREND,0,time,high_price,ctime,high_price);
ObjectSetInteger(ChartID(),"T"+ctime,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+ctime,OBJPROP_COLOR,clrLightGray);


ObjectCreate(ChartID(),"TL"+ctime,OBJ_TREND,0,time,down_price,ctime,down_price);
ObjectSetInteger(ChartID(),"TL"+ctime,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+ctime,OBJPROP_COLOR,clrYellow);
ObjectSetString(ChartID(),"TL"+ctime,OBJPROP_TOOLTIP,range_oran);

}



}
/////////////////////////////////////////////////////////////////////////////////////////////////////////









c=0;
touch=0;
find=false;
shift=0;
ctime;

////////////////////////////////////////////////////////////////////////
// Low
////////////////////////////////////////////////////////////////////////
for(int r=i-1;r>i-10;r--) {

if ( r < 0 ) continue;

double high_prices=iHigh(sym,per,r);
double low_prices=iLow(sym,per,r);
double open_prices=iOpen(sym,per,r);
double close_prices=iClose(sym,per,r);
datetime times=iTime(sym,per,r);


if ( find == false ) {
if ( close_prices > low_price && open_prices > low_price ) {
c=c+1;
shift=r;
ctime=times;

if ( low_prices <= low_price || low_prices <= range_high ) {
touch=touch+1;
}




} else {
find=true;
}
} 








}


if ( c>=6 && touch >=3 ) {


double up_price=high_price;
int up_shift=i;

for(int y=i;y>=shift;y--) {

double high_pricex=iHigh(sym,per,y);

if ( up_price < high_pricex ) {up_price=high_pricex;
up_shift=y;
}


}

double range=up_price-low_price;
double range_oran=DivZero(range,bar_ortalama);


if ( range_oran < 3 ) {

ObjectCreate(ChartID(),"T"+ctime,OBJ_TREND,0,time,low_price,ctime,low_price);
ObjectSetInteger(ChartID(),"T"+ctime,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+ctime,OBJPROP_COLOR,clrLightGray);


ObjectCreate(ChartID(),"TL"+ctime,OBJ_TREND,0,time,up_price,ctime,up_price);
ObjectSetInteger(ChartID(),"TL"+ctime,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+ctime,OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),"TL"+ctime,OBJPROP_TOOLTIP,range_oran);

}



}
/////////////////////////////////////////////////////////////////////////////////////////////////////////








}


}

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
//Td[t1][0]=DivZero(CurrStrength[t1],CurrCount[t1]); 
//bid_ratio=DivZero(curr_bid-day_low,day_high-day_low);
