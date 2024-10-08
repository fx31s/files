//+------------------------------------------------------------------+
//|                                                     MaSistem.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern ENUM_MA_METHOD MaMethod=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price
extern ENUM_TIMEFRAMES MaTime = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price
extern ENUM_TIMEFRAMES MaTimes = PERIOD_CURRENT;


int ma_shift = 1; // Zaman
int shiftma  = 0;
int shift=0;

extern int MA_W=20;
extern int MB_W=30;


   int last_shift=-1;
   bool first_shift=false;
   

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   MaTime=Period();
   MaTimes=Period();
   
   


ObjectsDeleteAll();


string sym=Symbol();
ENUM_TIMEFRAMES per=Period();




for ( int i=1;i<Bars-100;i++){




double MA20=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, i); 
double MA20p=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, i+1); 
double MA20pp=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, i+2); 
double MA20ppp=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, i+3); 
double MA20pppp=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, i+4); 
double MA20ppppp=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, i+5); 




double MA100=iMA(Symbol(), MaTime, 100, ma_shift, MaMethod, MaPrice, i); 
double MA200=iMA(Symbol(), MaTime, 200, ma_shift, MaMethod, MaPrice, i); 




if ( iOpen(sym,per,i+2) < MA20pp && iClose(sym,per,i+2) < MA20pp && 
     iOpen(sym,per,i+3) < MA20ppp && iClose(sym,per,i+3) < MA20ppp && 
     iOpen(sym,per,i+4) < MA20pppp && iClose(sym,per,i+4) < MA20pppp && 
     iOpen(sym,per,i+5) < MA20ppppp && iClose(sym,per,i+5) < MA20ppppp && 

MA100 < MA200 && MA20 < MA200 &&

iOpen(sym,per,i+1) < MA20p && iClose(sym,per,i+1) < MA20p && iClose(sym,per,i) > MA20 //|| ( iOpen(sym,per,i) > MA20 && iClose(sym,per,i) < MA20 ))
    ) {
    



bool find=false;
int say=0;
int shiftf=0;

for ( int f=i+6;f<i+100;f++) {

double MA20s=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, f); 

if ( find == true ) continue;

if ( iClose(sym,per,f) < MA20s && iOpen(sym,per,f) < MA20s && iHigh(sym,per,f) < MA20s ) {
say=say+1;
shiftf=f;
} else {
find=true;
}



}

if ( say < 14 || iHigh(sym,per,shiftf+1) > MA100 ) continue;


//ObjectCreate(ChartID(),"VLINE"+iTime(sym,per,i),OBJ_VLINE,0,iTime(sym,per,i),Ask);


if ( say > 0 ) {

ObjectCreate(ChartID(),"TLINEC"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),iClose(sym,per,i),iTime(sym,per,i)+50*PeriodSeconds(),iClose(sym,per,i));
ObjectSetInteger(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_WIDTH,1);
ObjectSetString(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_TOOLTIP,say);
ObjectSetInteger(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_STYLE,STYLE_DOT);



ObjectCreate(ChartID(),"TLINE"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),iLow(sym,per,i),iTime(sym,per,shiftf+1),iHigh(sym,per,shiftf+1));
ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_TOOLTIP,say);
//(shiftf-i)
ObjectCreate(ChartID(),"TLINE200"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),iLow(sym,per,i),iTime(sym,per,i)+PeriodSeconds(),MA200);
ObjectSetInteger(ChartID(),"TLINE200"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE200"+iTime(sym,per,i),OBJPROP_COLOR,clrYellowGreen);
ObjectSetInteger(ChartID(),"TLINE200"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE200"+iTime(sym,per,i),OBJPROP_TOOLTIP,(MA200-iClose(sym,per,i))/Point);
if ( say >= 14 ) ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);

ObjectCreate(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),MA200,iTime(sym,per,i)+100*PeriodSeconds(),MA200);
ObjectSetInteger(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJPROP_COLOR,clrYellowGreen);
ObjectSetInteger(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJPROP_TOOLTIP,(MA200-iClose(sym,per,i))/Point);
if ( say >= 14 ) ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);




ObjectCreate(ChartID(),"TLINE100"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),iLow(sym,per,i),iTime(sym,per,i)+PeriodSeconds(),MA100);
ObjectSetInteger(ChartID(),"TLINE100"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE100"+iTime(sym,per,i),OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),"TLINE100"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE100"+iTime(sym,per,i),OBJPROP_TOOLTIP,(MA100-iClose(sym,per,i))/Point);
if ( say >= 14 ) ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);


ObjectCreate(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),MA100,iTime(sym,per,i)+100*PeriodSeconds(),MA100);
ObjectSetInteger(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJPROP_TOOLTIP,(MA100-iClose(sym,per,i))/Point);
if ( say >= 14 ) ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);




}


ObjectSetString(ChartID(),"VLINE"+iTime(sym,per,i),OBJPROP_TOOLTIP,say);
if ( say >= 14 ) { ObjectSetInteger(ChartID(),"VLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);

if ( MA100 < MA200 && MA20 < MA200 ) {
ObjectSetInteger(ChartID(),"VLINE"+iTime(sym,per,i),OBJPROP_COLOR,clrLimeGreen);
}
}


}



//continue;


if ( iOpen(sym,per,i+2) > MA20pp && iClose(sym,per,i+2) > MA20pp && 
     iOpen(sym,per,i+3) > MA20ppp && iClose(sym,per,i+3) > MA20ppp && 
     iOpen(sym,per,i+4) > MA20pppp && iClose(sym,per,i+4) > MA20pppp && 
     iOpen(sym,per,i+5) > MA20ppppp && iClose(sym,per,i+5) > MA20ppppp && 

MA100 > MA200 && MA20 > MA200 &&

iOpen(sym,per,i+1) > MA20p && iClose(sym,per,i+1) > MA20p && iClose(sym,per,i) < MA20 //|| ( iOpen(sym,per,i) > MA20 && iClose(sym,per,i) < MA20 ))
    ) {
    



bool find=false;
int say=0;
int shiftf=0;

for ( int f=i+6;f<i+100;f++) {

double MA20s=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, f); 

if ( find == true ) continue;

if ( iClose(sym,per,f) > MA20s && iOpen(sym,per,f) > MA20s && iLow(sym,per,f) > MA20s ) {
say=say+1;
shiftf=f;
} else {
find=true;
}



}

if ( say < 14 || iLow(sym,per,shiftf+1) > MA100) continue;


//ObjectCreate(ChartID(),"VLINE"+iTime(sym,per,i),OBJ_VLINE,0,iTime(sym,per,i),Ask);


if ( say > 0 ) {

ObjectCreate(ChartID(),"TLINEC"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),iClose(sym,per,i),iTime(sym,per,i)+50*PeriodSeconds(),iClose(sym,per,i));
ObjectSetInteger(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_WIDTH,1);
ObjectSetString(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_TOOLTIP,say);
ObjectSetInteger(ChartID(),"TLINEC"+iTime(sym,per,i),OBJPROP_STYLE,STYLE_DOT);



ObjectCreate(ChartID(),"TLINE"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),iHigh(sym,per,i),iTime(sym,per,shiftf+1),iLow(sym,per,shiftf+1));
ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_TOOLTIP,say);
//(shiftf-i)
ObjectCreate(ChartID(),"TLINE200"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),iHigh(sym,per,i),iTime(sym,per,i)+PeriodSeconds(),MA200);
ObjectSetInteger(ChartID(),"TLINE200"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE200"+iTime(sym,per,i),OBJPROP_COLOR,clrYellowGreen);
ObjectSetInteger(ChartID(),"TLINE200"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE200"+iTime(sym,per,i),OBJPROP_TOOLTIP,(iClose(sym,per,i)-MA200)/Point);
if ( say >= 14 ) ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);

ObjectCreate(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),MA200,iTime(sym,per,i)+100*PeriodSeconds(),MA200);
ObjectSetInteger(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJPROP_COLOR,clrYellowGreen);
ObjectSetInteger(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE200T"+iTime(sym,per,i),OBJPROP_TOOLTIP,(iClose(sym,per,i)-MA200)/Point);
if ( say >= 14 ) ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);




ObjectCreate(ChartID(),"TLINE100"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),iHigh(sym,per,i),iTime(sym,per,i)+PeriodSeconds(),MA100);
ObjectSetInteger(ChartID(),"TLINE100"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE100"+iTime(sym,per,i),OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),"TLINE100"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE100"+iTime(sym,per,i),OBJPROP_TOOLTIP,(iClose(sym,per,i)-MA100)/Point);
if ( say >= 14 ) ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);


ObjectCreate(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJ_TREND,0,iTime(sym,per,i),MA100,iTime(sym,per,i)+100*PeriodSeconds(),MA100);
ObjectSetInteger(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),"TLINE100T"+iTime(sym,per,i),OBJPROP_TOOLTIP,(iClose(sym,per,i)-MA100)/Point);
if ( say >= 14 ) ObjectSetInteger(ChartID(),"TLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);




}


ObjectSetString(ChartID(),"VLINE"+iTime(sym,per,i),OBJPROP_TOOLTIP,say);
if ( say >= 14 ) { ObjectSetInteger(ChartID(),"VLINE"+iTime(sym,per,i),OBJPROP_WIDTH,5);

if ( MA100 > MA200 && MA20 > MA200 ) {
ObjectSetInteger(ChartID(),"VLINE"+iTime(sym,per,i),OBJPROP_COLOR,clrLimeGreen);
}
}


}





}












return INIT_SUCCEEDED;



for ( int i=1;i<Bars-100;i++){

bool find=false;
int say=0;
int shiftf=0;

for ( int shift=i;shift<i+10;shift++) {



double MA20=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, shift); 
double MA30=iMA(Symbol(), MaTime, 30, ma_shift, MaMethods, MaPrice, shift);      
double MA50=iMA(Symbol(), MaTime, 50, ma_shift, MaMethods, MaPrice, shift);      
double MA200=iMA(Symbol(), MaTime, 200, ma_shift, MaMethods, MaPrice, shift);      
double MA100=iMA(Symbol(), MaTime, 100, ma_shift, MaMethods, MaPrice, shift);      



if ( iClose(sym,per,shift) < MA20 && iOpen(sym,per,shift) < MA20 && find==false //&& MA30 > MA20 

&& MA200 > MA100 

//&& MA50 > MA30 
) {
say=say+1;
shiftf=shift;
} else {
find=true;
}



}

if ( say >= 10 ) {

bool finds=false;
int says=0;
int shiftx=0;

for ( int shifts=shiftf;shifts<shiftf+50;shifts++) {

if ( finds == true ) continue;

double MA20s=iMA(Symbol(), MaTime, 20, ma_shift, MaMethod, MaPrice, shifts); 
double MA30s=iMA(Symbol(), MaTime, 30, ma_shift, MaMethod, MaPrice, shifts); 

/*
if ( iClose(sym,per,shifts) > iOpen(sym,per,shifts) && iClose(sym,per,shifts) > MA20s && iOpen(sym,per,shifts) < MA20s ) {
finds=true;
shiftx=shifts;
}*/

if ( iOpen(sym,per,shifts) > iClose(sym,per,shifts) && 

(

(iOpen(sym,per,shifts) > MA20s && iClose(sym,per,shifts) < MA20s //&& MA30s > MA20s

 )

||

(iOpen(sym,per,shifts) > MA30s && iClose(sym,per,shifts) < MA30s //&& MA30s < MA20s
 ) // Karıştırma Modeli

)



) {
finds=true;
shiftx=shifts;
}

if ( finds == false ) says=says+1;





}


double MA200i=iMA(Symbol(), MaTime, 200, ma_shift, MaMethods, MaPrice, i);      
double MA100i=iMA(Symbol(), MaTime, 100, ma_shift, MaMethods, MaPrice, i); 

double MA20i=iMA(Symbol(), MaTime, 20, ma_shift, MaMethods, MaPrice, i);      


double MA200x=iMA(Symbol(), MaTime, 200, ma_shift, MaMethods, MaPrice, shiftx);      
double MA100x=iMA(Symbol(), MaTime, 100, ma_shift, MaMethods, MaPrice, shiftx); 


if ( says < 15 //&& (first_shift==false || i-last_shift > 15 ) 

//&& last_shift != shiftx

&& shiftx-i < 11

&& MA200i > MA100i

&& MA20i < MA100i

&& MA200x > MA100x



) {


/*
ObjectDelete(ChartID(),"VLINE"+iTime(sym,per,i-1));
ObjectDelete(ChartID(),MaTime+"VLINEMAD"+(i-1));
*/
ObjectCreate(ChartID(),"VLINE"+iTime(sym,per,i),OBJ_VLINE,0,iTime(sym,per,i),Ask);
ObjectSetString(ChartID(),"VLINE"+iTime(sym,per,i),OBJPROP_TOOLTIP,says);

   ObjectDelete(ChartID(),MaTime+"VLINEMAD"+i);
   ObjectCreate(ChartID(),MaTime+"VLINEMAD"+i,OBJ_TREND,0,iTime(sym,per,shiftx),iClose(sym,per,shiftx),iTime(sym,per,i),iLow(sym,per,i));
   ObjectSetInteger(ChartID(),MaTime+"VLINEMAD"+i,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),MaTime+"VLINEMAD"+i,OBJPROP_BACK,False);
   ObjectSetInteger(ChartID(),MaTime+"VLINEMAD"+i,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),MaTime+"VLINEMAD"+i,OBJPROP_STYLE,STYLE_DOT); 
   ObjectSetInteger(ChartID(),MaTime+"VLINEMAD"+i,OBJPROP_WIDTH,2); 
   ObjectSetString(ChartID(),MaTime+"VLINEMAD"+i,OBJPROP_TOOLTIP,shiftx-i); 

last_shift=shiftx;
first_shift=true;

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
