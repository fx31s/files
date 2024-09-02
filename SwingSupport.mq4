//+------------------------------------------------------------------+
//|                                                     SwingLow.mq4 |
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

int swing_low_toplam=0;
double swing_low[5000];
double swing_low_high[5000];
int swing_low_high_shift[5000];
datetime swing_low_high_time[5000];

int swing_high_toplam=0;
double swing_high[5000];
double swing_high_low[5000];
int swing_high_low_shift[5000];
datetime swing_high_low_time[5000];


int OnInit()
  {
//---

ObjectsDeleteAll();

int starts=Bars-30;
//starts=500;


for (int b=starts;b>4;b--) {

//if ( b<0 ) continue;


//Print(b);

//if( b==386 ) {
//&& Low[b+3] > Low[b] Open[b] > Close[b] &&
if ( Low[b+1] >= Low[b] && Low[b+2] > Low[b] && Low[b-1] > Low[b] && Low[b-2] > Low[b] && Low[b-3] > Low[b]) {

//ObjectCreate(ChartID(),"V"+b,OBJ_VLINE,0,Time[b],Ask);

double high=High[b];
int shift=b;

for (int h=b+1;h<b+15;h++) {
if ( High[h] > high ) {
high=High[h];
shift=h;
}
}

bool find=false;
for (int f=b-1;f>0;f--) {
if ( f<0 ) continue;
if ( Low[f] < Low[b] && find==false) find=true;
}


swing_low_toplam=swing_low_toplam+1;
swing_low[swing_low_toplam]=Low[b];
swing_low_high[swing_low_toplam]=High[shift];
swing_low_high_shift[swing_low_toplam]=shift;
swing_low_high_time[swing_low_toplam]=Time[shift];



if ( find == false ) {
ObjectCreate(ChartID(),"T"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[shift],High[shift]);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_COLOR,clrLightGray);


ObjectCreate(ChartID(),"TL"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[0],Low[b]);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_STYLE,STYLE_DOT);


} else {
/*ObjectCreate(ChartID(),"T"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[shift],High[shift]);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_COLOR,clrCrimson);

ObjectCreate(ChartID(),"TL"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[0],Low[b]);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_COLOR,clrBlack);*/

}





}




//if( b==386 ) {
//&& Low[b+3] > Low[b] Open[b] > Close[b] &&
if ( High[b+1] <= High[b] && High[b+2] < High[b] && High[b-1] < High[b] && High[b-2] < High[b] && High[b-3] < High[b]) {

//ObjectCreate(ChartID(),"V"+b,OBJ_VLINE,0,Time[b],Ask);

double low=Low[b];
int shift=b;

for (int h=b+1;h<b+15;h++) {
if ( Low[h] < low ) {
low=Low[h];
shift=h;
}
}

bool find=false;
for (int f=b-1;f>0;f--) {
if ( f<0 ) continue;
if ( High[f] > High[b] && find==false) find=true;
}



swing_high_toplam=swing_high_toplam+1;
swing_high[swing_high_toplam]=High[b];
swing_high_low[swing_high_toplam]=Low[shift];
swing_high_low_shift[swing_high_toplam]=shift;
swing_high_low_time[swing_high_toplam]=Time[shift];



if ( find == false ) {
ObjectCreate(ChartID(),"T"+Time[b],OBJ_TREND,0,Time[b],High[b],Time[shift],Low[shift]);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_COLOR,clrLightBlue);

ObjectCreate(ChartID(),"TL"+Time[b],OBJ_TREND,0,Time[b],High[b],Time[0],High[b]);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_STYLE,STYLE_DOT);




//if ( b > 50 ) {
//Alert(b,"/",swing_low_toplam);


bool finds=false;
//for(int sw=1;sw<=swing_low_toplam;sw++) {
for(int sw=swing_low_toplam;sw>=1;sw--) {

if ( swing_low_high_shift[sw] > b && finds == false ) {
finds=true;
//Alert(b,"/",finds,"/",swing_low_high_shift[sw]);

int bb=swing_low_high_shift[sw];
bb=iBarShift(Symbol(),Period(),swing_low_high_time[sw]);


if ( High[bb] > High[b] )continue;

ObjectCreate(ChartID(),"TLH"+Time[bb],OBJ_TREND,0,Time[bb],Low[bb],Time[0],Low[bb]);
ObjectSetInteger(ChartID(),"TLH"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLH"+Time[bb],OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),"TLH"+Time[bb],OBJPROP_STYLE,STYLE_DOT);
/*
if ( Open[b] > Close[b] ) ObjectCreate(ChartID(),"TLHH"+Time[bb],OBJ_TREND,0,Time[b],Open[b],Time[0],Open[b]);
if ( Close[b] > Open[b] ) ObjectCreate(ChartID(),"TLHH"+Time[bb],OBJ_TREND,0,Time[b],Close[b],Time[0],Close[b]);
ObjectSetInteger(ChartID(),"TLHH"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLHH"+Time[bb],OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),"TLHH"+Time[bb],OBJPROP_STYLE,STYLE_DOT);*/

ObjectCreate(ChartID(),"THHH"+Time[bb],OBJ_TREND,0,Time[b],Low[b],Time[0],Low[b]);
ObjectSetInteger(ChartID(),"THHH"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"THHH"+Time[bb],OBJPROP_COLOR,clrDarkBlue);
ObjectSetInteger(ChartID(),"THHH"+Time[bb],OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"THHH"+Time[bb],OBJPROP_WIDTH,2);


if ( Open[b] < Close[b] ) ObjectCreate(ChartID(),"TLHHR"+Time[bb],OBJ_RECTANGLE,0,Time[bb],Open[b],Time[0],High[bb]);
if ( Close[b] < Open[b] ) ObjectCreate(ChartID(),"TLHHR"+Time[bb],OBJ_RECTANGLE,0,Time[bb],Close[b],Time[0],High[bb]);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_STYLE,STYLE_DOT);

if ( (Open[b] < Close[b] && Open[b] < High[bb]) || (Open[b] > Close[b] && Open[b] < High[bb])  ) {
ObjectDelete(ChartID(),"TLHHR"+Time[bb]);
if ( Open[b-1] < Close[b-1] ) ObjectCreate(ChartID(),"TLHHR"+Time[bb],OBJ_RECTANGLE,0,Time[bb],Open[b-1],Time[0],High[bb]);
if ( Close[b-1] < Open[b-1] ) ObjectCreate(ChartID(),"TLHHR"+Time[bb],OBJ_RECTANGLE,0,Time[bb],Close[b-1],Time[0],High[bb]);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),"THHH"+Time[bb]);
ObjectCreate(ChartID(),"THHH"+Time[bb],OBJ_TREND,0,Time[b-1],Low[b-1],Time[0],Low[b-1]);
ObjectSetInteger(ChartID(),"THHH"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"THHH"+Time[bb],OBJPROP_COLOR,clrDarkBlue);
ObjectSetInteger(ChartID(),"THHH"+Time[bb],OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"THHH"+Time[bb],OBJPROP_WIDTH,2);




}



}

}

//}




/*
for(int s=b+1;b<starts;b++) {


}*/



} else {
/*ObjectCreate(ChartID(),"T"+Time[b],OBJ_TREND,0,Time[b],High[b],Time[shift],Low[shift]);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_COLOR,clrCrimson);*/
/*
ObjectCreate(ChartID(),"TL"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[0],Low[b]);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_COLOR,clrBlack);*/

}





}


//////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////


if ( Low[b+1] >= Low[b] && Low[b+2] > Low[b] && Low[b-1] > Low[b] && Low[b-2] > Low[b] && Low[b-3] > Low[b]) {

//ObjectCreate(ChartID(),"V"+b,OBJ_VLINE,0,Time[b],Ask);

double high=High[b];
int shift=b;

for (int h=b+1;h<b+15;h++) {
if ( High[h] > high ) {
high=High[h];
shift=h;
}
}

bool find=false;
for (int f=b-1;f>0;f--) {
if ( Low[f] < Low[b] && find==false) find=true;
}

/*
swing_low_toplam=swing_low_toplam+1;
swing_low[swing_low_toplam]=Low[b];
swing_low_high[swing_low_toplam]=High[shift];
swing_low_high_shift[swing_low_toplam]=shift;
swing_low_high_time[swing_low_toplam]=Time[shift];*/



if ( find == false ) {
ObjectCreate(ChartID(),"T"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[shift],High[shift]);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_COLOR,clrLightGray);


ObjectCreate(ChartID(),"TL"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[0],Low[b]);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_STYLE,STYLE_DOT);





//if ( b > 50 ) {
//Alert(b,"/",swing_low_toplam);

////////////////////////////////////////////////////////////////////////////////////////
bool finds=false;
//for(int sw=1;sw<=swing_low_toplam;sw++) {
for(int sw=swing_high_toplam;sw>=1;sw--) {

if ( swing_high_low_shift[sw] > b && finds == false ) {
finds=true;
//Alert(b,"/",finds,"/",swing_low_high_shift[sw]);

int bb=swing_high_low_shift[sw];
bb=iBarShift(Symbol(),Period(),swing_high_low_time[sw]);


if ( Low[bb] < Low[b] )continue;

ObjectCreate(ChartID(),"THL"+Time[bb],OBJ_TREND,0,Time[bb],Low[bb],Time[0],Low[bb]);
ObjectSetInteger(ChartID(),"THL"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"THL"+Time[bb],OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),"THL"+Time[bb],OBJPROP_STYLE,STYLE_DOT);
/*
if ( Open[b] > Close[b] ) ObjectCreate(ChartID(),"TLHH"+Time[bb],OBJ_TREND,0,Time[b],Open[b],Time[0],Open[b]);
if ( Close[b] > Open[b] ) ObjectCreate(ChartID(),"TLHH"+Time[bb],OBJ_TREND,0,Time[b],Close[b],Time[0],Close[b]);
ObjectSetInteger(ChartID(),"TLHH"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLHH"+Time[bb],OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),"TLHH"+Time[bb],OBJPROP_STYLE,STYLE_DOT);*/

if ( Open[b] < Close[b] ) ObjectCreate(ChartID(),"TLHHR"+Time[bb],OBJ_RECTANGLE,0,Time[bb],Close[b],Time[0],Low[bb]);
if ( Close[b] < Open[b] ) ObjectCreate(ChartID(),"TLHHR"+Time[bb],OBJ_RECTANGLE,0,Time[bb],Open[b],Time[0],Low[bb]);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_STYLE,STYLE_DOT);

ObjectCreate(ChartID(),"THLL"+Time[bb],OBJ_TREND,0,Time[b],High[b],Time[0],High[b]);
ObjectSetInteger(ChartID(),"THLL"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"THLL"+Time[bb],OBJPROP_COLOR,clrDarkRed);
ObjectSetInteger(ChartID(),"THLL"+Time[bb],OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"THLL"+Time[bb],OBJPROP_WIDTH,2);


if ( (Open[b] < Close[b] && Open[b] > Low[bb]) || (Open[b] > Close[b] && Open[b] > Low[bb])  ) {
ObjectDelete(ChartID(),"TLHHR"+Time[bb]);
if ( Open[b-1] < Close[b-1] ) ObjectCreate(ChartID(),"TLHHR"+Time[bb],OBJ_RECTANGLE,0,Time[bb],Close[b-1],Time[0],Low[bb]);
if ( Close[b-1] < Open[b-1] ) ObjectCreate(ChartID(),"TLHHR"+Time[bb],OBJ_RECTANGLE,0,Time[bb],Open[b-1],Time[0],Low[bb]);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),"TLHHR"+Time[bb],OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),"THLL"+Time[bb]);
ObjectCreate(ChartID(),"THLL"+Time[bb],OBJ_TREND,0,Time[b-1],High[b-1],Time[0],High[b-1]);
ObjectSetInteger(ChartID(),"THLL"+Time[bb],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"THLL"+Time[bb],OBJPROP_COLOR,clrDarkRed);
ObjectSetInteger(ChartID(),"THLL"+Time[bb],OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"THLL"+Time[bb],OBJPROP_WIDTH,2);

}



}

}
////////////////////////////////////////////////////////////////////////////////








} else {
/*ObjectCreate(ChartID(),"T"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[shift],High[shift]);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"T"+Time[b],OBJPROP_COLOR,clrCrimson);

ObjectCreate(ChartID(),"TL"+Time[b],OBJ_TREND,0,Time[b],Low[b],Time[0],Low[b]);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),"TL"+Time[b],OBJPROP_COLOR,clrBlack);*/

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
