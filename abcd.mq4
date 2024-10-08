//+------------------------------------------------------------------+
//|                                                    SwingFind.mq4 |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string headers;
char posts[],post[], result[];


/*
#import "shell32.dll"
int ShellExecuteW(int hwnd, string Operation, string File, string Parameters, string Directory, int ShowCmd);
#import*/
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

// Çalışanları iptal ediyoruz.


double swing_high=-1;
datetime swing_high_time;
double swing_low=100000000;
datetime swing_low_time;

double last_swing_low=100000000;
datetime last_swing_low_time;

double last_swing_high=-1;
datetime last_swing_high_time;


double sinyal_level=80.0;
bool sinyal_alert=true;
bool sinyal_phone=true;
bool sinyal_telegram=true;

 
string sinyal_list="";
datetime sinyal_time=-1;
bool sinyal_load=false;

int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   //Telegram(Symbol()+" Abcd "+TFtoStr(Period()),"");
   
   
 bool test_sinyal_telegram=false;
 
if ( test_sinyal_telegram == true ) {

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();
long ChartIDS=ChartID();

Sleep(100);    

   string Sinyal=sym+"-"+TFtoStr(per)+"-Abcd-Reserval-Sell";
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+per;
   
   
   SinyalS=sym+per+"SRS"+Time[0];
   
string fname="Abcd";
string image_files=sym+"-"+fname+"-"+per;


           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif";    
   

bool sinyal_sonuc=Telegram(Sinyal,SinyalS,filename,per,sym);
if ( sinyal_sonuc ) TelegramPhoto("Supdem",per,ChartIDS,sym);

     
     }  
     
     
     OnTick();
     
   
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

if ( sinyal_time != Time[1] ) {
  sinyal_load=false;
  Swing();
  abcdEngine();
  WorkEngine();
  WorkEngineAllClear();
  sinyal_time=Time[1];
  sinyal_load=true;
}

if ( sinyal_load == true && ObjectsTotal() > 0 ) SinyalEngine();




   
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
  
  bool space=false;
  bool updown=false;
  bool swinglows=true;
  bool swinghighs=true;
  
  
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
  
  if ( sparam == 17 ) {
  
  WorkEngine();
  WorkEngineAllClear();
  
  Print("WorkEngine");
  
  }
  
  //Print("Sparam",sparam);
  
  if ( sparam == 45 )  {
  Swing();
  abcdEngine();
  WorkEngine();
  WorkEngineAllClear();  
  }
  
  if ( sparam == 31 ) {
  
  if ( space == false ) {space=true;} else {space=false;}
  
  Comment("Space:",space);
  
  }
  
  if ( sparam == 22 ) {
  
  if ( updown == false ) {updown=true;} else {updown=false;}
  
  Comment("UpDown:",updown);
  
  }
  
    
  if ( sparam == 35 ) {
  
  if ( swinghighs == false ) {swinghighs=true;} else {swinghighs=false;}
  
  Comment("swinghighs:",swinghighs);
  
  }

  if ( sparam == 38 ) {
  
  if ( swinglows == false ) {swinglows=true;} else {swinglows=false;}
  
  Comment("swinglows:",swinglows);
  
  }
        
  
  
//---
/*
if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND ) {

datetime cs_time1=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME,0);
datetime cs_time2=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME,0);

CanddleShootingLine(sparam,cs_time1,cs_time2,Symbol(),Period(),"BUY",ChartID(),3);

}
*/


   
  }
//+------------------------------------------------------------------+


void CanddleShootingLine(string sparam,datetime cs_time1,datetime cs_time2,string cs_sym,int cs_per,string cs_islem,long cs_chartid,int cs_scale) {


//ObjectsDeleteAlls(ChartID(),"Trend Manuel",0,-1);
///ObjectsDeleteAll();
int cscale=3;
if ( cs_per == 240 ) cscale=3;
if ( cs_per == 60 ) cscale=2;
if ( cs_per == 15 ) cscale=0;
if ( cs_per == 5 ) cscale=0;
if ( cs_per == 1 ) cscale=0;

if ( cs_scale == -1 ) ChartSetInteger(ChartID(),CHART_SCALE,0,cscale);
if ( cs_scale != -1 ) ChartSetInteger(ChartID(),CHART_SCALE,0,cs_scale);
ChartSetInteger(ChartID(), CHART_SHIFT, 1);
ChartSetDouble(ChartID(), CHART_SHIFT_SIZE, 0);
ChartSetInteger(ChartID(),CHART_AUTOSCROLL,true);

   

//Alert(cs_sym);
/*
cs_time1="6.18 14:30";
cs_time2="6.19 06:15";

//cs_time2="6.19 15:15";
//cs_time1="6.19 06:15";


cs_time1="6.16 20:30";
cs_time2="6.17 03:15";*/


  //string yenitarih= IntegerToString(int(Year()))+"."+cs_time1;
  ///string yenitarih= cs_time1;
  
  
  
  //string yenitarih= IntegerToString(int(Year()))+"."+06+"."+21+" "+00+":"+00;
 datetime c_time1 = cs_time1; /// StringToTime(yenitarih);
 int c_shift1=iBarShift(cs_sym,cs_per,c_time1);
 double c_price1_high=iHigh(cs_sym,cs_per,c_shift1);
 double c_price1_low=iLow(cs_sym,cs_per,c_shift1);
 double c_price1_open=iOpen(cs_sym,cs_per,c_shift1);
 double c_price1_close=iOpen(cs_sym,cs_per,c_shift1);
  
  /*ObjectDelete(ChartID(),"Event12");
  ObjectCreate(ChartID(),"Event12",OBJ_VLINE,0,c_time1,0);
  ObjectSetString(ChartID(),"Event12",OBJPROP_TEXT,"21 December");
  ObjectSetInteger(ChartID(),"Event12",OBJPROP_COLOR,clrTurquoise);   */
  
//   yenitarih= IntegerToString(int(Year()))+"."+06+"."+06+" "+00+":"+00;

   //yenitarih= IntegerToString(int(Year()))+"."+cs_time2;
   ///yenitarih= cs_time2;

 datetime c_time2 = cs_time2;///StringToTime(yenitarih);
 int c_shift2=iBarShift(cs_sym,cs_per,c_time2);
 double c_price2_high=iHigh(cs_sym,cs_per,c_shift2);
 double c_price2_low=iLow(cs_sym,cs_per,c_shift2); 
 double c_price2_open=iOpen(cs_sym,cs_per,c_shift2);
 double c_price2_close=iOpen(cs_sym,cs_per,c_shift2);
  
  /*ObjectDelete(ChartID(),"Event13");
  ObjectCreate(ChartID(),"Event13",OBJ_VLINE,0,c_time2,0);
  ObjectSetString(ChartID(),"Event13",OBJPROP_TEXT,"04 February Small Change");
  ObjectSetInteger(ChartID(),"Event13",OBJPROP_COLOR,clrTurquoise); */
  
  
//ChartNavigate(ChartID(),CHART_BEGIN,c_shift1);
  


if ( sparam == "" ) {
sparam="Trend Manuel";

 ObjectDelete(ChartID(),sparam);
 ObjectCreate(ChartID(),sparam,OBJ_TREND,0,c_time1,c_price1_close,c_time2,c_price2_close);

}

//Alert("Selam");

//return;




int indexss = StringFind(sparam,"ShootingStar", 0); 


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && indexss == -1 ) {


//Alert("SELAM");



////////////////////////////////////////////////////////////////////////////////////////
// TREND LINE LOCK
///////////////////////////////////////////////////////////////////////////////////////
if ( ObjectGetString(ChartID(),sparam,OBJPROP_TEXT) == "" && ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP) == "" )  {
ObjectSetString(ChartID(),sparam,OBJPROP_TEXT,Period());

ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STYLE,2);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlack);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_RAY,false);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_BACK,false);
if ( LINE_SYSTEM == false ) ObjectSetInteger(ChartID(),sparam,OBJPROP_WIDTH,2);


if ( LINE_SYSTEM ) {
ObjectSetString(ChartID(),sparam,OBJPROP_TOOLTIP,TFtoStr(Period()));

if ( Period() == PERIOD_D1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlue);
if ( Period() == PERIOD_H4 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrRed);
if ( Period() == PERIOD_H1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrGreen);
if ( Period() == PERIOD_M30 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrYellow);
if ( Period() == PERIOD_M15 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrMagenta);
if ( Period() == PERIOD_M5 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrWhite);
if ( Period() == PERIOD_W1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBlack);
if ( Period() == PERIOD_M1 ) ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrBrown);
}

} else {
if ( int(ObjectGetString(ChartID(),sparam,OBJPROP_TEXT)) != Period() ) {
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTED,false);
return;
} else {
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),sparam,OBJPROP_SELECTED,true);
}
}
///////////////////////////////////////////////////////////////////////////////////////





last_object=sparam;
Comment("last_object",last_object);

  double price1=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE1);
  double price2=ObjectGetDouble(ChartID(),sparam,OBJPROP_PRICE2);
  
  double time1=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME1);
  double time2=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME2);
  
  int shift1=iBarShift(Symbol(),Period(),time1);
  int shift2=iBarShift(Symbol(),Period(),time2);
  
//if ( LINE_SYSTEM ) {  
ObjectDelete(ChartID(),sparam+"-ShootingStar-31");
ObjectCreate(ChartID(),sparam+"-ShootingStar-31",OBJ_TREND,0,time1,price1,time2,price2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_WIDTH,4);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_SELECTED,false);  
ObjectSetString(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TEXT,TFtoStr(Period())); 

//}  
  
if ( LINE_SYSTEM || ObjectGetString(ChartID(),sparam,OBJPROP_TOOLTIP) != "" ) return;  
  
  
  
  
  

if ( price1 > price2 ) {


//Alert("Selam");


ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,Low[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,Low[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,Low[shift1]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME2,Time[shift2]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE2,Low[shift2]);
ChartRedraw();
price1=Low[shift1];
price2=Low[shift2];




if ( multi_mod == true && last_mode_vline_price !=-1 ) {

price1=last_mode_vline_price;
shift1=last_mode_vline_shift;
/*
last_mode_vline="";
last_mode_vline_time=-1;
last_mode_vline_price=-1;
last_mode_vline_shift=-1;*/

ObjectSetInteger(ChartID(),sparam,OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,Low[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,Low[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,Low[shift1]);

}




///////////////////////////////////////////////////////////////////////////////////////////////////////////////
mod_change=false;


if ( multi_mod ) {

if ( mod_price == -1 && mod_prices == -1 ) {
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
}


if ( NormalizeDouble(mod_price,Digits) == NormalizeDouble(price2,Digits) && mod_prices != price1) {
last_mod_prices=mod_prices;
Comment("last_mod_prices",last_mod_prices);
//Alert("Üst Sabit - Alt Değişti",mod_price,"/",price2,"/",price1,"/",mod_prices);
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
mod_change = true;
//return;
} else {
mod_type = "LOWUP";
mod_price = NormalizeDouble(price2,Digits);
//mod_price = price2;
mod_prices = price1;
}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////





///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ObjectDelete(ChartID(),sparam+"-ShootingStar-666");
ObjectCreate(ChartID(),sparam+"-ShootingStar-666",OBJ_TREND,0,time2,price2,time2+(time2-time1),price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_BACK,true);


ObjectDelete(ChartID(),sparam+"-ShootingStar-333");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333",OBJ_TREND,0,time1,price1,time1+(time2-time1),price1+(price1-price2));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_BACK,true);

//Alert("Selam2");



//double price=ObjectGetValueByShift("MyTrendLine#123", 11)

int shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
//Alert(shift);


double SS888=price1;

string namel=sparam+"-ShootingStar-888";

if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;


ObjectDelete(ChartID(),namel);
if ( shift > -1 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[shift],price1);
if ( shift < 0 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
/*{ 
 } else {
shift=1; // Hafa verdiği için ekledim.
ObjectCreate(ChartID(),sparam+"-ShootingStar-888",OBJ_TREND,0,time1,price1,Time[shift],price1);
}*/
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);


/*
//shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
*/
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);*/
/*
shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2+(High[shift1]-Low[shift1]));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222");
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,High[shift1],Time[0]+MathAbs(shift)*PeriodSeconds(),price2+(High[shift1]-Low[shift1]));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,High[shift1],Time[shift],price2+(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_RAY,false);
*/




int x=0;
for (int t=1;t<=150;t++) {
x=t-1;

//if ( price2+((High[shift1]-Low[shift1])*t) > Low[shift2]+(((price1-price2)/100)*88.6) ) continue;



shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2+((High[shift1]-Low[shift1])*t));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price2+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price2+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1222-"+t);

if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*t),Time[0]+MathAbs(shift)*PeriodSeconds(),price2+((High[shift1]-Low[shift1])*x));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,High[shift1]+((High[shift1]-Low[shift1])*t),Time[shift],price2+((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_TIMEFRAMES, -1);
}




x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-31", price1+((High[shift1]-Low[shift1])*t));


ObjectDelete(ChartID(),sparam+"-ShootingStar-333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),time1+(time2-time1),(price1-(price2-price1))-((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_TIMEFRAMES, -1);


ObjectDelete(ChartID(),sparam+"-ShootingStar-1333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),time1+(time2-time1),(price1-(price2-price1))-((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_TIMEFRAMES, -1);

/*if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price1+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price1+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_RAY,true);*/


}




/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////


double SS618=High[shift1]-(((High[shift1]-price2)/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-618");
ObjectCreate(ChartID(),sparam+"-ShootingStar-618",OBJ_TREND,0,time1,SS618,time2,SS618);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_BACK,true);

double SS382=High[shift1]-(((High[shift1]-price2)/100)*38.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-382");
ObjectCreate(ChartID(),sparam+"-ShootingStar-382",OBJ_TREND,0,time1,SS382,time2,SS382);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_BACK,true);



double SS500=High[shift1]-(((High[shift1]-price2)/100)*50);
ObjectDelete(ChartID(),sparam+"-ShootingStar-500");
ObjectCreate(ChartID(),sparam+"-ShootingStar-500",OBJ_TREND,0,time1,SS500,time2,SS500);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_BACK,true);


double SS236=High[shift1]-(((High[shift1]-price2)/100)*23.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-236");
ObjectCreate(ChartID(),sparam+"-ShootingStar-236",OBJ_TREND,0,time1,SS236,time2,SS236);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_BACK,true);

double SS854=High[shift1]-(((High[shift1]-price2)/100)*85.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-854");
ObjectCreate(ChartID(),sparam+"-ShootingStar-854",OBJ_TREND,0,time1,SS854,time2,SS854);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_BACK,true);

double SS736=High[shift1]-(((High[shift1]-price2)/100)*73.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-736");
ObjectCreate(ChartID(),sparam+"-ShootingStar-736",OBJ_TREND,0,time1,SS736,time2,SS736);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_BACK,true);

double SS354=High[shift1]-(((High[shift1]-price2)/100)*35.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-354");
ObjectCreate(ChartID(),sparam+"-ShootingStar-354",OBJ_TREND,0,time1,SS354,time2,SS354); // 236 + 118
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_BACK,true);

double SS309=High[shift1]-(((High[shift1]-price2)/100)*30.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-309");
ObjectCreate(ChartID(),sparam+"-ShootingStar-309",OBJ_TREND,0,time1,SS309,time2,SS309); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_BACK,true);

double SS441=High[shift1]-(((High[shift1]-price2)/100)*44.1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-441");
ObjectCreate(ChartID(),sparam+"-ShootingStar-441",OBJ_TREND,0,time1,SS441,time2,SS441); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_BACK,true);

double SS559=High[shift1]-(((High[shift1]-price2)/100)*55.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-559");
ObjectCreate(ChartID(),sparam+"-ShootingStar-559",OBJ_TREND,0,time1,SS559,time2,SS559); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_BACK,true);

double SS677=High[shift1]-(((High[shift1]-price2)/100)*67.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-677");
ObjectCreate(ChartID(),sparam+"-ShootingStar-677",OBJ_TREND,0,time1,SS677,time2,SS677); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_BACK,true);

double SS795=High[shift1]-(((High[shift1]-price2)/100)*79.5);
ObjectDelete(ChartID(),sparam+"-ShootingStar-795");
ObjectCreate(ChartID(),sparam+"-ShootingStar-795",OBJ_TREND,0,time1,SS795,time2,SS795); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_BACK,true);

double SS913=High[shift1]-(((High[shift1]-price2)/100)*91.3);
ObjectDelete(ChartID(),sparam+"-ShootingStar-913");
ObjectCreate(ChartID(),sparam+"-ShootingStar-913",OBJ_TREND,0,time1,SS913,time2,SS913); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_BACK,true);

///
double SS177=High[shift1]-(((High[shift1]-price2)/100)*17.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-117");
ObjectCreate(ChartID(),sparam+"-ShootingStar-177",OBJ_TREND,0,time1,SS177,time2,SS177); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_BACK,true);


double SS118f=High[shift1]-(((High[shift1]-price2)/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-118f");
ObjectCreate(ChartID(),sparam+"-ShootingStar-118f",OBJ_TREND,0,time1,SS118f,time2,SS118f); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_BACK,true);

double SS59=High[shift1]-(((High[shift1]-price2)/100)*5.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-59");
ObjectCreate(ChartID(),sparam+"-ShootingStar-59",OBJ_TREND,0,time1,SS59,time2,SS59); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_BACK,true);



double SS1272=High[shift1]-(((High[shift1]-price2)/100)*127.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272",OBJ_TREND,0,time1,SS1272,time2,SS1272); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_BACK,true);

double SS1118=High[shift1]-(((High[shift1]-price2)/100)*111.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_BACK,true);

double SS1414=High[shift1]-(((High[shift1]-price2)/100)*141.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414",OBJ_TREND,0,time1,SS1414,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_BACK,true);

double SS1618=High[shift1]-(((High[shift1]-price2)/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_BACK,true);

double SS2618=High[shift1]-(((High[shift1]-price2)/100)*261.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618",OBJ_TREND,0,time1,SS2618,time2,SS2618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_BACK,true);


//////////////////////////////////////////////////////////

double SS1272n=High[shift1]+(((High[shift1]-price2)/100)*27.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272n",OBJ_TREND,0,time1,SS1272n,time2,SS1272n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_BACK,true);

double SS1118n=High[shift1]+(((High[shift1]-price2)/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118n",OBJ_TREND,0,time1,SS1118n,time2,SS1118n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_BACK,true);

double SS1414n=High[shift1]+(((High[shift1]-price2)/100)*41.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414n",OBJ_TREND,0,time1,SS1414n,time2,SS1414n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_BACK,true);

double SS1618n=High[shift1]+(((High[shift1]-price2)/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618n",OBJ_TREND,0,time1,SS1618n,time2,SS1618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_BACK,true);

//Alert(shift1,"/",price2);
double SS2618n=High[shift1]+(((High[shift1]-price2)/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618n",OBJ_TREND,0,time1,SS2618n,time2,SS2618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_BACK,true);







double SS827=Low[shift2]+(((price1-price2)/100)*87.6);

namel=sparam+"-ShootingStar-827";

if ( mod_change ) namel=sparam+"-ShootingStar-827-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS827,time2+PeriodSeconds()*11,SS827);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);



double SS842=Low[shift2]+(((price1-price2)/100)*84.2);

namel=sparam+"-ShootingStar-842";

if ( mod_change ) namel=sparam+"-ShootingStar-842-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS842,time2+PeriodSeconds()*11,SS842);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);





double SS864=Low[shift2]+(((price1-price2)/100)*86.4);

namel=sparam+"-ShootingStar-864";

if ( mod_change ) namel=sparam+"-ShootingStar-864-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS864,time2+PeriodSeconds()*11,SS864);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);




double SS886=Low[shift2]+(((price1-price2)/100)*88.6);

namel=sparam+"-ShootingStar-886";

if ( mod_change ) namel=sparam+"-ShootingStar-886-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS886,time2,SS886);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");



double SS786=Low[shift2]+(((price1-price2)/100)*78.6);

namel=sparam+"-ShootingStar-786";

if ( mod_change ) namel=sparam+"-ShootingStar-786-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS786,time2,SS786);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,4);



double SS707=Low[shift2]+(((price1-price2)/100)*70.7);

namel=sparam+"-ShootingStar-707";

if ( mod_change ) namel=sparam+"-ShootingStar-707-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS707,time2,SS707);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);



double SS764=Low[shift2]+(((price1-price2)/100)*76.4);

namel=sparam+"-ShootingStar-764";

if ( mod_change ) namel=sparam+"-ShootingStar-764-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS764,time2,SS764);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,3);


int spread=(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/Point;
int fark = int((SS886-SS764)/Point);

//Comment("Pip:",fark,"/",spread,"=",fark/spread,"/",(fark-spread));
Comment("Pip:",fark,"/",spread,"/",(fark-spread));

//Alert("Selam3",SS886,"/",shift1);

//////////////////////////////////////////////////////
// Seviyeyi geçip geçmediğini kontrol eden çubukları ayarlıyor
//////////////////////////////////////////////////////
int shiftc=1;
if ( shift1 > 1000 ) {

int shift886=ObjectGetShiftByValue(sparam+"-ShootingStar-666", SS886);

ObjectDelete(ChartID(),sparam+"CONTROL");
//ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);

if ( shift886 > 0 ) ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);
if ( shift886 < -0 ) {
datetime ctime=Time[0]+MathAbs(shift886)*PeriodSeconds();
ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,ctime,SS886);
}


shiftc=shift1-((shift1-shift886)*2);
if ( shiftc < 0 ) shiftc=1;
} 
/////////////////////////////////////////////////////



for(int c=shiftc;c<=shift1-10;c++){

ObjectDelete(ChartID(),sparam+"CONTROL"+c);

if ( High[c] >= SS886 && Close[c] < SS886 ) {

      ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_TIME,Time[c]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"CONTROL"+c,OBJPROP_PRICE,High[c]);// Set price
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ANCHOR,ANCHOR_UPPER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrBlack);

//ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_VLINE,0,Time[c],Close[c]);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrDarkGray);
}

//Print(c);

}


/*
//if ( order_mode == true ) {
if ( cs_islem == "ORDER" ) {

order1=NormalizeDouble(SS886,Digits);
order2=NormalizeDouble(Low[shift1],Digits);
tp=NormalizeDouble(SS764,Digits);
tp1=NormalizeDouble(SS764,Digits);
tp3=NormalizeDouble(SS618,Digits);
sl=NormalizeDouble(High[shift1],Digits);

string ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-1";
int ticket=OrderSend(Symbol(),OP_SELLLIMIT,wlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

tp=NormalizeDouble(SS786,Digits);
tp2=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-2";
int ticket2=OrderSend(Symbol(),OP_SELLLIMIT,wlot,order2,0,sl,tp,ordercmt,0,0,clrNONE);


order3=NormalizeDouble(SS864,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-3";
int ticket3=OrderSend(Symbol(),OP_SELLLIMIT,wlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

order_type=OP_SELLLIMIT;
//order_mode=false;

}
*/





double SS118=Low[shift2]+(((price1-price2)/100)*11.8);

namel=sparam+"-ShootingStar-118";

if ( mod_change ) namel=sparam+"-ShootingStar-118-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS118,time2+PeriodSeconds()*11,SS118);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBisque);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);





}




//if ( price2 > price1 ) {
if ( price1 < price2 ) {






ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,High[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,High[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,High[shift1]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME2,Time[shift2]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE2,High[shift2]);
//ChartRedraw();

price1=High[shift1];
price2=High[shift2];


if ( multi_mod == true && last_mode_vline_price !=-1 ) {

price1=last_mode_vline_price;
shift1=last_mode_vline_shift;
/*
last_mode_vline="";
last_mode_vline_time=-1;
last_mode_vline_price=-1;
last_mode_vline_shift=-1;*/

ObjectSetInteger(ChartID(),sparam,OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE1,High[shift1]);
ObjectSetDouble(ChartID(),sparam,OBJPROP_PRICE2,High[shift2]);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-31",OBJPROP_TIME1,Time[shift1]);
ObjectSetDouble(ChartID(),sparam+"-ShootingStar-31",OBJPROP_PRICE1,High[shift1]);

}



///////////////////////////////////////////////////////////////////////////////////////////////////////////////
mod_change=false;


if ( multi_mod ) {

if ( mod_price == -1 && mod_prices == -1 ) {
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
}

mod_type = "HIGHDOWN";

if ( NormalizeDouble(mod_price,Digits) == NormalizeDouble(price2,Digits) && mod_prices != price1) {
last_mod_prices=mod_prices;
Comment("last_mod_prices",last_mod_prices);
//Alert("Üst Sabit - Alt Değişti",mod_price,"/",price2,"/",price1,"/",mod_prices);
mod_price = NormalizeDouble(price2,Digits);
mod_prices = price1;
mod_change = true;
//return;
} else {

mod_price = NormalizeDouble(price2,Digits);
//mod_price = price2;
mod_prices = price1;
}
}

//Alert("Mod Type:",mod_type);

//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//Alert("Selam3=",price2,"/",mod_price);
//

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ObjectDelete(ChartID(),sparam+"-ShootingStar-666");
ObjectCreate(ChartID(),sparam+"-ShootingStar-666",OBJ_TREND,0,time2,price2,time2+(time2-time1),price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-666",OBJPROP_BACK,true);

ObjectDelete(ChartID(),sparam+"-ShootingStar-333");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333",OBJ_TREND,0,time1,price1,time1+(time2-time1),price1-(price2-price1));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333",OBJPROP_BACK,true);





//double price=ObjectGetValueByShift("MyTrendLine#123", 11)

int shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
//Alert(shift);


double SS888=price1;

string namel=sparam+"-ShootingStar-888";

if ( mod_change ) namel=sparam+"-ShootingStar-888-"+mod_prices;

ObjectDelete(ChartID(),namel);
if ( shift > -1 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[shift],price1);
if ( shift < 0 ) ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,price1,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
/*{ 
 } else {
shift=1; // Hafa verdiği için ekledim.
ObjectCreate(ChartID(),sparam+"-ShootingStar-888",OBJ_TREND,0,time1,price1,Time[shift],price1);
}*/
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);





/*
//shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);
*/
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-999");
if ( shift < 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[0]+MathAbs(shift)*PeriodSeconds(),price1);
if ( shift > -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-999",OBJ_TRIANGLE,0,time1,price1,time2,price2,Time[shift],price1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-999",OBJPROP_COLOR,clrBisque);*/

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2-(High[shift1]-Low[shift1]));
/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-222");
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,Low[shift1],Time[0]+MathAbs(shift)*PeriodSeconds(),price2-(High[shift1]-Low[shift1]));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222",OBJ_TREND,0,time1,Low[shift1],Time[shift],price2-(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222",OBJPROP_RAY,false);
*/
int x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-666", price2-((High[shift1]-Low[shift1])*t));

ObjectDelete(ChartID(),sparam+"-ShootingStar-222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price2-((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*x),Time[shift],price2-((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-222-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1222-"+t);
if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),Time[0]+MathAbs(shift)*PeriodSeconds(),price2-((High[shift1]-Low[shift1])*x));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJ_TREND,0,time1,Low[shift1]-((High[shift1]-Low[shift1])*t),Time[shift],price2-((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_RAY,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1222-"+t,OBJPROP_TIMEFRAMES, -1);


}


/*
ObjectDelete(ChartID(),sparam+"-ShootingStar-333-x");
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-x",OBJ_TREND,0,time1,price1+(High[shift1]-Low[shift1]),time1+(time2-time1),(price1-(price2-price1))+(High[shift1]-Low[shift1]));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-x",OBJPROP_BACK,true);
*/




x=0;
for (int t=1;t<=150;t++) {
x=t-1;

shift=ObjectGetShiftByValue(sparam+"-ShootingStar-31", price1+((High[shift1]-Low[shift1])*t));


ObjectDelete(ChartID(),sparam+"-ShootingStar-333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*t),time1+(time2-time1),(price1-(price2-price1))+((High[shift1]-Low[shift1])*x));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_TIMEFRAMES, -1);

ObjectDelete(ChartID(),sparam+"-ShootingStar-1333-"+t);
ObjectCreate(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),time1+(time2-time1),(price1-(price2-price1))+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1333-"+t,OBJPROP_TIMEFRAMES, -1);

/*if ( shift < -1 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[0]+MathAbs(shift)*PeriodSeconds(),price1+((High[shift1]-Low[shift1])*t));
if ( shift >= 0 ) ObjectCreate(ChartID(),sparam+"-ShootingStar-333-"+t,OBJ_TREND,0,time1,Low[shift1]+((High[shift1]-Low[shift1])*x),Time[shift],price1+((High[shift1]-Low[shift1])*t));
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-333-"+t,OBJPROP_RAY,true);*/


}






//Alert("Selam",price2);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

double SS618=Low[shift1]+(((price2-Low[shift1])/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-618");
ObjectCreate(ChartID(),sparam+"-ShootingStar-618",OBJ_TREND,0,time1,SS618,time2,SS618);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-618",OBJPROP_BACK,true);

double SS382=Low[shift1]+(((price2-Low[shift1])/100)*38.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-382");
ObjectCreate(ChartID(),sparam+"-ShootingStar-382",OBJ_TREND,0,time1,SS382,time2,SS382);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-382",OBJPROP_BACK,true);

double SS500=Low[shift1]+(((price2-Low[shift1])/100)*50);
ObjectDelete(ChartID(),sparam+"-ShootingStar-500");
ObjectCreate(ChartID(),sparam+"-ShootingStar-500",OBJ_TREND,0,time1,SS500,time2,SS500);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_COLOR,clrLightBlue);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-500",OBJPROP_BACK,true);


double SS236=Low[shift1]+(((price2-Low[shift1])/100)*23.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-236");
ObjectCreate(ChartID(),sparam+"-ShootingStar-236",OBJ_TREND,0,time1,SS236,time2,SS236);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-236",OBJPROP_BACK,true);

double SS854=Low[shift1]+(((price2-Low[shift1])/100)*85.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-854");
ObjectCreate(ChartID(),sparam+"-ShootingStar-854",OBJ_TREND,0,time1,SS854,time2,SS854);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-854",OBJPROP_BACK,true);

double SS736=Low[shift1]+(((price2-Low[shift1])/100)*73.6);
ObjectDelete(ChartID(),sparam+"-ShootingStar-736");
ObjectCreate(ChartID(),sparam+"-ShootingStar-736",OBJ_TREND,0,time1,SS736,time2,SS736);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-736",OBJPROP_BACK,true);

double SS354=Low[shift1]+(((price2-Low[shift1])/100)*35.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-354");
ObjectCreate(ChartID(),sparam+"-ShootingStar-354",OBJ_TREND,0,time1,SS354,time2,SS354); // 236 + 118
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-354",OBJPROP_BACK,true);

double SS309=Low[shift1]+(((price2-Low[shift1])/100)*30.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-309");
ObjectCreate(ChartID(),sparam+"-ShootingStar-309",OBJ_TREND,0,time1,SS309,time2,SS309); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-309",OBJPROP_BACK,true);

double SS441=Low[shift1]+(((price2-Low[shift1])/100)*44.1);
ObjectDelete(ChartID(),sparam+"-ShootingStar-441");
ObjectCreate(ChartID(),sparam+"-ShootingStar-441",OBJ_TREND,0,time1,SS441,time2,SS441); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-441",OBJPROP_BACK,true);

double SS559=Low[shift1]+(((price2-Low[shift1])/100)*55.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-559");
ObjectCreate(ChartID(),sparam+"-ShootingStar-559",OBJ_TREND,0,time1,SS559,time2,SS559); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-559",OBJPROP_BACK,true);

double SS677=Low[shift1]+(((price2-Low[shift1])/100)*67.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-677");
ObjectCreate(ChartID(),sparam+"-ShootingStar-677",OBJ_TREND,0,time1,SS677,time2,SS677); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-677",OBJPROP_BACK,true);

double SS795=Low[shift1]+(((price2-Low[shift1])/100)*79.5);
ObjectDelete(ChartID(),sparam+"-ShootingStar-795");
ObjectCreate(ChartID(),sparam+"-ShootingStar-795",OBJ_TREND,0,time1,SS795,time2,SS795); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-795",OBJPROP_BACK,true);

double SS913=Low[shift1]+(((price2-Low[shift1])/100)*91.3);
ObjectDelete(ChartID(),sparam+"-ShootingStar-913");
ObjectCreate(ChartID(),sparam+"-ShootingStar-913",OBJ_TREND,0,time1,SS913,time2,SS913); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-913",OBJPROP_BACK,true);

//
double SS177=Low[shift1]+(((price2-Low[shift1])/100)*17.7);
ObjectDelete(ChartID(),sparam+"-ShootingStar-177");
ObjectCreate(ChartID(),sparam+"-ShootingStar-177",OBJ_TREND,0,time1,SS177,time2,SS177); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-177",OBJPROP_BACK,true);
//ObjectSetString(ChartID(),sparam+"-ShootingStar-177",OBJPROP_TOOLTIP,"Deneme");

double SS118f=Low[shift1]+(((price2-Low[shift1])/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-118f");
ObjectCreate(ChartID(),sparam+"-ShootingStar-118f",OBJ_TREND,0,time1,SS118f,time2,SS118f); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-118f",OBJPROP_BACK,true);

double SS59=Low[shift1]+(((price2-Low[shift1])/100)*5.9);
ObjectDelete(ChartID(),sparam+"-ShootingStar-59");
ObjectCreate(ChartID(),sparam+"-ShootingStar-59",OBJ_TREND,0,time1,SS59,time2,SS59); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-59",OBJPROP_BACK,true);

////////////////////////////////////////////////////////////////////////////////////

double SS1272=Low[shift1]+(((price2-Low[shift1])/100)*127.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272",OBJ_TREND,0,time1,SS1272,time2,SS1272); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272",OBJPROP_BACK,true);

double SS1118=Low[shift1]+(((price2-Low[shift1])/100)*111.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118",OBJPROP_BACK,true);

double SS1414=Low[shift1]+(((price2-Low[shift1])/100)*141.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414",OBJ_TREND,0,time1,SS1414,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414",OBJPROP_BACK,true);

double SS1618=Low[shift1]+(((price2-Low[shift1])/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618",OBJPROP_BACK,true);

double SS2618=Low[shift1]+(((price2-Low[shift1])/100)*261.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618",OBJ_TREND,0,time1,SS2618,time2,SS2618); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618",OBJPROP_BACK,true);

//////////////////////////////////////////////////////////

double SS1272n=Low[shift1]-(((price2-Low[shift1])/100)*27.2);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1272n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1272n",OBJ_TREND,0,time1,SS1272n,time2,SS1272n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1272n",OBJPROP_BACK,true);

double SS1118n=Low[shift1]-(((price2-Low[shift1])/100)*11.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1118n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1118",OBJ_TREND,0,time1,SS1118,time2,SS1118); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1118n",OBJ_TREND,0,time1,SS1118n,time2,SS1118n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1118n",OBJPROP_BACK,true);

double SS1414n=Low[shift1]-(((price2-Low[shift1])/100)*41.4);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1414n");
ObjectCreate(ChartID(),sparam+"-ShootingStar-1414n",OBJ_TREND,0,time1,SS1414n,time2,SS1414n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1414n",OBJPROP_BACK,true);

double SS1618n=Low[shift1]-(((price2-Low[shift1])/100)*61.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-1618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-1618n",OBJ_TREND,0,time1,SS1618n,time2,SS1618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-1618n",OBJPROP_BACK,true);

double SS2618n=Low[shift1]-(((price2-Low[shift1])/100)*161.8);
ObjectDelete(ChartID(),sparam+"-ShootingStar-2618n");
//ObjectCreate(ChartID(),sparam+"-ShootingStar-1618",OBJ_TREND,0,time1,SS1618,time2,SS1414); // (382-236)=146/2=73 + 236=
ObjectCreate(ChartID(),sparam+"-ShootingStar-2618n",OBJ_TREND,0,time1,SS2618n,time2,SS2618n); // (382-236)=146/2=73 + 236=
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),sparam+"-ShootingStar-2618n",OBJPROP_BACK,true);



//Comment("Evet");

// 1.618 .1414 1.118 1.272


double SS842=High[shift2]-(((price2-price1)/100)*84.2);

namel=sparam+"-ShootingStar-842";

if ( mod_change ) namel=sparam+"-ShootingStar-842-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS842,time2+PeriodSeconds()*11,SS842);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);




double SS864=High[shift2]-(((price2-price1)/100)*86.4);

namel=sparam+"-ShootingStar-864";

if ( mod_change ) namel=sparam+"-ShootingStar-864-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS864,time2+PeriodSeconds()*11,SS864);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);


double SS827=High[shift2]-(((price2-price1)/100)*87.6);

namel=sparam+"-ShootingStar-827";

if ( mod_change ) namel=sparam+"-ShootingStar-827-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS827,time2+PeriodSeconds()*11,SS827);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetInteger(ChartID(),sparam+"-ShootingStar-827",OBJPROP_RAY,false);


double SS886=High[shift2]-(((price2-price1)/100)*88.6);

namel=sparam+"-ShootingStar-886";



if ( mod_change ) namel=sparam+"-ShootingStar-886-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS886,time2,SS886);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,colorLawGreen);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);
//ObjectSetString(ChartID(),namel,OBJPROP_TOOLTIP,"Deneme");



double SS786=High[shift2]-(((price2-price1)/100)*78.6);

namel=sparam+"-ShootingStar-786";

if ( mod_change ) namel=sparam+"-ShootingStar-786-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS786,time2,SS786);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,4);





double SS707=High[shift2]-(((price2-price1)/100)*70.7);

namel=sparam+"-ShootingStar-707";

if ( mod_change ) namel=sparam+"-ShootingStar-707-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS707,time2,SS707);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);

double SS764=High[shift2]-(((price2-price1)/100)*76.4);

namel=sparam+"-ShootingStar-764";

if ( mod_change ) namel=sparam+"-ShootingStar-764-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS764,time2,SS764);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,3);






/*
double SS707n=SS886+(SS842-SS707);

namel=sparam+"-ShootingStar-707n";

//if ( mod_change ) namel=sparam+"-ShootingStar-707-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS707n,time2,SS707n);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrGoldenrod);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,2);


double SS786n=SS886+(SS842-SS786);

namel=sparam+"-ShootingStar-786n";

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS786n,time2,SS786n);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,4);

double SS764n=SS886+(SS842-SS764);

namel=sparam+"-ShootingStar-764n";

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time1,SS764n,time2,SS764n);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,3);


Alert("Selam");*/








int spread=(MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID))/Point;
int fark = int((SS764-SS886)/Point);

//Comment("Pip:",fark,"/",spread,"=",fark/spread,"/",(fark-spread));
Comment("Pip:",fark,"/",spread,"/",(fark-spread));




//Alert("Selam2","/",shift886);

int shiftc=1;
if ( shift1 > 1000 ) {

int shift886=ObjectGetShiftByValue(sparam+"-ShootingStar-666", SS886);
//Alert(shift886);
ObjectDelete(ChartID(),sparam+"CONTROL");
if ( shift886 > 0 ) ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,Time[shift886],SS886);
if ( shift886 < -0 ) {
datetime ctime=Time[0]+MathAbs(shift886)*PeriodSeconds();
ObjectCreate(ChartID(),sparam+"CONTROL",OBJ_VLINE,0,ctime,SS886);
}

shiftc=shift1-((shift1-shift886)*2);
if ( shiftc < 0 ) shiftc=1;
} 


for(int c=shiftc;c<=shift1-10;c++){

ObjectDelete(ChartID(),sparam+"CONTROL"+c);

if ( Low[c] <= SS886 && Open[c] > SS886 ) {

      ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_ARROW,0,0,0,0,0);          // Create an arrow
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ARROWCODE,108);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_TIME,Time[c]);        // Set timeOrderTime+40*PeriodSeconds()
      ObjectSetDouble(ChartID(),sparam+"CONTROL"+c,OBJPROP_PRICE,Low[c]);// Set price
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_ANCHOR,ANCHOR_LOWER);    // Set the arrow code
      ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_FONTSIZE,8); 
      //ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrBlack);


//ObjectCreate(ChartID(),sparam+"CONTROL"+c,OBJ_VLINE,0,Time[c],Close[c]);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_WIDTH,3);
ObjectSetInteger(ChartID(),sparam+"CONTROL"+c,OBJPROP_COLOR,clrDarkGray);
}

//Print(c);

}






//if ( order_mode == true ) {
if ( cs_islem == "ORDER" ) {

string ordercmt="";


order1=NormalizeDouble(SS886,Digits);
order2=NormalizeDouble(High[shift1],Digits);
tp=NormalizeDouble(SS764,Digits);
tp1=NormalizeDouble(SS764,Digits);
tp3=NormalizeDouble(SS618,Digits);
sl=NormalizeDouble(Low[shift1],Digits);

ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-1";
int ticket=OrderSend(Symbol(),OP_BUYLIMIT,wlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

tp=NormalizeDouble(SS786,Digits);
tp2=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-2";
int ticket2=OrderSend(Symbol(),OP_BUYLIMIT,wlot,order2,0,sl,tp,ordercmt,0,0,clrNONE);

order3=NormalizeDouble(SS864,Digits);
//tp=NormalizeDouble(SS786,Digits);
ordercmt=Symbol()+"-"+sparam+"-"+TFtoStr(Period())+"-3";
int ticket3=OrderSend(Symbol(),OP_BUYLIMIT,wlot,order1,0,sl,tp,ordercmt,0,0,clrNONE);

order_type=OP_BUYLIMIT;
//order_mode=false;

}



double SS118=High[shift2]-(((price2-price1)/100)*11.8);

namel=sparam+"-ShootingStar-118";

if ( mod_change ) namel=sparam+"-ShootingStar-118-"+mod_prices;

ObjectDelete(ChartID(),namel);
ObjectCreate(ChartID(),namel,OBJ_TREND,0,time2,SS118,time2+PeriodSeconds()*11,SS118);
ObjectSetInteger(ChartID(),namel,OBJPROP_COLOR,clrBisque);
ObjectSetInteger(ChartID(),namel,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),namel,OBJPROP_STYLE,0);
ObjectSetInteger(ChartID(),namel,OBJPROP_BACK,true);


ChartRedraw();


}
ToplamObje=ObjectsTotal();

//Alert("Selam");
GizleGoster(16);

}
}

/////////////////////////////////////////////////////////////////////////




void GizleGoster(int islem) {



if ( islem == 33 ) {
             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int object_len=StringLen(name);

  if ( index != -1 && last_object_len != object_len) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     //if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     //ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     //} else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     //}  
  
   }  
   
}   
}










if ( islem == 34 ) {
             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int object_len=StringLen(name);

  if ( index != -1 && last_object_len != object_len) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   
}



if ( islem == 35 ) {
             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index333 = StringFind(name,"-333-", 0); 
  int index1333 = StringFind(name,"-1333-", 0); 
  
  int index222 = StringFind(name,"-222-", 0); 
  int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);

  //if ( index != -1 && last_object_len != object_len && ( index333 != -1 || index222 != -1 ) ) {
  if ( index != -1 && last_object_len != object_len && ( index222 != -1 ) ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   
}





if ( islem == 36 ) {


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index333 = StringFind(name,"-333-", 0); 
  int index1333 = StringFind(name,"-1333-", 0); 
  
  int index222 = StringFind(name,"-222-", 0); 
  int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1
  //if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len && ( index333 != -1   ) ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   
}



if ( islem == 37 ) {


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index333 = StringFind(name,"-333-", 0); 
  int index1333 = StringFind(name,"-1333-", 0); 
  
  int index222 = StringFind(name,"-222-", 0); 
  int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1
//if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len && index1222 != -1    ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   
}





if ( islem == 38 ) { ///ş


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  int index333 = StringFind(name,"-333-", 0); 
  int index1333 = StringFind(name,"-1333-", 0); 
  
  int index222 = StringFind(name,"-222-", 0); 
  int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1
  //if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len && index1333 != -1  ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
  
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
  
   }  
   
}   



}









if ( islem == 16 ) { ///ş

//Alert("Q");

//string to_split="-707,-786,-764,-618,-886,-864,-827,-888";


             int obj_total=ObjectsTotal()-1;
    for(int i=ObjectsTotal();i>=0;i--)
        {
        
        string sparam = ObjectName(i);
        string name = ObjectName(i);


  int index = StringFind(name,last_object, 0); 
  int last_object_len=StringLen(last_object);
  
  
/*
string sep=",";                // A separator as a character
   ushort u_sep;                  // The code of the separator character
   string results[];               // An array to get strings
   //--- Get the separator code
   u_sep=StringGetCharacter(sep,0);
   //--- Split the string to substrings
   int k=StringSplit(to_split,u_sep,results);
   //--- Show a comment 
   //PrintFormat("Strings obtained: %d. Used separator '%s' with the code %d",k,sep,u_sep);
   //--- Now output all obtained strings
   //Print("Destek Direnc Web Load 3:",k);
   
   //int DDsays=-1;
   //int DDtoplam=-1;
   
   bool linebul=false;
   string linename="";
   
   if(k>0)
     {
      for(int i=0;i<k;i++)
        {

   linename=results[i];

   int index_split = StringFind(name,linename, 0);         

   if ( index_split != -1 ) {
   linebul=true;
   }        
        
        Print(results[i]);

   
   }
  }*/
  
  
  
  
  //int index333 = StringFind(name,"-333-", 0); 
  //int index1333 = StringFind(name,"-1333-", 0); 
  
  //int index222 = StringFind(name,"-222-", 0); 
  //int index1222 = StringFind(name,"-1222-", 0); 
  
  
  int object_len=StringLen(name);
//|| index333 != -1 || index222 != -1&& index1333 != -1
  //if ( index != -1 && last_object_len != object_len && ( index1333 != -1 || index1222 != -1   ) ) {
  if ( index != -1 && last_object_len != object_len   ) {
  //Sleep(100);
  //ObjectDelete(ChartID(),name);
     
     if ( ObjectGetInteger(0,name, OBJPROP_TIMEFRAMES) == -1 && (ObjectGetInteger(0,name,OBJPROP_COLOR) == clrLightGray || ObjectGetInteger(0,name,OBJPROP_COLOR) == clrNavy) //&& linebul == true
      ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, OBJ_PERIOD_M1 | OBJ_PERIOD_M5 | OBJ_PERIOD_M15 | OBJ_PERIOD_M30 | OBJ_PERIOD_H1 | OBJ_PERIOD_H4 | OBJ_PERIOD_D1 | OBJ_PERIOD_W1 | OBJ_PERIOD_MN1);
     } else {
     if ( //linebul == false
     //ObjectGetInteger(0,name,OBJPROP_COLOR) == clrLightGray
     (ObjectGetInteger(0,name,OBJPROP_COLOR) == clrLightGray || ObjectGetInteger(0,name,OBJPROP_COLOR) == clrNavy)
      ) {
     ObjectSetInteger(0,name, OBJPROP_TIMEFRAMES, -1);
     }  
     }
  
   }  
   
}   



}





}   
   
   

bool LINE_SYSTEM=false;
bool BAR_SYSTEM=false;


color colorLawGreen=clrBlack;  
bool TRADE_LEVELS=true;
bool Chart_Forward = false;
 bool Chart_Rewind = false;
    int Chart_Pos = -1;
long currChart=ChartID();


int ToplamObje=ObjectsTotal();

extern color yazirenk_ust = clrBlack;
extern color yazirenk = clrLightGreen;

int scale=ChartGetInteger(ChartID(),CHART_SCALE); 

string mod_type = "";
double mod_price = -1;
double mod_prices = -1;
double last_mod_prices = -1;
bool mod_change=false;   
bool multi_mod=false;

string last_mode_vline="";
datetime last_mode_vline_time;
double last_mode_vline_price=-1;
int last_mode_vline_shift=-1;

double order1,order2,order3,sl,tp,tp1,tp2,tp3,order_type;

bool order_mode=false;

//long chart_active = ChartID();

bool onscreen=true; 

string last_select_object = "";
bool chartonscreen=true;

double SSSL=-1;   


string wtime1="";
string wtime2="";
int wper=-1;
string wsym="";
string wislem="";
double wlot=0.01;
int wscale=1;

string last_object="";  
int objtotal = ObjectsTotal();

//////////////////////////////////////////////////////////////////////
string TFtoStr(int period) {
 switch(period) {
  case 1     : return("M1");  break;
  case 5     : return("M5");  break;
  case 15    : return("M15"); break;
  case 30    : return("M30"); break;
  case 60    : return("H1");  break;
  case 240   : return("H4");  break;
  case 1440  : return("D1");  break;
  case 10080 : return("W1");  break;
  case 43200 : return("MN1"); break;
  default    : return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader



void Swing() {


   ObjectsDeleteAll();
   
   int bar_say=0;
   int bar_left=0;
   int bar_right=0;
   //WindowFirstVisibleBar()
   
   
   if ( swinghighs == true ) {
  
   for (int i=1000;i>=15;i--){
   
   //Print(i);
   
   swing_high=High[i];
   swing_high_time=Time[i];
   bool left_flag=true;
   bool right_flag=true;
   
   //if ( High[i] > swing_high ) {
   
   
   for(int e=i-1;e>=i-11;e--){
   
   //Print(i,"/",e);
   //if ( Close[e] < swing_high ) bar_say=bar_say+1;
   if ( Close[e] < swing_high ) bar_right=bar_right+1;
   if ( Close[e] > swing_high ) right_flag=false;
   if ( High[e] > swing_high ) right_flag=false;
   
   }
   

   for(int w=i+1;w<=i+11;w++){
   
   //Print(i,"/",w);
   //if ( Close[e] < swing_high ) bar_say=bar_say+1;
   if ( Close[w] < swing_high ) bar_left=bar_left+1;
   if ( Close[w] > swing_high ) left_flag=false;
   if ( High[w] > swing_high ) left_flag=false;
   
   }
      
   
   
   
   if ( bar_right >= 9 && bar_left >= 3  && right_flag == true && left_flag == true) {
   
   string name="SWHIGH"+i;
   ObjectCreate(ChartID(),"SWHIGH"+i,OBJ_TREND,0,swing_high_time,swing_high,swing_high_time+100*PeriodSeconds(),swing_high);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY_RIGHT,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrGold);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   if ( space == true ) {
   if ( last_swing_high != -1 && ( ( updown == true && last_swing_high < swing_high ) || ( updown == false  && last_swing_high > swing_high ) )) {

   string name="SWHIGHSPACE"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,swing_high_time,swing_high,last_swing_high_time,last_swing_high);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY_RIGHT,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrYellow);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  

   name="SWHIGHSPACELINE"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,last_swing_high_time,last_swing_high,swing_high_time,swing_high);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY_RIGHT,true);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);  
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);  
       
   
   }
   }
   
   last_swing_high=swing_high;
   last_swing_high_time=swing_high_time; 
      
   
   
   swing_high=-1;
   bar_say=0;
   bar_left=0;
   bar_right=0;
   
   }   else {
   swing_high=-1;
   bar_say=0;
   bar_left=0;
   bar_right=0;
   }
   
   
   
   //}
   

   

   



   }
   
   }
   
   
   if ( swinglows == true ) {
   
   
   bar_say=0;
   bar_left=0;
   bar_right=0;
   

for (int i=1000;i>=15;i--){
   
   //Print(i);
   
   swing_low=Low[i];
   swing_low_time=Time[i];
   bool left_flag=true;
   bool right_flag=true;
   
   //if ( High[i] > swing_high ) {
   
   
   for(int e=i-1;e>=i-11;e--){
   
   //Print(i,"/",e);
   //if ( Close[e] < swing_high ) bar_say=bar_say+1;
   if ( Close[e] > swing_low ) bar_right=bar_right+1;
   if ( Close[e] < swing_low ) right_flag=false;
   if ( Low[e] < swing_low ) right_flag=false;
   
   }
   

   for(int w=i+1;w<=i+11;w++){
   
   //Print(i,"/",w);
   //if ( Close[e] < swing_high ) bar_say=bar_say+1;
   if ( Close[w] > swing_low ) bar_left=bar_left+1;
   if ( Close[w] < swing_low ) left_flag=false;
   if ( Low[w] < swing_low ) left_flag=false;
   
   }
      
   
   
   
   if ( bar_right >= 9 && bar_left >= 3  && right_flag == true && left_flag == true) {
   
   string name="SWLOW"+i;
   ObjectCreate(ChartID(),"SWLOW"+i,OBJ_TREND,0,swing_low_time,swing_low,swing_low_time+100*PeriodSeconds(),swing_low);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY_RIGHT,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   
   if ( space == true ) {
  if ( last_swing_low != 100000000 && ( ( updown == true && swing_low > last_swing_low ) || ( updown == false  && swing_low < last_swing_low ) )) {

   string name="SWLOWSPACE"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,swing_low_time,swing_low,last_swing_low_time,last_swing_low);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY_RIGHT,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrYellow);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  

   name="SWLOWSPACELINE"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,last_swing_low_time,last_swing_low,swing_low_time,swing_low);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY_RIGHT,true);   
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);  
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);  
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);  
       
   
   }
   }
   
   
   last_swing_low=swing_low;
   last_swing_low_time=swing_low_time;   
   
   swing_low=100000000;
   bar_say=0;
   bar_left=0;
   bar_right=0;

   
   }   else {
   swing_low=100000000;
   bar_say=0;
   bar_left=0;
   bar_right=0;
   }
   
 

   }
////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////   

for (int i=1000;i>=15;i--){


string nameh="SWHIGH"+i;

bool find_high_low = false;

if ( ObjectFind(ChartID(),nameh) != -1 ) {

//ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],0);


for (int e=i;e>=15;e--){

string namel="SWLOW"+e;

if ( find_high_low == false ) {
if ( ObjectFind(ChartID(),namel) != -1 ) {
//ObjectCreate(ChartID(),"VLINE"+e,OBJ_VLINE,0,Time[e],0);
if ( Low[i] > Low[e] ) ObjectCreate(ChartID(),i+"TRENDHL"+e,OBJ_TREND,0,Time[i],High[i],Time[e],Low[e]);
if ( Low[i] < Low[e] ) ObjectCreate(ChartID(),i+"TRENDHL"+e,OBJ_TREND,0,Time[i],Low[i],Time[e],Low[e]);
ObjectCreate(ChartID(),i+"TRENDHL"+e,OBJ_TREND,0,Time[i],Low[i],Time[e],Low[e]);
ObjectSetInteger(ChartID(),i+"TRENDHL"+e,OBJPROP_RAY_RIGHT,false);
ObjectSetInteger(ChartID(),i+"TRENDHL"+e,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),i+"TRENDHL"+e,OBJPROP_WIDTH,1);
ObjectSetString(ChartID(),i+"TRENDHL"+e,OBJPROP_TOOLTIP,"Gray"+TimeToStr(Time[i],TIME_DATE|TIME_SECONDS));
find_high_low = true;
}
}




}


}


}      
     
     

for (int i=1000;i>=15;i--){



string namel="SWLOW"+i;

bool find_low_high = false;

if ( ObjectFind(ChartID(),namel) != -1 ) {

//ObjectCreate(ChartID(),"VLINE"+i,OBJ_VLINE,0,Time[i],0);


for (int e=i;e>=15;e--){

string nameh="SWHIGH"+e;

if ( find_low_high == false ) {
if ( ObjectFind(ChartID(),nameh) != -1 ) {
//ObjectCreate(ChartID(),"VLINE"+e,OBJ_VLINE,0,Time[e],0);
if ( High[i] > High[e] ) ObjectCreate(ChartID(),i+"TRENDLH"+e,OBJ_TREND,0,Time[i],Low[i],Time[e],High[e]);
if ( High[i] < High[e] ) ObjectCreate(ChartID(),i+"TRENDLH"+e,OBJ_TREND,0,Time[i],Low[i],Time[e],High[e]);
ObjectCreate(ChartID(),i+"TRENDLH"+e,OBJ_TREND,0,Time[i],High[i],Time[e],High[e]);
ObjectSetInteger(ChartID(),i+"TRENDLH"+e,OBJPROP_RAY_RIGHT,false);
ObjectSetInteger(ChartID(),i+"TRENDLH"+e,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),i+"TRENDLH"+e,OBJPROP_WIDTH,1);
ObjectSetString(ChartID(),i+"TRENDLH"+e,OBJPROP_TOOLTIP,"Green"+TimeToStr(Time[i],TIME_DATE|TIME_SECONDS));
find_low_high = true;
}
}




}


}


}      
      










     
     
      
      /*
    int obj_total=ObjectsTotal()-1;
  string name;
  for(int i=ObjectsTotal();i>=0;i--)
    {
     name = ObjectName(i);
     
     
     Print(name);
     
     
     }*/
        

}
        
}



void abcdEngine() {


      
    int obj_total=ObjectsTotal()-1;
  string sparams;
  for(int i=ObjectsTotal();i>=0;i--)
    {
     sparams = ObjectName(i);
     
     //Print(sparams);
     
  double price1=ObjectGetDouble(ChartID(),sparams,OBJPROP_PRICE,0);
  double price2=ObjectGetDouble(ChartID(),sparams,OBJPROP_PRICE,1);
  
  double time1=ObjectGetInteger(ChartID(),sparams,OBJPROP_TIME,0);
  double time2=ObjectGetInteger(ChartID(),sparams,OBJPROP_TIME,1);
  
  color colors=ObjectGetInteger(ChartID(),sparams,OBJPROP_COLOR);
  
  int shift1=iBarShift(Symbol(),Period(),time1);
  int shift2=iBarShift(Symbol(),Period(),time2);
  
  
  
  if ( colors == clrLightGreen ) {
  
  //ObjectSetString(ChartID(),sparams,OBJPROP_TOOLTIP,"Green"+time1);
  
  abcdEngineSearch(colors,price1,price2,shift1,shift2,time1,time2);
  
  }
  
  if ( colors == clrLightGray ) {
  
  //ObjectSetString(ChartID(),sparams,OBJPROP_TOOLTIP,"Gray"+time1);
  
  abcdEngineSearch(colors,price1,price2,shift1,shift2,time1,time2);
  
  }
  
     
     //Print(name);
     
     
     }


}



void abcdEngineSearch(color obj_color,double obj_prc1,double obj_prc2,int obj_shift1,int obj_shift2,datetime obj_time1,datetime obj_time2) {


      
    int obj_total=ObjectsTotal()-1;
  string sparamss;
  for(int i=ObjectsTotal();i>=0;i--)
    {
     sparamss = ObjectName(i);
     
  double price1s=ObjectGetDouble(ChartID(),sparamss,OBJPROP_PRICE,0);
  double price2s=ObjectGetDouble(ChartID(),sparamss,OBJPROP_PRICE,1);
  
  double time1s=ObjectGetInteger(ChartID(),sparamss,OBJPROP_TIME,0);
  double time2s=ObjectGetInteger(ChartID(),sparamss,OBJPROP_TIME,1);
  
  color colorss=ObjectGetInteger(ChartID(),sparamss,OBJPROP_COLOR);
  
  int shift1s=iBarShift(Symbol(),Period(),time1s);
  int shift2s=iBarShift(Symbol(),Period(),time2s);



  if ( obj_color == clrLightGreen && colorss == clrLightGray  ) {
  
  //ObjectSetString(ChartID(),sparamss,OBJPROP_TOOLTIP,"Green"+obj_time1);
  //ObjectSetString(ChartID(),sparamss,OBJPROP_TOOLTIP,"Gray"+obj_time1);
  
  
  
  if ( obj_prc2 == price1s && price2s > obj_prc1) {
  
   double high_price=obj_prc2; 
   double low_price=obj_prc1;

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   
   
   if ( DivZero(price1s-price2s,yuzde) >= 38.2 &&  DivZero(price1s-price2s,yuzde) <= 88.6 ) {
   
   int shift_fark=(obj_shift1-obj_shift2);
 
   //ObjectCreate(ChartID(),"ABCD-Line"+shift1s,OBJ_VLINE,0,time2s,Ask);

   ObjectCreate(ChartID(),"ABCD-Line"+shift1s,OBJ_TREND,0,time2s,price2s,time2s+(shift_fark)*PeriodSeconds(),price2s+yuzde*100);
   ObjectSetInteger(ChartID(),"ABCD-Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-Line"+shift1s,OBJPROP_COLOR,clrDarkGray);
   ObjectSetInteger(ChartID(),"ABCD-Line"+shift1s,OBJPROP_WIDTH,1);
    ObjectSetString(ChartID(),"ABCD-Line"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
   

   ObjectCreate(ChartID(),"ABCD-1Line"+shift1s,OBJ_TREND,0,time1s,price1s,time2s+(shift_fark)*PeriodSeconds(),price2s+yuzde*100);
   ObjectSetInteger(ChartID(),"ABCD-1Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-1Line"+shift1s,OBJPROP_COLOR,clrDarkGray);
    ObjectSetString(ChartID(),"ABCD-1Line"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
    /*
   ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time1s,price2s+yuzde*100,time2s+(shift_fark)*PeriodSeconds(),price2s+yuzde*100);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_COLOR,clrDarkGray);
   ObjectSetString(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_WIDTH,2);     */
   
   
   /*
   double yuzdes=DivZero((price2s-obj_prc1),100);

   ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time2s+(shift_fark)*PeriodSeconds(),price2s+(yuzdes*161.8),time2s+(150)*PeriodSeconds(),price2s+(yuzdes*161.8));
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_COLOR,clrYellow);
   ObjectSetString(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_WIDTH,1);     
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_STYLE,STYLE_DOT); */
   
   //int shift_obj1=iBarShift(Symbol(),Period(),obj_time1);
   
   double lprice=price2s;
   double hprice=(price2s+yuzde*100);
   double yuzdes=DivZero((hprice-lprice),100);
   //sinyal_level=80.0;
   double sinyal_price=price2s+(yuzdes*sinyal_level);

   //ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time2s,price1s-(yuzdes*sinyal_level),time2s+(150)*PeriodSeconds(),price1s-(yuzdes*sinyal_level));
   //ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time2s,price1s,time2s+(150)*PeriodSeconds(),price1s);
   ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time2s,sinyal_price,time2s+(150)*PeriodSeconds(),sinyal_price);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_COLOR,clrYellow);
   ObjectSetString(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_WIDTH,2);     
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_STYLE,STYLE_DOT); 
   
   
   
   
   
   ObjectCreate(ChartID(),"ABCD-2Line"+shift1s,OBJ_TREND,0,obj_time1,obj_prc1,time2s,price2s);
   ObjectSetInteger(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_COLOR,clrDarkGray);
    ObjectSetString(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
    ObjectSetInteger(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_WIDTH,1);
    ObjectSetInteger(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_STYLE,STYLE_DOT);
    
   ObjectCreate(ChartID(),"ABCD-3Line"+shift1s,OBJ_TREND,0,time1s,price1s,time2s,price2s);
   ObjectSetInteger(ChartID(),"ABCD-3Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-3Line"+shift1s,OBJPROP_COLOR,clrDarkGreen);
   ObjectSetString(ChartID(),"ABCD-3Line"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);    
   
   
   ObjectCreate(ChartID(),"ABCD-LineA"+shift1s,OBJ_TEXT,0,obj_time1,obj_prc1);
   ObjectSetInteger(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_TEXT,"A");
   ObjectSetInteger(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_FONTSIZE,16);
    ObjectSetString(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
   
   ObjectCreate(ChartID(),"ABCD-LineB"+shift1s,OBJ_TEXT,0,obj_time2,obj_prc2);
   ObjectSetInteger(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_TEXT,"B");
   ObjectSetInteger(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_FONTSIZE,16);
    ObjectSetString(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
   
   ObjectCreate(ChartID(),"ABCD-LineC"+shift1s,OBJ_TEXT,0,time2s,price2s);
   ObjectSetInteger(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_TEXT,"C");
   ObjectSetInteger(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_FONTSIZE,16);
    ObjectSetString(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);

   ObjectCreate(ChartID(),"ABCD-LineF"+shift1s,OBJ_TEXT,0,time2s,price2s);
   ObjectSetInteger(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_TEXT,DoubleToString(DivZero(price1s-price2s,yuzde),2));
   ObjectSetInteger(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_FONTSIZE,11);
    ObjectSetString(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
      
   
   ObjectCreate(ChartID(),"ABCD-LineD"+shift1s,OBJ_TEXT,0,time2s+(shift_fark)*PeriodSeconds(),price2s+yuzde*100);
   ObjectSetInteger(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_TEXT,"D");
   ObjectSetInteger(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_FONTSIZE,16);
    ObjectSetString(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_TOOLTIP,"Green"+obj_time1);
 
   
      
   
   }

   
  
  }
  
  }
  

  
  if ( obj_color == clrLightGray && colorss == clrLightGreen) {
  
    
     //ObjectSetString(ChartID(),sparamss,OBJPROP_TOOLTIP,"Green"+obj_time1);
  
   double high_price=obj_prc1; 
   double low_price=obj_prc2;

   double yuzde = DivZero(high_price-low_price, 100);
   
   
 
   if ( obj_prc2 == price1s && price2s < obj_prc1  ) {
  
  
    if ( DivZero(price2s-price1s,yuzde) >= 38.2 && DivZero(price2s-price1s,yuzde) <= 88.6 ) {
   
   int shift_fark=(obj_shift1-obj_shift2);
   
   //ObjectCreate(ChartID(),"ABCD-Line"+shift1s,OBJ_VLINE,0,time2s,Ask);
   ObjectCreate(ChartID(),"ABCD-Line"+shift1s,OBJ_TREND,0,time2s,price2s,time2s+(shift_fark)*PeriodSeconds(),price2s-(yuzde*100));
   ObjectSetInteger(ChartID(),"ABCD-Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-Line"+shift1s,OBJPROP_COLOR,clrDarkGreen);
   ObjectSetString(ChartID(),"ABCD-Line"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
 
   ObjectCreate(ChartID(),"ABCD-1Line"+shift1s,OBJ_TREND,0,time1s,price1s,time2s+(shift_fark)*PeriodSeconds(),price2s-(yuzde*100));
   ObjectSetInteger(ChartID(),"ABCD-1Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-1Line"+shift1s,OBJPROP_COLOR,clrDarkGreen);
    ObjectSetString(ChartID(),"ABCD-1Line"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
   
   ObjectCreate(ChartID(),"ABCD-2Line"+shift1s,OBJ_TREND,0,obj_time1,obj_prc1,time2s,price2s);
   ObjectSetInteger(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_COLOR,clrDarkGreen);
   ObjectSetString(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
   //ObjectSetInteger(ChartID(),"ABCD-2Line"+shift1s,OBJPROP_WIDTH,4);


   ObjectCreate(ChartID(),"ABCD-3Line"+shift1s,OBJ_TREND,0,time1s,price1s,time2s,price2s);
   ObjectSetInteger(ChartID(),"ABCD-3Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-3Line"+shift1s,OBJPROP_COLOR,clrDarkGreen);
   ObjectSetString(ChartID(),"ABCD-3Line"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
   /*
   double yuzdes=DivZero((obj_prc1-price2s),100);

   ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time2s+(0)*PeriodSeconds(),price2s-(yuzdes*161.8),time2s+(150)*PeriodSeconds(),price2s-(yuzdes*161.8));
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_COLOR,clrYellow);
   ObjectSetString(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_WIDTH,1);     
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_STYLE,STYLE_DOT); */
   
   double hprice=price1s;
   double lprice=(price2s-yuzde*100);
   double yuzdes=DivZero((hprice-lprice),100);
   //sinyal_level=80.0;
   double sinyal_price=price1s-(yuzdes*sinyal_level);

   //ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time2s,price1s-(yuzdes*sinyal_level),time2s+(150)*PeriodSeconds(),price1s-(yuzdes*sinyal_level));
   //ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time2s,price1s,time2s+(150)*PeriodSeconds(),price1s);
   ObjectCreate(ChartID(),"ABCD-4Line"+shift1s,OBJ_TREND,0,time2s,sinyal_price,time2s+(150)*PeriodSeconds(),sinyal_price);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_COLOR,clrYellow);
   ObjectSetString(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_WIDTH,2);     
   ObjectSetInteger(ChartID(),"ABCD-4Line"+shift1s,OBJPROP_STYLE,STYLE_DOT); 
   
   
      
   
    ObjectCreate(ChartID(),"ABCD-LineA"+shift1s,OBJ_TEXT,0,obj_time1,obj_prc1);
   ObjectSetInteger(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_TEXT,"A");
   ObjectSetInteger(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_FONTSIZE,16);
   ObjectSetString(ChartID(),"ABCD-LineA"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
   
   ObjectCreate(ChartID(),"ABCD-LineB"+shift1s,OBJ_TEXT,0,obj_time2,obj_prc2);
   ObjectSetInteger(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_TEXT,"B");
   ObjectSetInteger(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_FONTSIZE,16);
   ObjectSetString(ChartID(),"ABCD-LineB"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
   
   ObjectCreate(ChartID(),"ABCD-LineC"+shift1s,OBJ_TEXT,0,time2s,price2s);
   ObjectSetInteger(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_TEXT,"C");
   ObjectSetInteger(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_FONTSIZE,16);
    ObjectSetString(ChartID(),"ABCD-LineC"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
   
   ObjectCreate(ChartID(),"ABCD-LineD"+shift1s,OBJ_TEXT,0,time2s+(shift_fark)*PeriodSeconds(),price2s-yuzde*100);
   ObjectSetInteger(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_TEXT,"D");
   ObjectSetInteger(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_FONTSIZE,16);
   ObjectSetString(ChartID(),"ABCD-LineD"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);   
      
   ObjectCreate(ChartID(),"ABCD-LineF"+shift1s,OBJ_TEXT,0,time2s,price2s);
   ObjectSetInteger(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_TEXT,DoubleToString(DivZero(price2s-price1s,yuzde),2));
   ObjectSetInteger(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_FONTSIZE,11);
   ObjectSetString(ChartID(),"ABCD-LineF"+shift1s,OBJPROP_TOOLTIP,"Gray"+obj_time1);
      
   }
   
  
  }
  
  }
  

     
     //Print(name);
     
     
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


void WorkEngine() {



    int obj_total=ObjectsTotal()-1;
  string namew;
  for(int i=ObjectsTotal();i>=0;i--)
    {
     namew = ObjectName(i);
     
     if ( ObjectGetInteger(ChartID(),namew,OBJPROP_TYPE) == OBJ_TEXT ) {
     
     string obj_text=ObjectGetString(ChartID(),namew,OBJPROP_TEXT);
     string obj_tooltip=ObjectGetString(ChartID(),namew,OBJPROP_TOOLTIP);
     //double price1s=ObjectGetDouble(ChartID(),namew,OBJPROP_PRICE,0); // Text A Değeri

////////////////////////////////////////////////////////////////////////
     if ( obj_text == "A" ) {
     
     string namea=namew;
     string named=namew;
     int rplc=StringReplace(named,"ABCD-LineA","ABCD-1Line");
     double price_d=ObjectGetDouble(ChartID(),named,OBJPROP_PRICE,1); // D Noktası
   
     int rplcs=StringReplace(namea,"ABCD-LineA","ABCD-2Line");
     double price_a=ObjectGetDouble(ChartID(),namea,OBJPROP_PRICE,0); // D Noktası
     
  double time1_a=ObjectGetInteger(ChartID(),namea,OBJPROP_TIME,0);
  double time2_d=ObjectGetInteger(ChartID(),named,OBJPROP_TIME,1);
 

  int shift1_a=iBarShift(Symbol(),Period(),time1_a);
  int shift2_d=iBarShift(Symbol(),Period(),time2_d);          
      
     
     if ( StringFind(obj_tooltip,"Green",0) != -1 ) {
     
     ////////////////////////////////
     for (int iss=shift1_a-1;iss>0;iss--) {
     
     if ( price_a > Close[iss] ) {
      WorkEngineClear(obj_tooltip);
     }
     
     if ( price_d < Close[iss] || price_d <= High[iss]) {
      WorkEngineClear(obj_tooltip);
     }

     
     }
     ////////////////////////////////
     
     
     }
     
     if ( StringFind(obj_tooltip,"Gray",0) != -1 ) {
     
     
     ////////////////////////////////////////
     for (int iss=shift1_a-1;iss>0;iss--) {
     
     if ( price_a < Close[iss] ) {
     WorkEngineClear(obj_tooltip);
     }
     
     if ( price_d > Close[iss] || price_d >= Low[iss] ) {
      WorkEngineClear(obj_tooltip);
     }
          
     }
     ///////////////////////////////////////
  
     
     }
     
     
     }
     
/*   
/////////////////////////////////////////////////////////////////////
     if ( obj_text == "D" ) {
     
     if ( StringFind(obj_tooltip,"Green",0) != -1 ) {
     
     }
     
     if ( StringFind(obj_tooltip,"Gray",0) != -1 ) {
     
     }
     
     }
////////////////////////////////////////////////////////////////////
*/     
     
     
     
     }

     
     }











}


void WorkEngineClear(string tooltip) {

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     if (  obj_tooltip == tooltip ) {
     
     ObjectDelete(ChartID(),names);
     
     
     }
     
     
     
     }
     

}








void WorkEngineAllClear() {

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     bool durum=WorkEngineSearch(obj_tooltip);
     
     if ( durum == false ) {
     WorkEngineClear(obj_tooltip);
     }

     
     }
     
     
     
     }
     






bool WorkEngineSearch(string tooltip) {

bool sonuc=false;

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int iii=ObjectsTotal();iii>=0;iii--)
    {
     names = ObjectName(iii);
     
     string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     string obj_text=ObjectGetString(ChartID(),names,OBJPROP_TEXT);
     
     if (  obj_text == "A" && obj_tooltip == tooltip ) {
     
     //ObjectDelete(ChartID(),names);
     
     sonuc=true;
     
     
     }
     
     
     
     }
     
return sonuc;     

}

void SinyalEngine() {


    int obj_total=ObjectsTotal()-1;
  string names;
  for(int iii=ObjectsTotal();iii>=0;iii--)
    {
     names = ObjectName(iii);
     
     
     
     string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     string obj_text=ObjectGetString(ChartID(),names,OBJPROP_TEXT);
     color obj_color=ObjectGetInteger(ChartID(),names,OBJPROP_COLOR);
     double obj_prc1=ObjectGetDouble(ChartID(),names,OBJPROP_PRICE,0);
     datetime time_date=ObjectGetInteger(ChartID(),names,OBJPROP_TIME,0);
     
     if ( obj_color == clrYellow && StringFind(obj_tooltip,"Gray",0) != -1 ) {
     
    
     
     if ( StringFind(sinyal_list,obj_tooltip,0) == -1 ) {
     
      
     
     if ( (Open[0] > obj_prc1 && Low[0] <= obj_prc1) || Bid < obj_prc1 ) {
     
     Print("SinyalEngine",obj_prc1,"/",obj_tooltip);
     
     string sinyal_mesaj=Symbol()+" "+TFtoStr(Period())+" "+obj_prc1+" Buy";
     
     if ( sinyal_alert == true )  Alert(sinyal_mesaj);
     if ( sinyal_phone == true ) SendNotification(sinyal_mesaj);
     //if ( sinyal_telegram == true ) TelegramOld(sinyal_mesaj,"");     
     
if ( sinyal_telegram == true ) {

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();
long ChartIDS=ChartID();

Sleep(100);    

   string Sinyal=sym+"-"+TFtoStr(per)+"-Abcd-Reserval-Buy";
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+per;
   
   
   SinyalS=sym+per+"SRS"+time_date;
   
string fname="Abcd";
string image_files=sym+"-"+fname+"-"+per;


           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif";    
   

bool sinyal_sonuc=Telegram(Sinyal,SinyalS,filename,per,sym);
if ( sinyal_sonuc ) TelegramPhoto("Supdem",per,ChartIDS,sym);

     
     }   
     
     
     sinyal_list = sinyal_list + "," + obj_tooltip;

     
     }
     
     }

     }
     
     if ( obj_color == clrYellow && StringFind(obj_tooltip,"Green",0) != -1 ) {
     
     if ( StringFind(sinyal_list,obj_tooltip,0) == -1 ) {
     
     if ( (Open[0] < obj_prc1 && High[0] >= obj_prc1) || Bid > obj_prc1 ) {
     
     Print("SinyalEngine",obj_prc1,"/",obj_tooltip);
     
     string sinyal_mesaj=Symbol()+" "+TFtoStr(Period())+" "+obj_prc1+" Sell";
     
     if ( sinyal_alert == true ) Alert(sinyal_mesaj);
     if ( sinyal_phone == true ) SendNotification(sinyal_mesaj);
     //if ( sinyal_telegram == true ) TelegramOld(sinyal_mesaj,"");
     
if ( sinyal_telegram == true ) {

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();
long ChartIDS=ChartID();

Sleep(100);    

   string Sinyal=sym+"-"+TFtoStr(per)+"-Abcd-Reserval-Sell";
   string usym = sym;
   usym = StringToUpper(usym);
   string SinyalS = "https://www.tradingview.com/chart/?symbol="+sym+"|interval="+per;
   
   
   SinyalS=sym+per+"SRS"+time_date;
   
string fname="Abcd";
string image_files=sym+"-"+fname+"-"+per;


           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif";    
   

bool sinyal_sonuc=Telegram(Sinyal,SinyalS,filename,per,sym);
if ( sinyal_sonuc ) TelegramPhoto("Supdem",per,ChartIDS,sym);

     
     }    
     
     
     sinyal_list = sinyal_list + "," + obj_tooltip;
      
     
     }


     }

     
     }
     




}


}


//string sinyal_list="";


bool Telegram(string Sinyal,string Sinyals,string object_name,int per,string sym) {

bool sonuc=false;

if ( StringFind(sinyal_list,Sinyals,0) == -1 ) {
sinyal_list=sinyal_list+","+Sinyals;
sonuc=true;
} else {
sonuc=false;
return sonuc;
}


Sinyal = Sinyal;//+" http://85.215.201.11/"+object_name;

//string resim="http://85.215.201.11/"+object_name;

//Sinyal = "https://www.tradingview.com/chart/?symbol="+sym+"&interval="+per;


/*
if ( desktop_alert == true ) {
Alert(Sinyal);
return; 
}*/

//if ( desktop_alert == false ) {
   //string Sinyal=Symbol()+" Robot Başladı";
   string url="https://api.telegram.org/bot585984386:AAGD56RCd90VYHTKmcbMLbxwEYR7iizFWYo/sendMessage?chat_id=380108128&text="+Sinyal;

         url="http://www.yorumlari.org/telegram.php?img="+object_name+"&sym="+sym+"&per="+per+"&sinyal="+Sinyal+"&xxx=yyy";//+" "+Sinyals;
         //url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal;//+" "+Sinyals;

     string cookie=NULL,headers;
   char post[],result[];
   //int res;
//--- to enable access to the server, you should add URL "https://www.google.com/finance"
//--- in the list of allowed URLs (Main Menu->Tools->Options, tab "Expert Advisors"):
   //string url=server;
//--- Reset the last error code
   ResetLastError();
//--- Loading a html page from Google Finance
   int timeout=5000; //--- Timeout below 1000 (1 sec.) is not enough for slow Internet connection
   int res=WebRequest("POST",url,cookie,NULL,timeout,post,0,result,headers);
   
   
   
   
      //CovidCopyObject(object_name,"",-1);
   
   //}
   
   
return sonuc; 

}
  
  


void TelegramPhoto(string fname,int per,long cid,string sym) {

  
//Sleep(3000);
/////////////////////////////////////////////////////////////
//price=NormalizeDouble(price,Digits); 
//string prices=DoubleToString(price,Digits);
//string image_files=Symbol()+"-Covid"+int(TimeMinute(TimeCurrent()));
//string image_files=Symbol()+"-fname-"+IntegerToString(int(TimeMinute(TimeCurrent())));
string image_files=sym+"-"+fname+"-"+per;


           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif"; 


   int height=ChartGetInteger(cid,CHART_HEIGHT_IN_PIXELS,0);
   int width=ChartGetInteger(cid,CHART_WIDTH_IN_PIXELS,0);
   
   height=600;
   width=800;
   
   
  //if(ChartScreenShot(cid,filename,width,height,ALIGN_CENTER)){
  if(ChartScreenShot(cid,filename,width,height,ALIGN_RIGHT)){
  //if(WindowScreenShot(ChartIDS,filename,1500,800,ALIGN_RIGHT)){
  //Alert("Take to Shoot");


 if (!SendFTP(filename,NULL)) {
 Print("ScreenShot2webspace EA: Send2Ftp - Error "+GetLastError());
 } else {
 
 
  Sleep(500);
  
 
       string chat_ids="380108128";

    StringToCharArray("resim="+filename+"&chat_ids="+chat_ids+"&xxx=yyy", post);     
    
   ///int resi = WebRequest("POST", "http://45.144.154.90/resim-sendphoto.php", "", NULL, 10000, post, ArraySize(post), result, headers);
   int resi = WebRequest("GET", "http://yorumlari.org/forex.net.tr/resim-sendphoto.php?resim="+filename+"&chat_ids="+chat_ids, "", NULL, 10000, post, ArraySize(post), result, headers);


 //Alert("Analiz Resmi Gönderildi");
 //ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);
 }
 
 
 
 
 }
 
  
////////////////////////////////////////////////////////////

}
   
     string toLower(string text) { 
      StringToLower(text);
      return text; 
   };
    



void TelegramOld(string Sinyal,string Sinyals) {



//if ( server_mode == false ) return;

//Sinyals=Sinyal+"-"+TFtoStr(Period());
Sinyals=Sinyal;
//Alert(Sinyal);


/*
if ( StringFind(sinyal_list,Sinyal,0) == -1 ) {
sinyal_list=sinyal_list+","+Sinyal;
} else {
return;
}

if ( first_time == false ) return;
*/

   //string Sinyal=Symbol()+" Robot Başladı";
   string url="https://api.telegram.org/bot585984386:AAGD56RCd90VYHTKmcbMLbxwEYR7iizFWYo/sendMessage?chat_id=380108128&text="+Sinyal;
   //string url="https://api.telegram.org/bot5290598636:AAFNFWf8xsUX6DOpZ8M_Qhc1Eral2c6AYA4/sendMessage?chat_id=380108128&text="+Sinyal;

         //url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal+" "+Sinyals;
         url="http://www.yorumlari.org/telegram.php?sinyal="+Sinyal;
         //url="http://www.yorumlari.org/telegram-king.php?sinyal="+Sinyals;

     string cookie=NULL,headers;
   char post[],result[];
   //int res;
//--- to enable access to the server, you should add URL "https://www.google.com/finance"
//--- in the list of allowed URLs (Main Menu->Tools->Options, tab "Expert Advisors"):
   //string url=server;
//--- Reset the last error code
   ResetLastError();
//--- Loading a html page from Google Finance
   int timeout=5000; //--- Timeout below 1000 (1 sec.) is not enough for slow Internet connection
   int res=WebRequest("POST",url,cookie,NULL,timeout,post,0,result,headers);
   

/*
////////////////////////////////////////////////////////////////////////////////////////////////////////////
//string image_files=Symbol()+"-"+Sinyal+"-"+TFtoStr(Period());
string image_files=Sinyal+"-"+TFtoStr(Period());

           string imgname = image_files;                  
      int replacedx = StringReplace(imgname,"Save","");
          replacedx+= StringReplace(imgname,".","-");
 
        image_files=imgname+".gif";
        

  //string filename = image_files;//pair+"-line.gif"; 
  string filename =  toLower(image_files);//pair+"-line.gif"; 


   int height=ChartGetInteger(ChartID(),CHART_HEIGHT_IN_PIXELS,0);
   int width=ChartGetInteger(ChartID(),CHART_WIDTH_IN_PIXELS,0);
   

  if(ChartScreenShot(ChartID(),filename,width,height,ALIGN_CENTER)){
  

  if (!SendFTP(filename,NULL)) {
 Print("ScreenShot2webspace EA: Send2Ftp - Error "+GetLastError());
 } else {
 
 
  Sleep(500);
  
 
       string chat_ids="380108128";

    StringToCharArray("resim="+filename+"&chat_ids="+chat_ids+"&xxx=yyy", post);     
    
   ///int resi = WebRequest("POST", "http://45.144.154.90/resim-sendphoto.php", "", NULL, 10000, post, ArraySize(post), result, headers);
   int resi = WebRequest("GET", "http://yorumlari.org/forex.net.tr/resim-sendphoto-king.php?resim="+filename+"&chat_ids="+chat_ids, "", NULL, 10000, post, ArraySize(post), result, headers);

 //Alert(resi);
 
 }
 
 
 }*/
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////



}