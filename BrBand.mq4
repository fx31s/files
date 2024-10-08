//+------------------------------------------------------------------+
//|                                                   EngulfBand.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=1;

input string MA_Indicator_Properties = "=======  Trend Moving Averages Properties ====="; //==================
extern bool Ma_Control=true; // Ma Control Order
input int MA_W=50;//Moving average period
input int MB_W=100;//Moving average period
input ENUM_MA_METHOD MaMethod=MODE_SMA;  // Ma Method
input ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price
input ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT; // Ma Period
//////////////////////////////////////////////////////////////////
input string RSI_Indicator_Properties = "=======  RSI Properties ====="; //==================
extern bool Rsi_Control=true; // Rsi Control Order
extern int RSILength=7; // Rsi Lenght
extern int SellThreshold=30; // Over Sell
extern int BuyThreshold=70; // Over Buy
//////////////////////////////////////////////////////////////////



//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
   
   

   
   

         
  for (int i=Bars-100;i>5;i--) {
  
  shift=i;
  
         double iaos1=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift);
         double iaos2=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift+1);
         double iaos3=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift+2);

  
   double Band_Low = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,shift);
   double Band_High = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,shift);
   double Band_Main = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_MAIN,shift);
   
   double MA=iMA(Symbol(), MaTimeA, MA_W, ma_shift, MaMethod, MaPrice, shift); 
   double MB=iMA(Symbol(), MaTimeA, MB_W, ma_shift, MaMethod, MaPrice, shift); 
   
   double RSI=iRSI(Symbol(), PERIOD_CURRENT, RSILength, PRICE_CLOSE, shift);
   double RSIS=iRSI(Symbol(), PERIOD_CURRENT, RSILength, PRICE_CLOSE, shift+1);
   
  // if ( Band_High > MA && Band_Low < MA ) {} else {continue;}
   
   if ( MA > Band_High || MA < Band_Low ) continue;
   


//////////////////////////////////////////


if ( MB < MA //|| MB < MA

&& iaos1 > 0 && iaos2 > 0 && iaos3 > 0 

 ) {

bool find=false;
double price=High[i];
int shift=i;
for (int r=i+1;r<i+6;r++) {

if ( price < High[r] ) {
shift=r;
find=true;
}

}




if ( find == false && High[i] > High[i-1] && High[i] > High[i+1] && Open[i] > Band_Main
 ) {

 ObjectCreate(ChartID(),"H"+i,OBJ_TREND,0,Time[i],High[i],Time[i+6],High[i]);
 ObjectSetInteger(ChartID(),"H"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"H"+i,OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"H"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"H"+i,OBJPROP_RAY,False);
 
bool find=false;
double price=High[i];
int shift=i;
int say=0;

if ( Open[i] < Close[i] ) say=1;

for (int r=i+1;r<i+6;r++) {

if ( find==true ) continue;

if ( Open[r] < Close[r] ) {
say=say+1;
shift=r;
} else {
find=true;
}
}



if ( say < 4 && find == true ) {

 ObjectCreate(ChartID(),"HR"+i,OBJ_TREND,0,Time[shift],Low[shift],Time[i],High[i]);
 ObjectSetInteger(ChartID(),"HR"+i,OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"HR"+i,OBJPROP_COLOR,clrOrange);
 ObjectSetInteger(ChartID(),"HR"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HR"+i,OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"HR"+i,OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"HR"+i,OBJPROP_WIDTH,2);
 
 
bool find=false;
double price=High[i];
int shift=i;
int say=0;


for (int r=i+1;r<i+6;r++) {

double Band_Highs = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,r);
double Band_Highss = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,r-1);

if ( find==true ) continue;

if ( High[r] > Band_Highs && High[r-1] < Band_Highss) {
say=say+1;
shift=r;
find=true;
}
}
 
 if ( find == true ) {


 ObjectCreate(ChartID(),"HBT"+shift,OBJ_TREND,0,Time[shift],High[shift],Time[i],High[i]);
 ObjectSetInteger(ChartID(),"HBT"+shift,OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"HBT"+shift,OBJPROP_COLOR,clrLimeGreen);
 ObjectSetInteger(ChartID(),"HBT"+shift,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBT"+shift,OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"HBT"+shift,OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"HBT"+shift,OBJPROP_WIDTH,2);
 
 double price=Low[shift];
 int shiftt=shift;
 for(int r=shift;r>=i;r--) {
 
 if ( Low[r] < price ) {price=Low[r];
 shiftt=r;
 }
 }
 
 
 ObjectCreate(ChartID(),"HBL"+shift,OBJ_TREND,0,Time[shiftt],Low[shiftt],Time[i],Low[shiftt]);
 ObjectSetInteger(ChartID(),"HBL"+shift,OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"HBL"+shift,OBJPROP_COLOR,clrBlue);
 ObjectSetInteger(ChartID(),"HBL"+shift,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBL"+shift,OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"HBL"+shift,OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"HBL"+shift,OBJPROP_WIDTH,2);
 
 ObjectCreate(ChartID(),"HBLO"+shift,OBJ_TREND,0,Time[i],Low[shiftt],Time[i]+3*PeriodSeconds(),Low[shiftt]);
 ObjectSetInteger(ChartID(),"HBLO"+shift,OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"HBLO"+shift,OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"HBLO"+shift,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBLO"+shift,OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"HBLO"+shift,OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"HBLO"+shift,OBJPROP_WIDTH,2);

 
 
 
  
 }
 
 
 }
 


 
 

}




}




continue;


//////////////////////////////////////////


if ( MB > MA //|| MB < MA

&& iaos1 < 0 && iaos2 < 0 && iaos3 < 0 

 ) {

bool find=false;
double price=Low[i];
int shift=i;
for (int r=i+1;r<i+6;r++) {

if ( price > Low[r] ) {
shift=r;
find=true;
}

}




if ( find == false && Low[i] < Low[i-1] && Low[i] < Low[i+1] && Open[i] < Band_Main
 ) {

 ObjectCreate(ChartID(),"L"+i,OBJ_TREND,0,Time[i],Low[i],Time[i+6],Low[i]);
 ObjectSetInteger(ChartID(),"L"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"L"+i,OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"L"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"L"+i,OBJPROP_RAY,False);
 
bool find=false;
double price=Low[i];
int shift=i;
int say=0;

if ( Open[i] > Close[i] ) say=1;

for (int r=i+1;r<i+6;r++) {

if ( find==true ) continue;

if ( Open[r] > Close[r] ) {
say=say+1;
shift=r;
} else {
find=true;
}
}



if ( say < 4 && find == true ) {

 ObjectCreate(ChartID(),"LR"+i,OBJ_TREND,0,Time[shift],High[shift],Time[i],Low[i]);
 ObjectSetInteger(ChartID(),"LR"+i,OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"LR"+i,OBJPROP_COLOR,clrOrange);
 ObjectSetInteger(ChartID(),"LR"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LR"+i,OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"LR"+i,OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"LR"+i,OBJPROP_WIDTH,2);
 
 
bool find=false;
double price=Low[i];
int shift=i;
int say=0;


for (int r=i+1;r<i+6;r++) {

double Band_Lows = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,r);
double Band_Lowss = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,r-1);

if ( find==true ) continue;

if ( Low[r] < Band_Lows && Low[r-1] > Band_Lowss) {
say=say+1;
shift=r;
find=true;
}
}
 
 if ( find == true ) {


 ObjectCreate(ChartID(),"LBT"+shift,OBJ_TREND,0,Time[shift],Low[shift],Time[i],Low[i]);
 ObjectSetInteger(ChartID(),"LBT"+shift,OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"LBT"+shift,OBJPROP_COLOR,clrLimeGreen);
 ObjectSetInteger(ChartID(),"LBT"+shift,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBT"+shift,OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"LBT"+shift,OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"LBT"+shift,OBJPROP_WIDTH,2);
 
 double price=High[shift];
 int shiftt=shift;
 for(int r=shift;r>=i;r--) {
 
 if ( High[r] > price ) {price=High[r];
 shiftt=r;
 }
 }
 
 
 ObjectCreate(ChartID(),"LBH"+shift,OBJ_TREND,0,Time[shiftt],High[shiftt],Time[i],High[shiftt]);
 ObjectSetInteger(ChartID(),"LBH"+shift,OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"LBH"+shift,OBJPROP_COLOR,clrBlue);
 ObjectSetInteger(ChartID(),"LBH"+shift,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBH"+shift,OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"LBH"+shift,OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"LBH"+shift,OBJPROP_WIDTH,2);
 
 ObjectCreate(ChartID(),"LBHO"+shift,OBJ_TREND,0,Time[i],High[shiftt],Time[i]+3*PeriodSeconds(),High[shiftt]);
 ObjectSetInteger(ChartID(),"LBHO"+shift,OBJPROP_BACK,False);
 ObjectSetInteger(ChartID(),"LBHO"+shift,OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"LBHO"+shift,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBHO"+shift,OBJPROP_RAY,False);
 ObjectSetString(ChartID(),"LBHO"+shift,OBJPROP_TOOLTIP,say);
 ObjectSetInteger(ChartID(),"LBHO"+shift,OBJPROP_WIDTH,2);

 
 
 
  
 }
 
 
 }
 


 
 

}




}








continue;


if (// Low[i] < Band_Low && 

Close[i] <= Band_Main && Close[i] > Open[i] && Open[i+1] > Close[i+1]

&& High[i] > High[i+1]

&& Low[i] < Low[i+1]

&& iaos1 < 0 && iaos2 < 0 && iaos3 < 0 

&& ( RSI <= 30 || RSIS <=30 )

&& Close[i] <= Band_Main

) {


 bool findt=false;
 int shiftt=i;

 for(int r=i+1;r<i+11;r++) {
 
 if ( findt == true ) continue;
 
double Band_Lows = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_LOWER,r);
 
 if ( Low[r] < Band_Lows ) {
 shiftt=r;
 findt=true;
 }
 
  }
  
  


 
 double price=Low[i];
 bool find=false;

 for(int r=i+1;r<i+11;r++) {
 
 if ( price > Low[r] ) find =true;
 
  }

 bool findb=false;
 int say=0;

 for(int r=i+1;r<i+11;r++) {
 
 if ( findb == true ) continue;
 
 if ( Close[r] < Open[r] ) {
 say=say+1;
 } else {
 findb=true;
 }
 
  }
  
  bool findo=false;
  int shifto=i;
  
  
 for(int r=i-1;r>i-4;r--) {
 
 if ( findo == true ) continue;
 
 if ( High[r] > High[i] && Low[r] > Low[i] ) {
 shifto=r;
 findo=true;
 }
 
  }
  
  
  
  
  

if ( find == false && say <= 3 ) {

 ObjectCreate(ChartID(),"HT"+i,OBJ_VLINE,0,Time[shiftt],Ask);
 ObjectSetInteger(ChartID(),"HT"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HT"+i,OBJPROP_COLOR,clrBlue);
 ObjectSetInteger(ChartID(),"HT"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HT"+i,OBJPROP_TOOLTIP,"BandTocuh");
 

 ObjectCreate(ChartID(),"LB"+i,OBJ_VLINE,0,Time[i],Ask);
 ObjectSetInteger(ChartID(),"LB"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"LB"+i,OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"LB"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"LB"+i,OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);

 ObjectCreate(ChartID(),"LBL"+i,OBJ_TREND,0,Time[i],Low[i],Time[i+11],Low[i]);
 ObjectSetInteger(ChartID(),"LBL"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"LBL"+i,OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"LBL"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBL"+i,OBJPROP_RAY,False);
 
 ObjectCreate(ChartID(),"LBR"+i,OBJ_TREND,0,Time[i],High[i],Time[i-5],High[i]);
 ObjectSetInteger(ChartID(),"LBR"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"LBR"+i,OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"LBR"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"LBR"+i,OBJPROP_RAY,False);
 
 if ( findo == true ) {
 ObjectCreate(ChartID(),"HO"+i,OBJ_VLINE,0,Time[shifto],Ask);
 ObjectSetInteger(ChartID(),"HO"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HO"+i,OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"HO"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HO"+i,OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);
 }
 
}



}
   
  
  
//continue;
  


   
if ( //High[i] > Band_High && 


Close[i] >= Band_Main && Open[i] > Close[i] && Close[i+1] > Open[i+1]

&& High[i] > High[i+1]

&& Low[i] < Low[i+1]

&& iaos1 > 0 && iaos2 > 0 && iaos3 > 0 

&& ( RSI >= 70 || RSIS >=70 )

&& Close[i] >= Band_Main

) {


 bool findt=false;
 int shiftt=i;

 for(int r=i+1;r<i+11;r++) {
 
 if ( findt == true ) continue;
 
double Band_Highs = iBands(Symbol(), ChartPeriod(ChartID()),20,2,0,PRICE_CLOSE, MODE_UPPER,r);
 
 
 if ( High[r] > Band_Highs ) {
 shiftt=r;
 findt=true;
 }
 
  }
  
  
  



 
 double price=High[i];
 bool find=false;

 for(int r=i+1;r<i+11;r++) {
 
 if ( price < High[r] ) find =true;
 
  }

 bool findb=false;
 int say=0;

 for(int r=i+1;r<i+11;r++) {
 
 if ( findb == true ) continue;
 
 if ( Close[r] > Open[r] ) {
 say=say+1;
 } else {
 findb=true;
 }
 
  }
  
  
  
  bool findo=false;
  int shifto=i;
  
  
 for(int r=i-1;r>i-4;r--) {
 
 if ( findo == true ) continue;
 
 if ( Low[r] < Low[i] && High[r] < High[i] ) {
 shifto=r;
 findo=true;
 }
 
  }
  
  
  
  
  

if ( find == false && say <= 3 ) {

 ObjectCreate(ChartID(),"HT"+i,OBJ_VLINE,0,Time[shiftt],Ask);
 ObjectSetInteger(ChartID(),"HT"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HT"+i,OBJPROP_COLOR,clrBlue);
 ObjectSetInteger(ChartID(),"HT"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HT"+i,OBJPROP_TOOLTIP,"BandTocuh");
 

 ObjectCreate(ChartID(),"HB"+i,OBJ_VLINE,0,Time[i],Ask);
 ObjectSetInteger(ChartID(),"HB"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HB"+i,OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"HB"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HB"+i,OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);

 ObjectCreate(ChartID(),"HBL"+i,OBJ_TREND,0,Time[i],High[i],Time[i+11],High[i]);
 ObjectSetInteger(ChartID(),"HBL"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HBL"+i,OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"HBL"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBL"+i,OBJPROP_RAY,False);
 
 ObjectCreate(ChartID(),"HBR"+i,OBJ_TREND,0,Time[i],Low[i],Time[i-5],Low[i]);
 ObjectSetInteger(ChartID(),"HBR"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HBR"+i,OBJPROP_COLOR,clrBlack);
 ObjectSetInteger(ChartID(),"HBR"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetInteger(ChartID(),"HBR"+i,OBJPROP_RAY,False);
 
 if ( findo == true ) {
 ObjectCreate(ChartID(),"HO"+i,OBJ_VLINE,0,Time[shifto],Ask);
 ObjectSetInteger(ChartID(),"HO"+i,OBJPROP_BACK,True);
 ObjectSetInteger(ChartID(),"HO"+i,OBJPROP_COLOR,clrChartreuse);
 ObjectSetInteger(ChartID(),"HO"+i,OBJPROP_STYLE,STYLE_DOT);
 ObjectSetString(ChartID(),"HO"+i,OBJPROP_TOOLTIP,RSI+"/"+RSIS+"/"+say+"/"+iaos1+"/"+iaos2+"/"+iaos3);
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
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
/////////////////////////////////////////////////////////////////////////////////////////////////////////
