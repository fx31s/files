//+------------------------------------------------------------------+
//|                                                        WDoji.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double Ortalama;

 double govde_oran=20;
 double ust_oran=30;
 double alt_oran=30; 
 
 double birinci_mum_orani=1;
 //double ucuncu_mum_orani=2;
 double ucuncu_mum_orani=1;
 
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
        string sym=Symbol();
      int per=Period();
   
  int bar_ortalama_bar=300;

  
  double bar_ortalama=BarOrtalama(1,bar_ortalama_bar,sym,per);
  
  Comment("Ortalama:",bar_ortalama/Point);
  
 
  for ( int i=2;i<Bars-20;i++) {
  
  int shift=i;
  double high_price=iHigh(sym,per,shift);
  double low_price=iLow(sym,per,shift);
  double open_price=iOpen(sym,per,shift);
  double close_price=iClose(sym,per,shift);
  
  int shifts=i-1;
  double high_prices=iHigh(sym,per,shifts);
  double low_prices=iLow(sym,per,shifts);
  double open_prices=iOpen(sym,per,shifts);
  double close_prices=iClose(sym,per,shifts);
  
  
  if ( (iClose(sym,per,i+1) > iOpen(sym,per,i+1) && iClose(sym,per,i+2) > iOpen(sym,per,i+2)// && iClose(sym,per,i+3) > iOpen(sym,per,i+3)
  
  ) ||
  
  (iClose(sym,per,i+1) < iOpen(sym,per,i+1) && iClose(sym,per,i+2) < iOpen(sym,per,i+2) //&& iClose(sym,per,i+3) < iOpen(sym,per,i+3)
  
  ) ) {
  
  } else {
  
  continue;
  
  }
  
  
/*
  if ( (   
  
  
  (iClose(sym,per,i+1) - iOpen(sym,per,i+1))/Point >= (bar_ortalama/Point)*2
  
  ||
  
  (iClose(sym,per,i+2) - iOpen(sym,per,i+2))/Point >= (bar_ortalama/Point)*2
  
  ||
  
  (iClose(sym,per,i+3) - iOpen(sym,per,i+3))/Point >= (bar_ortalama/Point)*2
  
  
  
  
    
     
     
     ) ||
  

  (iOpen(sym,per,i+1) - iClose(sym,per,i+1))/Point >= (bar_ortalama/Point)*2
  
  ||
  
  (iOpen(sym,per,i+2) - iClose(sym,per,i+2))/Point >= (bar_ortalama/Point)*2
  
  ||
  
  (iOpen(sym,per,i+3) - iClose(sym,per,i+3))/Point >= (bar_ortalama/Point)*2  
  
  
  
  
  
   ) {
  
  } else {
  
  continue;
  
  }
  */
    
  
  
  if ( (open_price > close_price && (open_price - close_price) <= bar_ortalama/Point) || 
  
  (close_price > open_price && (close_price-open_price) <= bar_ortalama/Point)
  
  ) {
  
  double fark=MathAbs(open_price-close_price);
  
  double farks=MathAbs(open_prices-close_prices);
  
  if ( fark/Point <= (bar_ortalama/Point)/1.5 && farks/Point <= (bar_ortalama/Point)/1.5 ) {
  

string last_select_objectr="WDoji"+i;


double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i],high_price,Time[i]+10*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i],low_price,Time[i]+10*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=10;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],high_prices,Time[i-1]+10*PeriodSeconds(),high_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=11;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],low_prices,Time[i-1]+10*PeriodSeconds(),low_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);


levels=20;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
if ( high_prices > high_price ) ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],high_prices,Time[i-1]+10*PeriodSeconds(),high_prices);
if ( high_price > high_prices ) ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i],high_price,Time[i]+10*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

levels=21;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
if ( low_prices < low_price ) ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],low_prices,Time[i-1]+10*PeriodSeconds(),low_prices);
if ( low_price < low_prices ) ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i],low_price,Time[i]+10*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

double hprice;
if ( high_prices > high_price ) hprice=high_prices;
if ( high_price > high_prices ) hprice=high_price;

double lprice;
if ( low_prices < low_price ) lprice=low_prices;
if ( low_price < low_prices ) lprice=low_price;

double yuzde=DivZero(hprice-lprice,100);

levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],lprice-levels*yuzde,Time[i-1]+10*PeriodSeconds(),lprice-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);

levels=13.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i-1],hprice+levels*yuzde,Time[i-1]+10*PeriodSeconds(),hprice+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,2);
  
  
  }
  
  }
  
  
  }
  
  
  
   
   return INIT_SUCCEEDED;
   
   for (int ii=1;ii<Bars-20;ii++) {
   
   bool doji_one=DojiCheck(ii,false);
   //bool doji_two=DojiCheck(ii-1,false);
   
   if ( doji_one == true //&& doji_two == true 
   ) {
   
   bool doji_one=DojiCheck(ii,true);
   //bool doji_two=DojiCheck(ii-1,true);
   
   }
   
   
   } 
   
   
   
   
   
   
 


  
 

 for (int i=1;i<Bars-20;i++) {
   


//int i=0;
/////////////////////////////////////////////////////////////
   int shift=i;
   double high_price=iHigh(sym,per,shift);
   double low_price=iLow(sym,per,shift);
   double open_price=iOpen(sym,per,shift);
   double close_price=iClose(sym,per,shift);
   datetime time_date=iTime(sym,per,shift);
   
   double high_low_yuzde=DivZero((high_price-low_price),100);
   
   double fark=0;
   double ust_fark=0;
   double alt_fark=0;
   if ( open_price > close_price ) {   
   fark=open_price-close_price;      
   ust_fark=high_price-open_price;
   alt_fark=close_price-low_price;
   }
   if ( close_price > open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   }
   
   if ( close_price == open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   }
      
           
   double govde_yuzde=DivZero(fark,high_low_yuzde);
   
   double ust_yuzde=DivZero(ust_fark,high_low_yuzde);
   double alt_yuzde=DivZero(alt_fark,high_low_yuzde);
   
   double eq_price=low_price+high_low_yuzde*50;
   
   
   shift=i+1;
   double high_prices=iHigh(sym,per,shift);
   double low_prices=iLow(sym,per,shift);
   double open_prices=iOpen(sym,per,shift);
   double close_prices=iClose(sym,per,shift);
   datetime time_dates=iTime(sym,per,shift);
      
   
//////////////////////////////////////////////////////////////////////   

   if ( govde_yuzde < govde_oran && ust_yuzde >=ust_oran && alt_yuzde >=alt_oran ) {
   
   
if ( close_prices > open_prices && (close_prices-open_prices) >= bar_ortalama*ucuncu_mum_orani) {

string last_select_objectr="WDoji"+i;


double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i+1],high_prices,Time[i+1]+10*PeriodSeconds(),high_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i+1],low_prices,Time[i+1]+10*PeriodSeconds(),low_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);



}   
   
   if ( open_prices > close_prices && (open_prices-close_prices) >= bar_ortalama*ucuncu_mum_orani   ) {         
 
string last_select_objectr="WDoji"+i;

double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i+1],high_prices,Time[i+1]+10*PeriodSeconds(),high_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i+1],low_prices,Time[i+1]+10*PeriodSeconds(),low_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);
 
 
}   
  
  
   
   }
      
      
      

   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   
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
   if ( iClose(Sym,Per,t) > iOpen(Sym,Per,t) ) bar_pip = bar_pip + (iClose(Sym,Per,t)-iOpen(Sym,Per,t));
   if ( iClose(Sym,Per,t) < iOpen(Sym,Per,t) ) bar_pip = bar_pip + (iOpen(Sym,Per,t)-iClose(Sym,Per,t));
   
   //Print(t,"/",bar_pip,"/",(iClose(Sym,Per,t)-iOpen(Sym,Per,t)),"/",(iOpen(Sym,Per,t)-iClose(Sym,Per,t)));
   
   }
  
   
   bar_ortalama = DivZero(bar_pip,bar_toplam);
   
   //Print(bar_ortalama,"/",bar_toplam,"/",bar_pip);
   
   return bar_ortalama;

}

double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 



bool DojiCheck(int i,bool paint) {

int bar_ortalama_bar=300;


      string sym=Symbol();
      int per=Period();

  
  double bar_ortalama=BarOrtalama(1,bar_ortalama_bar,sym,per);
  
  Comment("Ortalama:",bar_ortalama);
  
  bool sonuc=false;



//int i=0;
/////////////////////////////////////////////////////////////
   int shift=i;
   double high_price=iHigh(sym,per,shift);
   double low_price=iLow(sym,per,shift);
   double open_price=iOpen(sym,per,shift);
   double close_price=iClose(sym,per,shift);
   datetime time_date=iTime(sym,per,shift);
   
   double high_low_yuzde=DivZero((high_price-low_price),100);
   
   double fark=0;
   double ust_fark=0;
   double alt_fark=0;
   if ( open_price > close_price ) {   
   fark=open_price-close_price;      
   ust_fark=high_price-open_price;
   alt_fark=close_price-low_price;
   }
   if ( close_price > open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   }
   
   if ( close_price == open_price ) {   
   fark=close_price-open_price;     
   ust_fark=high_price-close_price;
   alt_fark=open_price-low_price;   
   }
      
           
   double govde_yuzde=DivZero(fark,high_low_yuzde);
   
   double ust_yuzde=DivZero(ust_fark,high_low_yuzde);
   double alt_yuzde=DivZero(alt_fark,high_low_yuzde);
   
   double eq_price=low_price+high_low_yuzde*50;
   
   
   shift=i+1;
   double high_prices=iHigh(sym,per,shift);
   double low_prices=iLow(sym,per,shift);
   double open_prices=iOpen(sym,per,shift);
   double close_prices=iClose(sym,per,shift);
   datetime time_dates=iTime(sym,per,shift);
      
   
//////////////////////////////////////////////////////////////////////   

   if ( govde_yuzde < govde_oran && ust_yuzde >=ust_oran && alt_yuzde >=alt_oran ) {
   
   
if ( close_prices > open_prices && (close_prices-open_prices) >= bar_ortalama*ucuncu_mum_orani) {

string last_select_objectr="WDoji"+i;

if ( paint == true ) {
double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i+1],high_prices,Time[i+1]+10*PeriodSeconds(),high_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i+1],low_prices,Time[i+1]+10*PeriodSeconds(),low_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);
}

sonuc=true;


}   
   
   if ( open_prices > close_prices && (open_prices-close_prices) >= bar_ortalama*ucuncu_mum_orani   ) {         
 
 
if ( paint == true ) {
 
string last_select_objectr="WDoji"+i;


double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i+1],high_prices,Time[i+1]+10*PeriodSeconds(),high_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_objectr+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_objectr+"Exp"+level,OBJ_TREND,0,Time[i+1],low_prices,Time[i+1]+10*PeriodSeconds(),low_prices);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_STYLE,STYLE_DASHDOTDOT);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_BACK,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_objectr+"Exp"+level,OBJPROP_WIDTH,1);
 
}

 sonuc=true;
 
}   
  
  
   
   }
      
      
      

   
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
   
   
   return sonuc;

}
