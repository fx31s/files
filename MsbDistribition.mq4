//+------------------------------------------------------------------+
//|                                              MsbDistribition.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double Ortalama;
int carpan=8;
int carpans=2;
int carpann=10;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

ObjectsDeleteAll();


Print(TimeDay(TimeCurrent()));

   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   Ortalama=BarOrtalama(1,300,sym,per);
   //timeday=int(TimeDay(TimeCurrent()));
   
   Comment(Ortalama);
   
   
   int limit=50;

for (int i=Bars-500;i>0;i--) {


double high_price=iHigh(sym,per,i);
double low_price=iLow(sym,per,i);

bool low_find=false;
for (int s=i+1;s<i+limit;s++) {
if ( low_price > iLow(sym,per,s) ) low_find=true;
}

bool low_find_right=false;
for (int s=i-1;s>i-limit;s--) {
if ( s < 0 ) continue;
if ( low_price > iLow(sym,per,s) ) low_find_right=true;
}


if ( low_find == false && low_find_right == false ) {
ObjectCreate(ChartID(),"Low"+i,OBJ_TREND,0,Time[i],low_price,Time[i]+100*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),"Low"+i,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"Low"+i,OBJPROP_RAY,False);



int big_find=0;
for (int si=i-1;si>i-limit;si--) {
if ( si < 0 ) continue;

int sonuc=BigBarControl(si,sym,per);

if ( sonuc == 0 && big_find < 2 && iLow(sym,per,si) > high_price ) {

ObjectCreate(ChartID(),"V"+si,OBJ_TREND,0,Time[si],High[si],Time[si],Low[si]);
ObjectSetInteger(ChartID(),"V"+si,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"V"+si,OBJPROP_RAY,False);
big_find=big_find+1;
ObjectSetString(ChartID(),"V"+si,OBJPROP_TOOLTIP,big_find);

if ( big_find == 2 ) {

ObjectCreate(ChartID(),"Vi"+si,OBJ_TREND,0,Time[si-1],Low[si-1],Time[si-1]+15*PeriodSeconds(),Low[si-1]);
ObjectSetInteger(ChartID(),"Vi"+si,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"Vi"+si,OBJPROP_RAY,False);


}




}

}



}



bool high_find=false;
for (int s=i+1;s<i+limit;s++) {
if ( high_price < iHigh(sym,per,s) ) high_find=true;
}

bool high_find_right=false;
for (int s=i-1;s>i-limit;s--) {
if ( s < 0 ) continue;
if ( high_price < iHigh(sym,per,s) ) high_find_right=true;
}


if ( high_find == false && high_find_right == false ) {
ObjectCreate(ChartID(),"High"+i,OBJ_TREND,0,Time[i],high_price,Time[i]+100*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),"High"+i,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),"High"+i,OBJPROP_RAY,False);

int big_find=0;
for (int si=i-1;si>i-limit;si--) {
if ( si < 0 ) continue;

int sonuc=BigBarControl(si,sym,per);

if ( sonuc == 1 && big_find < 2 && iHigh(sym,per,si) < low_price ) {

ObjectCreate(ChartID(),"V"+si,OBJ_TREND,0,Time[si],High[si],Time[si],Low[si]);
ObjectSetInteger(ChartID(),"V"+si,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"V"+si,OBJPROP_RAY,False);
big_find=big_find+1;

if ( big_find == 2 ) {

ObjectCreate(ChartID(),"Vi"+si,OBJ_TREND,0,Time[si-1],High[si-1],Time[si-1]+15*PeriodSeconds(),High[si-1]);
ObjectSetInteger(ChartID(),"Vi"+si,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"Vi"+si,OBJPROP_RAY,False);


}



}

}





}






/*
int sonuc=BigBarControl(i,sym,per);

if ( sonuc == 0 ) {

ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrLimeGreen);


}

if ( sonuc == 1 ) {
ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"V"+i,OBJPROP_COLOR,clrCrimson);
}


*/



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




int BigBarControl(int bi,string sym,string per) {

int sonuc=-1;

  // string select_sym=Symbol();
  // int select_per=Period();
   
    
    
    //Comment("Ortalam:",Ortalama/Point);
    
   //for ( int i=1000;i>0;i--) {
   
   
   if ( (iHigh(sym,per,bi) - iLow(sym,per,bi) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(select_sym,select_per,i),0);
   //Print(i);   
   }
   
   if ( (iClose(sym,per,bi) - iOpen(sym,per,bi) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(sym,per,i),0);
   //ObjectSetInteger(ChartID(),"VLINE"+Time[i],OBJPROP_BACK,true);
   //Print(i);   
   sonuc=0;
   }
      
   if ( (iOpen(sym,per,bi) - iClose(sym,per,bi) ) >= Ortalama*carpans ) {
   
   //ObjectCreate(ChartID(),"VLINE"+Time[i],OBJ_VLINE,0,iTime(sym,per,i),0);
   //ObjectSetInteger(ChartID(),"VLINE"+Time[i],OBJPROP_BACK,true);
   sonuc=1;
   //Print(i);   
   }
   
         
   
   
   
   //}
   
   
  
   
   
   return sonuc;
   
   
   }
   
   

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

