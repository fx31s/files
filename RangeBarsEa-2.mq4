//+------------------------------------------------------------------+
//|                                                  RangeBarsEa.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//---
ENUM_TIMEFRAMES PERIOD_M3=3;
//---
extern double Step    =0.02;   //Parabolic setting
extern double Maximum =0.2;    //Parabolic setting
extern double    Lots=1;
extern int       Slip=5;
extern int     flag1=0;
string sym=Symbol();

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   EventSetTimer(1);
   
   ObjectsDeleteAll(ChartID(),-1,OBJ_VLINE);
   ChartRedraw();
  
  
  ChartSetInteger(ChartID(),CHART_AUTOSCROLL,true);
  
  
/*
RefreshRates();

double ma=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_CLOSE, 1);
double mal=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_LOW, 1);


Print(ma,"/",mal);
 Print("Close:",iClose(sym,PERIOD_CURRENT,1),"/",ma);
 Print("Low:",iLow(sym,PERIOD_CURRENT,1),"/",mal);

   */
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
  
  
  if ( IsTesting() ) OnTimer();
//---
/*
Print("Deneme");
RefreshRates();
double ma=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_CLOSE, 1);
double mal=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_LOW, 1);

 Print("Close:",iClose(sym,PERIOD_CURRENT,1),"/",ma);
 Print("Low:",iLow(sym,PERIOD_CURRENT,1),"/",mal);
*/
  
 
   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+

extern int sl_pip=15;
extern int tp_pip=28;
extern int magic=311;
extern double Lot=0.01;


bool up_flag=false;

void OnTimer()
  {
  

bool find=false;
int sar_shift=0;
bool sar_up=false;
bool sar_down=false;

for ( int i=0;i<50;i++) {
double isar1=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+1);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);

if ( Close[i+1] < isar1 && Close[i+2] > isar2 && find == false ) {find=true;sar_shift=i;sar_up=true;sar_down=false;}

if ( Close[i+1] > isar1 && Close[i+2] < isar2 && find == false ) {find=true;sar_shift=i;sar_up=false;sar_down=true;}

}

  Comment("Par:",sar_shift+1,"sar_up",sar_up,"sar_down",sar_down);

  /*
  double ma20=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, 2);
  
  if ( Open[1] > Close[1] && Close[2] > Open[2] && Close[3] > Open[3]  && Close[4] > Open[4] && High[1] > High[2] && High[1] > High[3] 
  
  && Close[2] > ma20
  
  && sar_down == true
  
  ) {



bool find=false;
int shift=0;
int toplam=0;
bool ma_control=false;


for(int i=2;i<22;i++) {

double mai=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i);

if ( find == false ) {
if ( Close[i] > Open[i] ) {
if ( High[i] < mai ) ma_control = true;
toplam=toplam+1;
} else {
shift=i;
find=true;
}
}
}

double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift-1);

if ( ma_control == true && iaos < 0 && sar_shift+1 < 6 && toplam > 2 ) {

up_flag=true;

ObjectCreate(ChartID(),"VS"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"VS"+Time[1],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"VSS"+Time[1],OBJ_VLINE,0,Time[shift],Ask);
ObjectSetInteger(ChartID(),"VSS"+Time[1],OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),"VSS"+Time[1],OBJPROP_TOOLTIP,"Toplam:",toplam);
}
  
  }
  

  ma20=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, 3);
  
  if ( Open[1] > Close[1] && Open[2] > Close[2] && Close[3] > Open[3] && Close[4] > Open[4]  && Close[5] > Open[5] //&& High[1] > High[2] && High[1] > High[3] 
  
  && Close[3] > ma20
  
  && sar_down == true

  && ( ( High[1] > High[2] && High[1] > High[3] ) || High[2] > High[3] && High[2] > High[4] )
  
  ) {



bool find=false;
int shift=0;
int toplam=0;
bool ma_control=false;


for(int i=3;i<22;i++) {

double mai=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i);

if ( find == false ) {
if ( Close[i] > Open[i] ) {
if ( High[i] < mai ) ma_control = true;
toplam=toplam+1;
} else {
shift=i;
find=true;
}
}
}

double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift-1);

if ( ma_control == true && iaos < 0 && sar_shift+1 < 6 && toplam > 2 ) {

up_flag=true;

ObjectCreate(ChartID(),"VS"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"VS"+Time[1],OBJPROP_COLOR,clrLightBlue);

ObjectCreate(ChartID(),"VSS"+Time[1],OBJ_VLINE,0,Time[shift],Ask);
ObjectSetInteger(ChartID(),"VSS"+Time[1],OBJPROP_COLOR,clrLightBlue);
ObjectSetString(ChartID(),"VSS"+Time[1],OBJPROP_TOOLTIP,"Toplam:",toplam);
}
  
  }
  

  
  
  if ( up_flag == true ) {
  
  double mac20=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, 1);
  
  if ( Close[1] > Open[1] && Close[1] > mac20 && Low[1] <= Low[2] && Low[1] <= Low[3] ) {
  
ObjectCreate(ChartID(),"VC"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"VC"+Time[1],OBJPROP_COLOR,clrChartreuse);

up_flag=false;

 double sl=Low[1]-(sl_pip*Point);
 double tp=Close[1]+(tp_pip*Point);
 int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"",magic,0,clrNONE);

  
  }
  
  
  }
  
  
  if (  sar_up == true ) up_flag=false;
  
  */
  
  /*
  if ( up_flag == true ) {
  
  double mac20=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, 1);
  //Close[2] > Open[2] &&
  if (  Close[2] > mac20 && Low[2] < Low[3] && Low[2] < Low[4] && Low[2] < Low[1] ) {
  
ObjectCreate(ChartID(),"VC"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"VC"+Time[1],OBJPROP_COLOR,clrChartreuse);

up_flag=false;

 double sl=Low[1]-(sl_pip*Point);
 double tp=Close[1]+(tp_pip*Point);
 int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"",magic,0,clrNONE);

  
  }
  
  
  }*/
  
    
  

 
  double ma20=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, 2);
  
  if ( Open[1] > Close[1] && Close[2] > Open[2] && Close[3] > Open[3]  && Close[4] > Open[4] && High[1] > High[2] && High[1] > High[3] 
  
  && Close[2] > ma20
  
  && sar_down == true
  
  ) {



bool find=false;
int shift=0;
int toplam=0;
bool ma_control=false;


for(int i=2;i<22;i++) {

double mai=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i);

if ( find == false ) {
if ( Close[i] > Open[i] ) {
if ( High[i] < mai ) ma_control = true;
toplam=toplam+1;
} else {
shift=i;
find=true;
}
}
}

double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift-1);

if ( ma_control == true && iaos < 0 && sar_shift+1 < 6 && toplam > 2 ) {

up_flag=true;

ObjectCreate(ChartID(),"VS"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"VS"+Time[1],OBJPROP_COLOR,clrBlue);

ObjectCreate(ChartID(),"VSS"+Time[1],OBJ_VLINE,0,Time[shift],Ask);
ObjectSetInteger(ChartID(),"VSS"+Time[1],OBJPROP_COLOR,clrBlue);
ObjectSetString(ChartID(),"VSS"+Time[1],OBJPROP_TOOLTIP,"Toplam:",toplam);
}
  
  }
  

  ma20=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, 3);
  
  if ( Open[1] > Close[1] && Open[2] > Close[2] && Close[3] > Open[3] && Close[4] > Open[4]  && Close[5] > Open[5] //&& High[1] > High[2] && High[1] > High[3] 
  
  && Close[3] > ma20
  
  && sar_down == true

  && ( ( High[1] > High[2] && High[1] > High[3] ) || High[2] > High[3] && High[2] > High[4] )
  
  ) {



bool find=false;
int shift=0;
int toplam=0;
bool ma_control=false;


for(int i=3;i<22;i++) {

double mai=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, i);

if ( find == false ) {
if ( Close[i] > Open[i] ) {
if ( High[i] < mai ) ma_control = true;
toplam=toplam+1;
} else {
shift=i;
find=true;
}
}
}

double iaos=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),shift-1);

if ( ma_control == true && iaos < 0 && sar_shift+1 < 6 && toplam > 2 ) {

up_flag=true;

ObjectCreate(ChartID(),"VS"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"VS"+Time[1],OBJPROP_COLOR,clrLightBlue);

ObjectCreate(ChartID(),"VSS"+Time[1],OBJ_VLINE,0,Time[shift],Ask);
ObjectSetInteger(ChartID(),"VSS"+Time[1],OBJPROP_COLOR,clrLightBlue);
ObjectSetString(ChartID(),"VSS"+Time[1],OBJPROP_TOOLTIP,"Toplam:",toplam);
}
  
  }
  

  if (  sar_up == true ) up_flag=false;
  
  
  if ( up_flag == true ) {
  
  double mac20=iMA(sym, ChartPeriod(ChartID()), 20, 0, MODE_SMA, PRICE_OPEN, 1);
  
  if ( Close[1] > Open[1] && Close[1] > mac20 && Low[1] <= Low[2] && Low[1] <= Low[3] ) {
  
ObjectCreate(ChartID(),"VC"+Time[1],OBJ_VLINE,0,Time[1],Ask);
ObjectSetInteger(ChartID(),"VC"+Time[1],OBJPROP_COLOR,clrChartreuse);

up_flag=false;

 double sl=Low[1]-(sl_pip*Point);
 double tp=Close[1]+(tp_pip*Point);
 int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"",magic,0,clrNONE);

  
  }
  
  
  }
  
    
  
  
  
  
  
  
  
return;  
  
  
  
//---
RefreshRates();
double ma=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_CLOSE, 1);
double mal=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_LOW, 1);
double mah=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_HIGH, 1);
double mao=iMA(sym, 3, 1, 0, MODE_SMA, PRICE_OPEN, 1);

double ma207=iMA(sym, 3, 20, 0, MODE_SMA, PRICE_OPEN, 7);
double ma206=iMA(sym, 3, 20, 0, MODE_SMA, PRICE_OPEN, 6);
double ma205=iMA(sym, 3, 20, 0, MODE_SMA, PRICE_OPEN, 5);
double ma204=iMA(sym, 3, 20, 0, MODE_SMA, PRICE_OPEN, 4);
double ma203=iMA(sym, 3, 20, 0, MODE_SMA, PRICE_OPEN, 3);
double ma202=iMA(sym, 3, 20, 0, MODE_SMA, PRICE_OPEN, 2);
double ma201=iMA(sym, 3, 20, 0, MODE_SMA, PRICE_OPEN, 1);
//double ma20=iMA(sym, 3, 20, 0, MODE_SMA, PRICE_OPEN, 0);



double iao=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),1);
double iao3=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),3);
double iao5=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),5);
double iao6=iAO(ChartSymbol(ChartID()),ChartPeriod(ChartID()),6);


double isar1=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,1);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,2);
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,3);
double isar4=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,4);
double isar5=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,5);
double isar6=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,6);
double isar7=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,7);


Comment("iao",iao,"\nPar:",sar_shift+1,"sar_up",sar_up,"sar_down",sar_down);

            
//Comment("iao:",iao);

if ( iLow(sym,PERIOD_CURRENT,7) < ma207 // 20 Altında

&& iOpen(sym,PERIOD_CURRENT,7) < ma207 // 20 Altında

&& iClose(sym,PERIOD_CURRENT,7) < ma207 // 20 Altında

&& iOpen(sym,PERIOD_CURRENT,7) > iClose(sym,PERIOD_CURRENT,7) // Kırmızı


&& iClose(sym,PERIOD_CURRENT,6) > iOpen(sym,PERIOD_CURRENT,6)

&& iao6 < 0 


&& iClose(sym,PERIOD_CURRENT,5) > iOpen(sym,PERIOD_CURRENT,5)

&& iClose(sym,PERIOD_CURRENT,4) > iOpen(sym,PERIOD_CURRENT,4)

&& iClose(sym,PERIOD_CURRENT,3) > iOpen(sym,PERIOD_CURRENT,3)


&& iClose(sym,PERIOD_CURRENT,3) > ma203

&& (

(iOpen(sym,PERIOD_CURRENT,6) < ma206 && iClose(sym,PERIOD_CURRENT,6) > ma206) ||

(iOpen(sym,PERIOD_CURRENT,5) < ma205 && iClose(sym,PERIOD_CURRENT,5) > ma205) ||

(iOpen(sym,PERIOD_CURRENT,4) < ma204 && iClose(sym,PERIOD_CURRENT,4) > ma204) ||

(iOpen(sym,PERIOD_CURRENT,3) < ma203 && iClose(sym,PERIOD_CURRENT,3) > ma203)

)


// yeşil mumdan sonra gelen high yapan ilk düşüş mumu 
&& iOpen(sym,PERIOD_CURRENT,2) > iClose(sym,PERIOD_CURRENT,2)

&& iHigh(sym,PERIOD_CURRENT,2) > iHigh(sym,PERIOD_CURRENT,3)

&& iHigh(sym,PERIOD_CURRENT,2) > iHigh(sym,PERIOD_CURRENT,4)

&& iHigh(sym,PERIOD_CURRENT,2) > iHigh(sym,PERIOD_CURRENT,1)


//// son yükseliş mumu kendinden önceki iki mumun altında low yapacak
&& iClose(sym,PERIOD_CURRENT,1) > iOpen(sym,PERIOD_CURRENT,1)

&& iLow(sym,PERIOD_CURRENT,1) < iLow(sym,PERIOD_CURRENT,2)

&& iLow(sym,PERIOD_CURRENT,1) < iLow(sym,PERIOD_CURRENT,3)

&& iClose(sym,PERIOD_CURRENT,1) > ma201

&& sar_down == true

&& sar_shift+1 <= 4

&& isar1 < Close[1]

&& isar2 < Close[2]

&& isar3 < Close[3]

//&& isar4 < Close[4]

//&& isar5 < Close[5]

//&& isar6 < Close[6]

//&& isar7 < Close[7]


 ) {
 
 double sl=Low[1]-(sl_pip*Point);
 double tp=Close[1]+(tp_pip*Point);
 int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"",magic,0,clrNONE);


}


if ( iLow(sym,PERIOD_CURRENT,6) < ma206 // 20 Altında

&& iOpen(sym,PERIOD_CURRENT,6) > iClose(sym,PERIOD_CURRENT,6) // Kırmızı

&& iOpen(sym,PERIOD_CURRENT,6) < ma206 // 20 Altında

&& iClose(sym,PERIOD_CURRENT,6) < ma206 // 20 Altında


&& iClose(sym,PERIOD_CURRENT,5) > iOpen(sym,PERIOD_CURRENT,5)

&& iao5 < 0 


&& iClose(sym,PERIOD_CURRENT,4) > iOpen(sym,PERIOD_CURRENT,4)

&& iClose(sym,PERIOD_CURRENT,3) > iOpen(sym,PERIOD_CURRENT,3)

&& iClose(sym,PERIOD_CURRENT,3) > ma203

&& (


(iOpen(sym,PERIOD_CURRENT,5) < ma205 && iClose(sym,PERIOD_CURRENT,5) > ma205) ||

(iOpen(sym,PERIOD_CURRENT,4) < ma204 && iClose(sym,PERIOD_CURRENT,4) > ma204) ||

(iOpen(sym,PERIOD_CURRENT,3) < ma203 && iClose(sym,PERIOD_CURRENT,3) > ma203)



)


// yeşil mumdan sonra gelen high yapan ilk düşüş mumu 
&& iOpen(sym,PERIOD_CURRENT,2) > iClose(sym,PERIOD_CURRENT,2)

&& iHigh(sym,PERIOD_CURRENT,2) > iHigh(sym,PERIOD_CURRENT,3)

&& iHigh(sym,PERIOD_CURRENT,2) > iHigh(sym,PERIOD_CURRENT,4)

&& iHigh(sym,PERIOD_CURRENT,2) > iHigh(sym,PERIOD_CURRENT,1)


//// son yükseliş mumu kendinden önceki iki mumun altında low yapacak
&& iClose(sym,PERIOD_CURRENT,1) > iOpen(sym,PERIOD_CURRENT,1)

&& iLow(sym,PERIOD_CURRENT,1) < iLow(sym,PERIOD_CURRENT,2)

&& iLow(sym,PERIOD_CURRENT,1) < iLow(sym,PERIOD_CURRENT,3)

&& iClose(sym,PERIOD_CURRENT,1) > ma201

&& sar_down == true

&& sar_shift+1 <= 4

&& isar1 < Close[1]

&& isar2 < Close[2]

//&& isar3 < Close[3]

//&& isar4 < Close[4]

//&& isar5 < Close[5]

//&& isar6 < Close[6]

//&& isar7 < Close[7]


 ) {
 
 double sl=Low[1]-(sl_pip*Point);
 double tp=Close[1]+(tp_pip*Point);
 int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,sl,tp,"",magic,0,clrNONE);



}
////////////////////////////////////////////////////////////////////////////////////////
/// SELL
////////////////////////////////////////////////////////////////////////////////////////


if ( iHigh(sym,PERIOD_CURRENT,7) > ma207 // 20 Üstünde

&& iOpen(sym,PERIOD_CURRENT,7) < iClose(sym,PERIOD_CURRENT,7) // Yeşil

&& iOpen(sym,PERIOD_CURRENT,7) > ma207 // 20 Üstünde

&& iClose(sym,PERIOD_CURRENT,7) > ma207 // 20 Üstünde


&& iClose(sym,PERIOD_CURRENT,6) < iOpen(sym,PERIOD_CURRENT,6) // Kırmızı

&& iao6 > 0 


&& iClose(sym,PERIOD_CURRENT,5) < iOpen(sym,PERIOD_CURRENT,5)

&& iClose(sym,PERIOD_CURRENT,4) < iOpen(sym,PERIOD_CURRENT,4)

&& iClose(sym,PERIOD_CURRENT,3) < iOpen(sym,PERIOD_CURRENT,3)


&& iClose(sym,PERIOD_CURRENT,3) < ma203

&& (

(iOpen(sym,PERIOD_CURRENT,6) > ma206 && iClose(sym,PERIOD_CURRENT,6) < ma206) ||

(iOpen(sym,PERIOD_CURRENT,5) > ma205 && iClose(sym,PERIOD_CURRENT,5) < ma205) ||

(iOpen(sym,PERIOD_CURRENT,4) > ma204 && iClose(sym,PERIOD_CURRENT,4) < ma204) ||

(iOpen(sym,PERIOD_CURRENT,3) > ma203 && iClose(sym,PERIOD_CURRENT,3) < ma203)

)


// yeşil mumdan sonra gelen high yapan ilk düşüş mumu 
&& iOpen(sym,PERIOD_CURRENT,2) < iClose(sym,PERIOD_CURRENT,2)

&& iLow(sym,PERIOD_CURRENT,2) < iLow(sym,PERIOD_CURRENT,3)

&& iLow(sym,PERIOD_CURRENT,2) < iLow(sym,PERIOD_CURRENT,4)

&& iLow(sym,PERIOD_CURRENT,2) < iLow(sym,PERIOD_CURRENT,1)


//// son düşüş mumu kendinden önceki iki mumun üstünde high yapacak
&& iClose(sym,PERIOD_CURRENT,1) < iOpen(sym,PERIOD_CURRENT,1)

&& iHigh(sym,PERIOD_CURRENT,1) > iHigh(sym,PERIOD_CURRENT,2)

&& iHigh(sym,PERIOD_CURRENT,1) > iHigh(sym,PERIOD_CURRENT,3)

&& iClose(sym,PERIOD_CURRENT,1) < ma201

&& sar_up == true

&& sar_shift+1 <= 4

&& isar1 > Close[1]

&& isar2 > Close[2]

&& isar3 > Close[3]

//&& isar4 < Close[4]

//&& isar5 < Close[5]

//&& isar6 < Close[6]

//&& isar7 < Close[7]


 ) {
 
 double sl=High[1]+(sl_pip*Point);
 double tp=Close[1]-(tp_pip*Point);
 int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"",magic,0,clrNONE);



}


/////////////////////////////////

if ( iHigh(sym,PERIOD_CURRENT,6) > ma206 // 20 Üstünde

&& iOpen(sym,PERIOD_CURRENT,6) < iClose(sym,PERIOD_CURRENT,6) // Yeşil

&& iOpen(sym,PERIOD_CURRENT,6) > ma206 // 20 Üstünde

&& iClose(sym,PERIOD_CURRENT,6) > ma206 // 20 Üstünde


&& iClose(sym,PERIOD_CURRENT,5) < iOpen(sym,PERIOD_CURRENT,5) // Kırmızı

&& iao5 > 0 


&& iClose(sym,PERIOD_CURRENT,4) < iOpen(sym,PERIOD_CURRENT,4)

&& iClose(sym,PERIOD_CURRENT,3) < iOpen(sym,PERIOD_CURRENT,3)

&& iClose(sym,PERIOD_CURRENT,3) < ma203

&& (


(iOpen(sym,PERIOD_CURRENT,5) > ma205 && iClose(sym,PERIOD_CURRENT,5) < ma205) ||

(iOpen(sym,PERIOD_CURRENT,4) > ma204 && iClose(sym,PERIOD_CURRENT,4) < ma204) ||

(iOpen(sym,PERIOD_CURRENT,3) > ma203 && iClose(sym,PERIOD_CURRENT,3) < ma203)



)


// kırmızı mumdan sonra gelen low yapan ilk yükseliş mumu 
&& iOpen(sym,PERIOD_CURRENT,2) < iClose(sym,PERIOD_CURRENT,2)

&& iLow(sym,PERIOD_CURRENT,2) < iLow(sym,PERIOD_CURRENT,3)

&& iLow(sym,PERIOD_CURRENT,2) < iLow(sym,PERIOD_CURRENT,4)

&& iLow(sym,PERIOD_CURRENT,2) < iLow(sym,PERIOD_CURRENT,1)


//// son düşüş mumu kendinden önceki iki mumun üstünde high yapacak
&& iClose(sym,PERIOD_CURRENT,1) < iOpen(sym,PERIOD_CURRENT,1)

&& iHigh(sym,PERIOD_CURRENT,1) > iHigh(sym,PERIOD_CURRENT,2)

&& iHigh(sym,PERIOD_CURRENT,1) > iHigh(sym,PERIOD_CURRENT,3)

&& iHigh(sym,PERIOD_CURRENT,1) < ma201

&& sar_up == true

&& sar_shift+1 <= 4

&& isar1 > Close[1]

&& isar2 > Close[2]

//&& isar3 < Close[3]

//&& isar4 < Close[4]

//&& isar5 < Close[5]

//&& isar6 < Close[6]

//&& isar7 < Close[7]


 ) {
 
  double sl=High[1]+(sl_pip*Point);
 double tp=Close[1]-(tp_pip*Point);
 int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sl,tp,"",magic,0,clrNONE);


}

           
           
           
           
           
           
           
           
           
           
           
           
ObjectDelete(ChartID(),"VLINEMA");
ObjectCreate(ChartID(),"VLINEMA",OBJ_HLINE,0,Time[1],ma20);



 Print("Close:",iClose(sym,PERIOD_CURRENT,1),"/",ma);
 Print("Low:",iLow(sym,PERIOD_CURRENT,1),"/",mal);
 Print("High:",iHigh(sym,PERIOD_CURRENT,1),"/",mah);
 Print("Open:",iOpen(sym,PERIOD_CURRENT,1),"/",mao);
  


double isar=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,1);


for ( int i=0;i<10;i++) {
double isar1=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+1);
double isar2=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+2);
double isar3=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+3);
double isar4=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+4);
double isar5=iSAR(ChartSymbol(ChartID()),ChartPeriod(ChartID()),0.02,02,i+5);


//if ( isar5 < Close[i+5] && isar4 > Close[i+4] && isar3 > Close[i+3] && isar2 > Close[i+2] && isar1 > Close[i+1] ) {


if ( isar5 < Close[i+4] && isar1 > Close[i+1] && isar2 > Close[i+2] && isar3 > Close[i+3] && isar4 > Close[i+4] ) {
ObjectDelete(ChartID(),"VLINE"+i);
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i+1],isar1);
}


if ( isar5 > Close[i+4] && isar1 < Close[i+1] && isar2 < Close[i+2] && isar3 < Close[i+3] && isar4 < Close[i+4] ) {
ObjectDelete(ChartID(),"VLINE"+i);
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i+1],isar1);
}





}

   
                    

ObjectDelete(ChartID(),"LAST");
ObjectCreate(ChartID(),"LAST",OBJ_TREND,0,Time[1],Close[1],Time[1]+50*PeriodSeconds(),Close[1]);
ObjectSetInteger(ChartID(),"LAST",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),"LAST",OBJPROP_WIDTH,3);

ObjectDelete(ChartID(),"LASTO");
ObjectCreate(ChartID(),"LASTO",OBJ_TREND,0,Time[1],Open[1],Time[1]+50*PeriodSeconds(),Open[1]);
ObjectSetInteger(ChartID(),"LASTO",OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),"LASTO",OBJPROP_WIDTH,3);



ObjectDelete(ChartID(),"LASTI");
ObjectCreate(ChartID(),"LASTI",OBJ_TREND,0,Time[1],isar,Time[1]+50*PeriodSeconds(),isar);
ObjectSetInteger(ChartID(),"LASTI",OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),"LASTI",OBJPROP_WIDTH,3);


ChartRedraw();
Print(isar,"/",iao);

//OnInit();


/*
    if ((iSAR(NULL, 0,Step,Maximum, 0)<iClose(NULL,0,0))&&(iSAR(NULL, 0,Step,Maximum, 1)>iOpen(NULL,0,1)))  //Signal Buy
 {

   int opensell=OrderSend(Symbol(),OP_SELL,Lots,Bid,Slip,NormalizeDouble(Bid+25*Point,Digits),NormalizeDouble(Bid-25*Point,Digits),"MY trader sell order",0,0,Green);
   flag1=1; 
 }
 
 if ((iSAR(NULL, 0,Step,Maximum, 0)>iClose(NULL,0,0))&&(iSAR(NULL, 0,Step,Maximum, 1)<iOpen(NULL,0,1)))  //Signal Sell
 {
 
   int openbuy=OrderSend(Symbol(),OP_BUY,Lots,Ask,Slip,NormalizeDouble(Ask-25*Point,Digits),NormalizeDouble(Ask+25*Point,Digits),"MY trader buy order",0,0,Blue);
   flag1=1;
 }
 
 */


   
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
