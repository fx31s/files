//+------------------------------------------------------------------+
//|                                                         MaEa.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

   string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   
/////////////////////////////////////////////////////////
int ma_shift = 0; // Zaman
int shiftma  = 0;
int shift=0;

extern ENUM_MA_METHOD MaMethod=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrice=PRICE_CLOSE;// Ma Price


extern ENUM_TIMEFRAMES system_time_period = PERIOD_CURRENT;

extern ENUM_MA_METHOD MaMethods=MODE_SMA;  // Method
extern ENUM_APPLIED_PRICE MaPrices=PRICE_CLOSE;// Ma Price

extern ENUM_TIMEFRAMES MaTimeA = PERIOD_CURRENT;
extern ENUM_TIMEFRAMES MaTimeB = PERIOD_CURRENT;
extern ENUM_TIMEFRAMES MaTimeC = PERIOD_CURRENT;

//extern int MA_W=21;
//extern int MB_W=55;

extern int MA_W=50;
extern int MB_W=10;
extern int MC_W=20;
/////////////////////////////////////////////////////////

double ma_high=-1;
double ma_low=1000000;


double ma_level[1001];


int swing_power=34;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int OnInit()
  {
  
  //EngineMa();
  
  
  return(INIT_SUCCEEDED);
  }

int EngineMa()
  {
//---




int Barss=Bars-100;
Barss=1000;

   sym=Symbol();
   per=Period();
   

//ObjectsDeleteAll();
EngineClear();

/*
     ObjectDelete(ChartID(),"MA");
     ObjectCreate(ChartID(),"MA",OBJ_VLINE,0,Time[1],Ask);
     ObjectSetInteger(ChartID(),"MA",OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA",OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA",OBJPROP_WIDTH,2);
     */
     
     

/*
for (int i=1000;i>0;i--) {
ma_level[i]=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);

}
*/


for(int i=1;i<Bars-500;i++){


double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);
double mb=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, i);
double mc=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, i);


if ( iClose(sym,per,i) > ma ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && 
find==false && iClose(sym,per,b) < ma ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrLimeGreen);
}

}




if ( iClose(sym,per,i) < ma ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && 
find==false && iClose(sym,per,b) > ma ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrRed);
}

}












//continue;


if ( iClose(sym,per,i) > mb ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( //ma > mab && 
find==false && iClose(sym,per,b) < mab ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrLimeGreen);
}

}


if ( iClose(sym,per,i) < mb ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( //ma < mab && 
find==false && iClose(sym,per,b) > mab ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrRed);
}

}




if ( iClose(sym,per,i) > mc ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, b);

if ( //ma > mab && 
find==false && iClose(sym,per,b) < mab ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrLimeGreen);
}

}


if ( iClose(sym,per,i) < mc ) {

int left_say=0;
int shift=0;
bool find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, b);

if ( //ma < mab && 
find==false && iClose(sym,per,b) > mab ) {
left_say=left_say+1;
shift=b;
} else {
find=true;
}

}


if ( left_say >= 15 ) {
ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],Ask);
ObjectSetInteger(ChartID(),"VLINE"+i,OBJPROP_COLOR,clrRed);
}

}





}



for ( int i=Barss;i>65;i--) {

if ( Bars < i ) continue;

double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma < High[b] && find==false) {
say=say+1;
} else {
//find=true;
}

}






if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,true);
     
          

}


if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,true);
     ObjectDelete(ChartID(),"MAL"+i);
          

}






}


//return 0;


for ( int i=Barss;i>25;i--) {

if ( Bars < i ) continue;

double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma > Low[b] && find==false) {
say=say+1;
} else {
//find=true;
}

}




if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,true);
          

}


if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,true);
     ObjectDelete(ChartID(),"MAL"+i);     

}







}




for ( int i=Barss;i>65;i--) {


if ( Bars < i ) continue;


double ma=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma < High[b] && find==false) {
say=say+1;
} else {
//find=true;
}

}






if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     ObjectDelete(ChartID(),"MBL"+i);
     ObjectCreate(ChartID(),"MBL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_COLOR,clrLightGray);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_BACK,true);
     
          

}


if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     
     ObjectCreate(ChartID(),"MBL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_COLOR,clrLightGray);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_BACK,true);
     ObjectDelete(ChartID(),"MBL"+i);
          

}







}


//return 0;


for ( int i=Barss;i>25;i--) {


if ( Bars < i ) continue;

double ma=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma > Low[b] && find==false) {
say=say+1;
} else {
//find=true;
}

}




if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     ObjectDelete(ChartID(),"MBL"+i);
     ObjectCreate(ChartID(),"MBL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_COLOR,clrBlue);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_BACK,true);
          

}



if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     
     ObjectCreate(ChartID(),"MBL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_COLOR,clrBlue);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_BACK,true);
     ObjectSetInteger(ChartID(),"MBL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectDelete(ChartID(),"MBL"+i);     

}





}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


for ( int i=Barss;i>65;i--) {


if ( Bars < i ) continue;


double ma=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, b);

if ( ma > mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma < High[b] && find==false) {
say=say+1;
} else {
//find=true;
}

}






if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     ObjectDelete(ChartID(),"MCL"+i);
     ObjectCreate(ChartID(),"MCL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_COLOR,clrLightBlue);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_BACK,true);
     
          

}


if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     
     ObjectCreate(ChartID(),"MCL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_COLOR,clrLightBlue);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_BACK,true);
     ObjectDelete(ChartID(),"MCL"+i);
          

}







}


//return 0;


for ( int i=Barss;i>25;i--) {


if ( Bars < i ) continue;

double ma=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, i);

// right
int right_say=0;
bool find=false;
for(int b=i-1;b>i-65;b--) {

double mab=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
right_say=right_say+1;
} else {
find=true;
}

}


// right
int left_say=0;
find=false;
for(int b=i+1;b<i+65;b++) {

double mab=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, b);

if ( ma < mab && find==false) {
left_say=left_say+1;
} else {
find=true;
}

}




// right
int say=0;
find=false;
for(int b=i-1;b>0;b--) {

//double mab=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, b);

///if ( ma > Open[b] &&  ma < Close[b] && find==false) {
if ( ma > Low[b] && find==false) {
say=say+1;
} else {
//find=true;
}

}




if ( right_say >= swing_power && left_say >=  swing_power && say < 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     ObjectDelete(ChartID(),"MCL"+i);
     ObjectCreate(ChartID(),"MCL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_COLOR,clrTurquoise);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_BACK,true);
          

}



if ( right_say >= swing_power && left_say >=  swing_power && say > 40) {
/*
     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);*/
     
     
     ObjectCreate(ChartID(),"MCL"+i,OBJ_TREND,0,Time[i],ma,Time[i]+1000*PeriodSeconds(),ma);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_COLOR,clrTurquoise);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_WIDTH,1);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_BACK,true);
     ObjectSetInteger(ChartID(),"MCL"+i,OBJPROP_STYLE,STYLE_DOT);
     ObjectDelete(ChartID(),"MCL"+i);     

}





}


















EngineClearVline();




return 0;


for (int i=960;i>40;i--) {

//double prev=ma_level[i+40];
//double next=ma_level[i-40];

//if ( ma_level[i] < prev && ma_level[i] < next ) {
double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);
double ma1=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+1);
double ma2=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+2);
double ma3=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+3);
double ma4=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+4);
double ma5=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+5);
double ma6=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+6);
double ma7=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+7);
double ma8=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+8);
double ma9=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+9);
double ma10=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+10);


double man1=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-1);
double man2=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-2);
double man3=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-3);
double man4=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-4);
double man5=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-5);
double man6=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-6);
double man7=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-7);
double man8=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-8);
double man9=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-9);
double man10=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-10);

//if ( iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i) < iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i+20) && iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i) < iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i-20) ) {


if ( ma < ma1 && ma < ma2 && ma < ma3 && ma < ma4 && ma < ma6 && ma < man1 && ma < man2 && ma < man3 && ma < man4 && ma < man6 ) {


     ObjectDelete(ChartID(),"MA"+i);
     ObjectCreate(ChartID(),"MA"+i,OBJ_VLINE,0,Time[i],Ask);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_WIDTH,2);
     ObjectSetInteger(ChartID(),"MA"+i,OBJPROP_BACK,true);
     

}

}


return 0;


     ObjectDelete(ChartID(),"MA");
     ObjectCreate(ChartID(),"MA",OBJ_TREND,0,Time[1],Low[1],Time[1],Low[1]);
     ObjectSetInteger(ChartID(),"MA",OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MA",OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MA",OBJPROP_WIDTH,2);


     ObjectDelete(ChartID(),"MAH");
     ObjectCreate(ChartID(),"MAH",OBJ_TREND,0,Time[1],Low[1],Time[1],Low[1]);
     ObjectSetInteger(ChartID(),"MAH",OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAH",OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MAH",OBJPROP_WIDTH,2);
     

     ObjectDelete(ChartID(),"MAL");
     ObjectCreate(ChartID(),"MAL",OBJ_TREND,0,Time[1],Low[1],Time[1],Low[1]);
     ObjectSetInteger(ChartID(),"MAL",OBJPROP_RAY,False);
     ObjectSetInteger(ChartID(),"MAL",OBJPROP_COLOR,clrWhite);
     ObjectSetInteger(ChartID(),"MAL",OBJPROP_WIDTH,2);
          
          

   
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

datetime bar_time;

void OnTick()
  {
//---

if ( Time[1] != bar_time ) {
bar_time=Time[1];
EngineMa();
}




return;


   double MA1H=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, 0); 
   //OrderCommetssTypeMulti(Symbol());
   //Comment("BuyProfit:",buy_profit,"/ Sell Profit:",sell_profit,"Ma:",MA1H);

   ObjectMove(ChartID(),"MA",0,Time[0],MA1H);
   ObjectMove(ChartID(),"MA",1,Time[0]+20*PeriodSeconds(),MA1H);
   
   if ( MA1H >= ma_high ) {

   ObjectMove(ChartID(),"MAH",0,Time[0],MA1H);
   ObjectMove(ChartID(),"MAH",1,Time[0]+20*PeriodSeconds(),MA1H);
   
   ma_high=MA1H;
   //ma_low=1000000;
      
   
   }


   if ( MA1H <= ma_low ) {

   ObjectMove(ChartID(),"MAL",0,Time[0],MA1H);
   ObjectMove(ChartID(),"MAL",1,Time[0]+20*PeriodSeconds(),MA1H);
   
   ma_low=MA1H;
   //ma_high=-1;   
      
   
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


void EngineClear() {

return;

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     //string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     if (  StringFind(names,"MAL",0) != -1 || StringFind(names,"MBL",0) != -1 || StringFind(names,"MCL",0) != -1) {
     
     ObjectDelete(ChartID(),names);
     
     
     }
     
     
     
     }
     

}

void EngineClearVline() {

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     //string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     if (  StringFind(names,"VLINE",0) != -1 || StringFind(names,"VLINE",0) != -1 ) {
     
     ObjectDelete(ChartID(),names);
     
     
     }
     
     
     
     }
     

}
