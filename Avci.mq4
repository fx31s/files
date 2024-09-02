//+------------------------------------------------------------------+
//|                                                         Avci.mq4 |
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

int limit=20;

   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

   Ortalama=BarOrtalama(1,300,sym,per);
   
   
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

datetime top_time=-1;
datetime down_time=-1;

datetime order_time=-1;
datetime long_order_time=-1;
datetime short_order_time=-1;
double Lot=0.01;
int magic=369;

int long_ticket;
int short_ticket;

int tp=200;
int sl=100;

int short_say=0;
int long_say=0;

double top_find=false;
double down_find=false;

void OnTick()
  {
//---


int i=20;
limit=i;

double high_price=iHigh(sym,per,i);
double low_price=iLow(sym,per,i);

bool low_find=false;
for (int s=i+1;s<i+limit;s++) {
if ( low_price > iLow(sym,per,s) ) low_find=true;
}

bool low_find_right=false;
for (int s=i-1;s>i-5;s--) {
if ( s < 0 ) continue;
if ( low_price > iLow(sym,per,s) ) low_find_right=true;
}


if ( low_find == false && low_find_right == false ) {
ObjectCreate(ChartID(),"Distribition-Low"+Time[i],OBJ_TREND,0,Time[i],low_price,Time[i]+100*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),"Distribition-Low"+Time[i],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"Distribition-Low"+Time[i],OBJPROP_RAY,False);

long_say=0;

down_time=Time[i];
down_find=true;

}



bool high_find=false;
for (int s=i+1;s<i+limit;s++) {
if ( high_price < iHigh(sym,per,s) ) high_find=true;
}

bool high_find_right=false;
for (int s=i-1;s>i-5;s--) {
if ( s < 0 ) continue;
if ( high_price < iHigh(sym,per,s) ) high_find_right=true;
}


if ( high_find == false && high_find_right == false ) {
ObjectCreate(ChartID(),"Distribition-High"+Time[i],OBJ_TREND,0,Time[i],high_price,Time[i]+100*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),"Distribition-High"+Time[i],OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),"Distribition-High"+Time[i],OBJPROP_RAY,False);

short_say=0;

top_time=Time[i];
top_find=true;

}






/*
if ( int(TimeHour(TimeCurrent())) > 17 ) return;

if ( int(TimeHour(TimeCurrent())) < 4 ) return;
*/



int sonuc=BigBarControl(2,sym,per);


if ( sonuc == 0 && long_order_time != Time[2] && Time[2] > down_time && down_find == true ) {

long_say=long_say+1;

ObjectCreate(ChartID(),"Distribition-V"+Time[2],OBJ_TREND,0,Time[2],High[2],Time[2],Low[2]);
ObjectSetInteger(ChartID(),"Distribition-V"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"Distribition-V"+Time[2],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"Distribition-V"+Time[2],OBJPROP_WIDTH,3);
ObjectSetString(ChartID(),"Distribition-V"+Time[2],OBJPROP_TOOLTIP,long_say);


ObjectCreate(ChartID(),"Distribition-Vi"+Time[2],OBJ_TREND,0,Time[1],Low[1],Time[1]+15*PeriodSeconds(),Low[1]);
ObjectSetInteger(ChartID(),"Distribition-Vi"+Time[2],OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"Distribition-Vi"+Time[2],OBJPROP_RAY,False);


//long_ticket=OrderSend(sym,OP_BUYLIMIT,Lot,Low[1],0,Low[2],Low[1]+(High[2]-Low[2]),"AVCI-BUY",magic,0,clrNONE);
//long_ticket=OrderSend(sym,OP_BUYLIMIT,Lot,Low[1],0,Low[1]-150*Point,Low[1]+450*Point,"AVCI-BUY",magic,0,clrNONE);

//if ( Open[1] > Close[1] ) long_ticket=OrderSend(sym,OP_BUYLIMIT,Lot,Close[1],0,Close[1]-150*Point,Close[1]+450*Point,"AVCI-BUY",magic,0,clrNONE);
//if ( Close[1] > Open[1] ) long_ticket=OrderSend(sym,OP_BUYLIMIT,Lot,Open[1],0,Open[1]-150*Point,Open[1]+450*Point,"AVCI-BUY",magic,0,clrNONE);

if ( long_say == 2 ) {

OrderDelete(short_ticket,clrNONE);
OrderDelete(long_ticket,clrNONE);

datetime expire=Time[1]+20*PeriodSeconds();


if ( Open[1] > Close[1] ) long_ticket=OrderSend(sym,OP_BUYLIMIT,Lot,Close[1],0,Low[1]-sl*Point,Close[1]+tp*Point,"AVCI-BUY",magic,expire,clrNONE);
if ( Close[1] > Open[1] ) long_ticket=OrderSend(sym,OP_BUYLIMIT,Lot,Open[1],0,Low[1]-sl*Point,Open[1]+tp*Point,"AVCI-BUY",magic,expire,clrNONE);

down_find=false;


}


long_order_time=Time[2];

}


if ( sonuc == 1 && short_order_time != Time[2] && Time[2] > top_time && top_find == true) {


short_say=short_say+1;


ObjectCreate(ChartID(),"Distribition-V"+Time[2],OBJ_TREND,0,Time[2],High[2],Time[2],Low[2]);
ObjectSetInteger(ChartID(),"Distribition-V"+Time[2],OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),"Distribition-V"+Time[2],OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"Distribition-V"+Time[2],OBJPROP_WIDTH,3);
ObjectSetString(ChartID(),"Distribition-V"+Time[2],OBJPROP_TOOLTIP,short_say);


ObjectCreate(ChartID(),"Distribition-Vi"+Time[2],OBJ_TREND,0,Time[1],High[1],Time[1]+15*PeriodSeconds(),High[1]);
ObjectSetInteger(ChartID(),"Distribition-Vi"+Time[2],OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"Distribition-Vi"+Time[2],OBJPROP_RAY,False);


//short_ticket=OrderSend(sym,OP_SELLLIMIT,Lot,High[1],0,High[2],High[1]-(High[2]-Low[2]),"AVCI-SELL",magic,0,clrNONE);

//short_ticket=OrderSend(sym,OP_SELLLIMIT,Lot,High[1],0,High[1]+150*Point,High[1]-450*Point,"AVCI-SELL",magic,0,clrNONE);

//if ( Open[1] > Close[1] ) short_ticket=OrderSend(sym,OP_SELLLIMIT,Lot,Open[1],0,Open[1]+150*Point,Open[1]-450*Point,"AVCI-SELL",magic,0,clrNONE);
//if ( Close[1] > Open[1] ) short_ticket=OrderSend(sym,OP_SELLLIMIT,Lot,Close[1],0,Close[1]+150*Point,Close[1]-450*Point,"AVCI-SELL",magic,0,clrNONE);

if ( short_say == 2 ) {

OrderDelete(long_ticket,clrNONE);
OrderDelete(short_ticket,clrNONE);

datetime expire=Time[1]+20*PeriodSeconds();

if ( Open[1] > Close[1] ) short_ticket=OrderSend(sym,OP_SELLLIMIT,Lot,Open[1],0,High[1]+sl*Point,Open[1]-tp*Point,"AVCI-SELL",magic,expire,clrNONE);
if ( Close[1] > Open[1] ) short_ticket=OrderSend(sym,OP_SELLLIMIT,Lot,Close[1],0,High[1]+sl*Point,Close[1]-tp*Point,"AVCI-SELL",magic,expire,clrNONE);

top_find=false;


}


short_order_time=Time[2];

}




   
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
