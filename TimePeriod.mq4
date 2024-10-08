//+------------------------------------------------------------------+
//|                                                   TimePeriod.mq4 |
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
   
   

  Ortalama=BarOrtalama(1,300,Symbol(),PERIOD_M5);
  
  //double limit=Ortalama*3;
  double limit=Ortalama*1.5;
  
  
  
     
      
   ObjectsDeleteAll();
   
   for (int t=0;t<10;t++) {
   
   
   ObjectCreate(ChartID(),"Time"+t,OBJ_RECTANGLE,0,iTime(Symbol(),PERIOD_M5,t),iHigh(Symbol(),PERIOD_M5,t),iTime(Symbol(),PERIOD_M5,t)+PeriodSeconds(PERIOD_M5),iHigh(Symbol(),PERIOD_M5,t)+500*Point());

   int time1_shift=iBarShift(Symbol(),PERIOD_M1,iTime(Symbol(),PERIOD_M5,t));
   int time2_shift=iBarShift(Symbol(),PERIOD_M1,iTime(Symbol(),PERIOD_M5,t)+(PeriodSeconds(PERIOD_M1)*3));
   
   if ( t == 0 ) {
   
   ObjectCreate(ChartID(),"V0",OBJ_VLINE,0,iTime(Symbol(),PERIOD_M1,time1_shift)+(PeriodSeconds(PERIOD_M1)*2),Ask);
   ObjectSetInteger(ChartID(),"V0",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"V0",OBJPROP_COLOR,clrBlack);
   
   ObjectCreate(ChartID(),"OP0"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift],Time[time1_shift]+(PeriodSeconds(PERIOD_M1)*3),Open[time1_shift]);
   ObjectSetInteger(ChartID(),"OP0"+t,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"OP0"+t,OBJPROP_COLOR,clrBlack);

   ObjectCreate(ChartID(),"UP"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift]+limit,Time[time1_shift]+(PeriodSeconds(PERIOD_M1)*3),Open[time1_shift]+limit);
   ObjectSetInteger(ChartID(),"UP"+t,OBJPROP_RAY,False);
   ObjectCreate(ChartID(),"DOWN"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift]-limit,Time[time1_shift]+(PeriodSeconds(PERIOD_M1)*3),Open[time1_shift]-limit);
   ObjectSetInteger(ChartID(),"DOWN"+t,OBJPROP_RAY,False);
   

   ObjectCreate(ChartID(),"UPT"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift]+limit*2,Time[time1_shift]+(PeriodSeconds(PERIOD_M1)*3),Open[time1_shift]+limit*2);
   ObjectSetInteger(ChartID(),"UPT"+t,OBJPROP_RAY,False);
   ObjectCreate(ChartID(),"DOWNT"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift]-limit*2,Time[time1_shift]+(PeriodSeconds(PERIOD_M1)*3),Open[time1_shift]-limit*2);
   ObjectSetInteger(ChartID(),"DOWNT"+t,OBJPROP_RAY,False);
   
   
   
   } else {


   ObjectCreate(ChartID(),"OP"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift],Time[time2_shift],Open[time1_shift]);
   ObjectSetInteger(ChartID(),"OP"+t,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),"OP"+t,OBJPROP_COLOR,clrBlack);
   
   
   ObjectCreate(ChartID(),"UP"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift]+limit,Time[time2_shift],Open[time1_shift]+limit);
   ObjectSetInteger(ChartID(),"UP"+t,OBJPROP_RAY,False);
   ObjectCreate(ChartID(),"DOWN"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift]-limit,Time[time2_shift],Open[time1_shift]-limit);
   ObjectSetInteger(ChartID(),"DOWN"+t,OBJPROP_RAY,False);
   

   ObjectCreate(ChartID(),"UPT"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift]+limit*2,Time[time2_shift],Open[time1_shift]+limit*2);
   ObjectSetInteger(ChartID(),"UPT"+t,OBJPROP_RAY,False);
   ObjectCreate(ChartID(),"DOWNT"+t,OBJ_TREND,0,Time[time1_shift],Open[time1_shift]-limit*2,Time[time2_shift],Open[time1_shift]-limit*2);
   ObjectSetInteger(ChartID(),"DOWNT"+t,OBJPROP_RAY,False);
   
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


datetime refresh_time;
void OnTick()
  {
//---
   
   
   if ( refresh_time != Time[1] ) {
   
   OnInit();
   refresh_time=Time[1];
   }
   
	int min, sec;
	
   min = iTime(Symbol(),PERIOD_M5,0) + PERIOD_M5*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec");
   
   
   
   
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


