//+------------------------------------------------------------------+
//|                                                  Maniplasyon.mq4 |
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
string last_select_object;
int last_select_len;
string last_object;
bool system=true;
bool flag_mode = false; 

int ObjTotal = ObjectsTotal();

int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   //DailyCycle();
   

  if ( Period() == PERIOD_M1 ) tsp=715;
  if ( Period() == PERIOD_M5 ) tsp=145;   
  if ( Period() == PERIOD_H1 ) tsp=11;   
  if ( Period() == PERIOD_M30 ) tsp=23;   
  if ( Period() == PERIOD_H4 ) tsp=3;   
  if ( Period() == PERIOD_M15 ) tsp=47;   
  if ( Period() == PERIOD_D1 ) tsp=1;   
  if ( Period() == PERIOD_W1 ) tsp=1;   
  if ( Period() == PERIOD_MN1 ) tsp=1;   
   
DailyCycle();
TimeFind();


ObjectsDeleteAll(ChartID(),-1,OBJ_VLINE);
   
   
   
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


if ( sparam == 45 ) {

ObjectsDeleteAll();
DailyCycle();


}

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Flag",0) == -1 && StringFind(sparam,"Trendline",0) != -1  ) {

Maniplasyon(sparam);

}

   
  }
//+------------------------------------------------------------------+


void Maniplasyon(string sparam) {

string name=sparam;

          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),name,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),name,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),name,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),name,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),name,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),name,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),name,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),name,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),name,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),name,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),name,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),name,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),name,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),name,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),name,OBJPROP_BACK);
          
          int obj_shift1=iBarShift(Symbol(),Period(),obj_time1);
          int obj_shift2=iBarShift(Symbol(),Period(),obj_time2);
          int obj_shift3=iBarShift(Symbol(),Period(),obj_time3);

double high_price;
double low_price;
datetime time1=obj_time1;
///////////////////////////////////////////////////////////////////////////////////////////////////
// DOWN
///////////////////////////////////////////////////////////////////////////////////////////////////
if ( obj_prc2 > obj_prc1 ) {

ObjectMove(name,1,obj_time2,High[obj_shift2]);
ObjectMove(name,0,obj_time1,Low[obj_shift1]);

high_price=High[obj_shift2];
low_price=Low[obj_shift1];



   double yuzde = DivZero(high_price-low_price, 100);
   
   string namet="";
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   
   double level0=0;
   double level100=0; 

  double level=level168;
  string levels="u168";       
  string names=namet +" Flag ";
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   
     
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level618;
  levels="d618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level886;
  levels="d886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,Time[0],low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  

  level=level886;
  levels="d886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-(level*2),Time[0],low_price-(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrCrimson);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////



double up_price=Low[obj_shift1];
int up_shift=obj_shift1;
bool find=false;

for (int t=obj_shift1-1;t>0;t--) {

if ( t < 0 ) continue;
if ( find == true ) continue;

if ( High[t] > up_price || High[t-1] > up_price || High[t-2] > up_price ) {up_price=High[t];up_shift=t;} else {find=true;}


}

//if ( Low[t] < down_price || Low[t-1] < down_price || Low[t-2] < down_price )


  string nam="UpPrice";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[up_shift],up_price,Time[up_shift]+(5*PeriodSeconds()),up_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrCrimson);
  

  nam="LowUp";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[obj_shift1],low_price,Time[up_shift],up_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);
  
double down_price=Low[obj_shift1];
int down_shift=obj_shift1;
find=false;
bool first_low=false;


for (int t=up_shift-1;t>0;t--) {

if ( t < 0 ) continue;
if ( find == true ) continue;

if ( Low[t] < down_price ) {down_price=Low[t];down_shift=t;first_low=true;} else {

if ( first_low == true ) find=true;


}


}


  nam="DownPrice";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[down_shift],down_price,Time[down_shift]+(5*PeriodSeconds()),down_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrCrimson);
  

  nam="UpDown";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[down_shift],down_price,Time[up_shift],up_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);
      
  
  nam="HighPrice";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[obj_shift2],high_price,Time[obj_shift2]+200*PeriodSeconds(),high_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);


double top_price=High[obj_shift2];
int top_shift=down_shift;
find=false;
bool first_high=false;
bool touch=false;
int touch_shift;
double touch_price;

for (int t=down_shift-10;t>0;t--) {

if ( t < 0 ) continue;
if ( find == true ) continue;
if ( Close[t] < high_price ) continue;

if ( Low[t] <= high_price && Open[t] > high_price && Close[t] > high_price && touch == false ) {touch=true;touch_shift=t;touch_price=Low[t];}

if ( High[t] > top_price ) {top_price=High[t];top_shift=t;first_high=true;} else {

if ( first_high == true && touch == true ) find=true;


}


}

  nam="TopPrice";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[top_shift],top_price,Time[top_shift]+(5*PeriodSeconds()),top_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrCrimson);
  


  nam="DownTop";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[down_shift],down_price,Time[top_shift],top_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);


  nam="TopHighTouch";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[touch_shift],touch_price,Time[top_shift],top_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);
  
  
    
    
  
Comment("Up Price:",up_price,"/ Down Price:",down_price);




FlagDownUp(high_price,low_price,"w",obj_shift1,"HShift","fside");







}          

//////////////////////////////////////////////////////////////////////////////////////////////////
// TOP
//////////////////////////////////////////////////////////////////////////////////////////////////
if ( obj_prc1 > obj_prc2 ) {

ObjectMove(name,0,obj_time1,High[obj_shift1]);
ObjectMove(name,1,obj_time2,Low[obj_shift2]);

high_price=High[obj_shift1];
low_price=Low[obj_shift2];




   double yuzde = DivZero(high_price-low_price, 100);
   
   string namet="";
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   
   double level0=0;
   double level100=0; 

  double level=level168;
  string levels="u168";       
  string names=namet +" Flag ";
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   
     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level272;
  levels="u272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level886;
  levels="u886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,Time[0],high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level886;
  levels="u886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+(level*2),Time[0],high_price+(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrCrimson);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


double down_price=High[obj_shift1];
int down_shift=obj_shift1;
bool find=false;

for (int t=obj_shift1-1;t>0;t--) {

if ( t < 0 ) continue;
if ( find == true ) continue;

if ( Low[t] < down_price || Low[t-1] < down_price || Low[t-2] < down_price ) {down_price=Low[t];down_shift=t;} else {find=true;}


}

  string nam="DownPrice";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[down_shift],down_price,Time[down_shift]+(5*PeriodSeconds()),down_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrCrimson);
  
  
  nam="HighDown";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[obj_shift1],high_price,Time[down_shift],down_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);
    

double up_price=High[obj_shift1];
int up_shift=obj_shift1;
find=false;
bool first_high=false;


for (int t=down_shift-1;t>0;t--) {

if ( t < 0 ) continue;
if ( find == true ) continue;

if ( High[t] > up_price ) {up_price=High[t];up_shift=t;first_high=true;} else {

if ( first_high == true ) find=true;


}


}

  nam="UpPrice";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[up_shift],up_price,Time[up_shift]+(5*PeriodSeconds()),up_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrCrimson);
  
  
  nam="UpDown";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[down_shift],down_price,Time[up_shift],up_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);
  

  nam="LowPrice";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[obj_shift2],low_price,Time[obj_shift2]+200*PeriodSeconds(),low_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);  
  


double bottom_price=Low[obj_shift2];
int bottom_shift=up_shift;
find=false;
bool first_low=false;
bool touch=false;
int touch_shift;
double touch_price;

for (int t=up_shift-10;t>0;t--) {

if ( t < 0 ) continue;
if ( find == true ) continue;
if ( Close[t] > low_price ) continue;

if ( High[t] >= low_price && Open[t] < low_price && Close[t] < low_price && touch == false ) {touch=true;touch_shift=t;touch_price=High[t];}

if ( Low[t] < bottom_price ) {bottom_price=Low[t];bottom_shift=t;first_low=true;} else {

if ( first_low == true && touch == true ) find=true;


}


}

  nam="BottomPrice";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[bottom_shift],bottom_price,Time[bottom_shift]+(5*PeriodSeconds()),bottom_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrCrimson);
  


  nam="UpBottom";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[up_shift],up_price,Time[bottom_shift],bottom_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);


  nam="BottomLowTouch";       
  ObjectDelete(ChartID(),nam);
  ObjectCreate(ChartID(),nam,OBJ_TREND,0,Time[touch_shift],touch_price,Time[bottom_shift],bottom_price);
  ObjectSetInteger(ChartID(),nam,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),nam,OBJPROP_COLOR,clrWhite);

    
    
  
Comment("Up Price:",up_price,"/ Down Price:",down_price);



FlagUpDown(high_price,low_price,"w",obj_shift1,"HShift","fside");

















}          
////////////////////////////////////////////////////////////////////////////////////////////////   
   
   
             

}

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 


double FlagDownUp(double high_price,double low_price,string w,int l,string HShift,string fside) {


//Alert("Selam");


//if ( StringFind(Symbol(),"XAU",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 ) {


/*double distance=low_price+18;
double distance32=low_price+32;*/

int mesafe=100;
int kademe=32;

if ( StringFind(Symbol(),"XAU",0) == -1 || StringFind(Symbol(),"GOLD",0) == -1 ) {kademe=17;}
if ( StringFind(Symbol(),"UK100",0) != -1 || StringFind(Symbol(),"UK100",0) != -1 ) {kademe=32;mesafe=1000;}

double distance32=low_price+(mesafe*kademe)*Point;



/*
ObjectDelete(ChartID(),w+" Distance32");
ObjectCreate(ChartID(),w+" Distance32",OBJ_TREND,0,Time[l]-100*PeriodSeconds(),distance32,Time[l]-5000*PeriodSeconds(),distance32); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_WIDTH,2); 


ObjectDelete(ChartID(),w+" Distancew");
ObjectCreate(ChartID(),w+" Distancew",OBJ_TREND,0,Time[l]-50*PeriodSeconds(),low_price,Time[l]-5000*PeriodSeconds(),low_price); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_WIDTH,2); 





ObjectDelete(ChartID(),w+" Distance5");
ObjectCreate(ChartID(),w+" Distance5",OBJ_TREND,0,Time[l],low_price+((distance32-low_price)/2),Time[l]-5000*PeriodSeconds(),low_price+((distance32-low_price)/2)); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_WIDTH,1); 



ObjectDelete(ChartID(),w+" Distance");
ObjectCreate(ChartID(),w+" Distance",OBJ_TREND,0,Time[l]-50*PeriodSeconds(),low_price,Time[l]-100*PeriodSeconds(),distance32); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_WIDTH,2);*/
/*
ObjectDelete(ChartID(),w+" Distancel");
ObjectCreate(ChartID(),w+" Distancel",OBJ_TREND,0,Time[l],distance,Time[l]-5000*PeriodSeconds(),distance); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_COLOR,clrLightGray); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_WIDTH,2); 
*/


//}






double very_low_price=low_price;
double very_high_price=high_price;
int very_high_shift=0;
int very_low_shift=l;

for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_low_price > Low[x] ) {very_low_price=Low[x];very_low_shift=x;}

}


for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_high_price < High[x] ) {very_high_price=High[x];very_high_shift=x;}

}


double hl_fark=(very_high_price-very_low_price);
double hl_yuzde=hl_fark/100;

double hl_50=very_high_price-(hl_yuzde*50);
double hl_79=very_high_price-(hl_yuzde*79);
double hl_70=very_high_price-(hl_yuzde*70);


ObjectDelete(ChartID(),w+" VeryHLPrice");
ObjectCreate(ChartID(),w+" VeryHLPrice",OBJ_TREND,0,Time[very_low_shift],very_low_price,Time[very_high_shift],very_high_price); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_COLOR,clrLightGray); 



ObjectDelete(ChartID(),w+" VeryLowPrice");
ObjectCreate(ChartID(),w+" VeryLowPrice",OBJ_TREND,0,Time[very_low_shift],very_low_price,Time[l]+200*PeriodSeconds(),very_low_price);
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryHighPrice");
ObjectCreate(ChartID(),w+" VeryHighPrice",OBJ_TREND,0,Time[very_high_shift],very_high_price,Time[l]+200*PeriodSeconds(),very_high_price);
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryFibpPriceEQ");
ObjectCreate(ChartID(),w+" VeryFiboPriceEQ",OBJ_TREND,0,Time[very_high_shift],hl_50,Time[l]+200*PeriodSeconds(),hl_50);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_WIDTH,2); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_COLOR,clrSteelBlue); 

ObjectDelete(ChartID(),w+" VeryFibpPriceOTE");
ObjectCreate(ChartID(),w+" VeryFiboPriceOTE",OBJ_RECTANGLE,0,Time[very_high_shift],hl_70,Time[l]+200*PeriodSeconds(),hl_79);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_COLOR,clrSteelBlue); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_BACK,false);





//return 0.0;

//double high_price=High[w];
//double low_price=Low[l];         
         
int Fark=int((high_price-low_price)/Point);
int PipFark=int((high_price-low_price)/Point);
   //int mum=low_shift-high_shift;
   
   double tepe_fiyats=high_price;
   double dip_fiyats=low_price;
   
       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5236=dip_fiyats+Fark*Point;


   string name = w+"Flag5High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   //ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   
   name = w+"Flag5Highs"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],low_price,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   
   
       

       Fark=(((tepe_fiyats-dip_fiyats)*8)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat7=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*8.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat7236=dip_fiyats+Fark*Point;


   name = w+"Flag7High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat7,Time[l]+100*PeriodSeconds(),fiyat7);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,7+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   
   
   
        
       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8236=dip_fiyats+Fark*Point;


   name = w+"Flag8High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,8+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   

       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat12=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat12236=dip_fiyats+Fark*Point;


   name = w+"Flag11High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat12,Time[l]+100*PeriodSeconds(),fiyat12236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat12,Time[l]+100*PeriodSeconds(),fiyat12);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,11+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   


       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3236=dip_fiyats+Fark*Point;


   name = w+"Flag3High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   

////////////////////////////////////////////////////////////////////////



   name = w+"Flag3Distance"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+600*PeriodSeconds(),fiyat3-(low_price-very_low_price));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrSteelBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 




////////////////////////////////////////////////////////////////////////   




   
       Fark=(((tepe_fiyats-dip_fiyats)*5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4=dip_fiyats+Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*5.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4236=dip_fiyats+Fark*Point;


   name = w+"Flag4High"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat4,Time[l]+100*PeriodSeconds(),fiyat4);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
   
   //Alert("Selam",l);
   

//for (int y=l;y<l+100;y+=2){


for (int y=WindowFirstVisibleBar();y>1;y--){
name=w+"Bolge"+y;
ObjectDelete(ChartID(),name);
}

for (int y=l;y>l-500;y-=4){

if ( y-5 > 0 ) {
name=w+"Bolge"+y;
//ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[y],fiyat4,Time[y-5],fiyat3);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
//Print(y);
}


}
   
      
   
   
flag5_downup_low=low_price;
   
if ( fside == "Left" ) flag5_downup_left=fiyat5;
if ( fside == "right" ) flag5_downup_right=fiyat5;   
flag5_downup=fiyat5;

//sell_mesafe=((flag5_downup_low-flag5_downup)/Point)/kademe;

//sell_profit=int(sell_mesafe);

return fiyat5;

}



double FlagUpDown(double high_price,double low_price,string w,int l,string HShift,string fside) {


//if ( StringFind(Symbol(),"XAU",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 ) {

int mesafe=100;
int kademe=32;

if ( StringFind(Symbol(),"XAU",0) == -1 || StringFind(Symbol(),"GOLD",0) == -1 ) {kademe=17;}
if ( StringFind(Symbol(),"UK100",0) != -1 || StringFind(Symbol(),"UK100",0) != -1 ) {kademe=32;mesafe=1000;}

double distance32=high_price-(mesafe*kademe)*Point;



//double distance=high_price-18;
//double distance32=high_price-32;

/*
ObjectDelete(ChartID(),w+" Distance32");
ObjectCreate(ChartID(),w+" Distance32",OBJ_TREND,0,Time[l]-100*PeriodSeconds(),distance32,Time[l]-5000*PeriodSeconds(),distance32); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance32",OBJPROP_WIDTH,2); 


ObjectDelete(ChartID(),w+" Distancew");
ObjectCreate(ChartID(),w+" Distancew",OBJ_TREND,0,Time[l]-50*PeriodSeconds(),high_price,Time[l]-5000*PeriodSeconds(),high_price); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distancew",OBJPROP_WIDTH,2); 

ObjectDelete(ChartID(),w+" Distance");
ObjectCreate(ChartID(),w+" Distance",OBJ_TREND,0,Time[l]-50*PeriodSeconds(),high_price,Time[l]-100*PeriodSeconds(),distance32); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance",OBJPROP_WIDTH,2);



ObjectDelete(ChartID(),w+" Distance5");
ObjectCreate(ChartID(),w+" Distance5",OBJ_TREND,0,Time[l],low_price+((distance32-low_price)/2),Time[l]-5000*PeriodSeconds(),low_price+((distance32-low_price)/2)); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_COLOR,clrSaddleBrown); 
ObjectSetInteger(ChartID(),w+" Distance5",OBJPROP_WIDTH,1); */




/*
ObjectDelete(ChartID(),w+" Distancel");
ObjectCreate(ChartID(),w+" Distancel",OBJ_TREND,0,Time[l],distance,Time[l]-5000*PeriodSeconds(),distance); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_COLOR,clrLightGray); 
ObjectSetInteger(ChartID(),w+" Distancel",OBJPROP_WIDTH,2); 
*/


//}




//Alert(high_price);


//Alert(high_price,"/",l);
/*
double very_high_price=high_price;

for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_high_price < High[x] ) very_high_price=High[x];

}

ObjectDelete(ChartID(),w+" VeryHighPrice");
ObjectCreate(ChartID(),w+" VeryHighPrice",OBJ_TREND,0,Time[l],very_high_price,Time[l]+200*PeriodSeconds(),very_high_price);
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_RAY,false); 

*/



double very_low_price=low_price;
double very_high_price=high_price;
int very_high_shift=l;
int very_low_shift=0;

for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_low_price > Low[x] ) {very_low_price=Low[x];very_low_shift=x;}

}


for (int x=l-1;x>l-150;x--) {

if ( x < 0 ) continue;

if ( very_high_price < High[x] ) {very_high_price=High[x];very_high_shift=x;}

}


double hl_fark=(very_high_price-very_low_price);
double hl_yuzde=hl_fark/100;

double hl_50=very_low_price+(hl_yuzde*50);
double hl_79=very_low_price+(hl_yuzde*79);
double hl_70=very_low_price+(hl_yuzde*70);


ObjectDelete(ChartID(),w+" VeryHLPrice");
ObjectCreate(ChartID(),w+" VeryHLPrice",OBJ_TREND,0,Time[very_high_shift],very_high_price,Time[very_low_shift],very_low_price); ///
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_STYLE,STYLE_DOT); 
ObjectSetInteger(ChartID(),w+" VeryHLPrice",OBJPROP_COLOR,clrLightGray); 



ObjectDelete(ChartID(),w+" VeryLowPrice");
ObjectCreate(ChartID(),w+" VeryLowPrice",OBJ_TREND,0,Time[very_low_shift],very_low_price,Time[l]+200*PeriodSeconds(),very_low_price);
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryLowPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryHighPrice");
ObjectCreate(ChartID(),w+" VeryHighPrice",OBJ_TREND,0,Time[very_high_shift],very_high_price,Time[l]+200*PeriodSeconds(),very_high_price);
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryHighPrice",OBJPROP_STYLE,STYLE_DOT); 

ObjectDelete(ChartID(),w+" VeryFiboPriceEQ");
ObjectCreate(ChartID(),w+" VeryFiboPriceEQ",OBJ_TREND,0,Time[very_high_shift],hl_50,Time[l]+200*PeriodSeconds(),hl_50);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_WIDTH,2); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_COLOR,clrSteelBlue); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceEQ",OBJPROP_BACK,true); 

ObjectDelete(ChartID(),w+" VeryFiboPriceOTE");
ObjectCreate(ChartID(),w+" VeryFiboPriceOTE",OBJ_RECTANGLE,0,Time[very_high_shift],hl_70,Time[l]+200*PeriodSeconds(),hl_79);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_RAY,false); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_COLOR,clrSteelBlue); 
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_FILL,clrNONE);
ObjectSetInteger(ChartID(),w+" VeryFiboPriceOTE",OBJPROP_BACK,false);




//return 0.0;

//double high_price=High[w];
//double low_price=Low[l];         
         
int Fark=int((high_price-low_price)/Point);
int PipFark=int((high_price-low_price)/Point);
   //int mum=low_shift-high_shift;
   
   double tepe_fiyats=high_price;
   double dip_fiyats=low_price;
   
       Fark=(((tepe_fiyats-dip_fiyats)*6)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*6.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat5236=tepe_fiyats-Fark*Point;


   string name = w+"Flag5Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   
   
   name = w+"Flag5Lows"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat5,Time[l]+100*PeriodSeconds(),fiyat5236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],high_price,Time[l]+100*PeriodSeconds(),fiyat5);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,5+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
   
        


       Fark=(((tepe_fiyats-dip_fiyats)*8)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat7=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*8.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat7236=tepe_fiyats-Fark*Point;


   name = w+"Flag7Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat7,Time[l]+100*PeriodSeconds(),fiyat7);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrDarkGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,7+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   
   
           
       Fark=(((tepe_fiyats-dip_fiyats)*9)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*9.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat8236=tepe_fiyats-Fark*Point;


   name = w+"Flag8Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat8,Time[l]+100*PeriodSeconds(),fiyat8);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,8+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   

       Fark=(((tepe_fiyats-dip_fiyats)*12)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat12=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*12.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat12236=tepe_fiyats-Fark*Point;


   name = w+"Flag11Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat12,Time[l]+100*PeriodSeconds(),fiyat12236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat12,Time[l]+100*PeriodSeconds(),fiyat12);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,11+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   


       Fark=(((tepe_fiyats-dip_fiyats)*4)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*4.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat3236=tepe_fiyats-Fark*Point;


   name = w+"Flag3Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrRed);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   

////////////////////////////////////////////////////////////////////////



   name = w+"Flag3Distance"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+600*PeriodSeconds(),fiyat3+(very_high_price-high_price));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrSteelBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,3+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 




////////////////////////////////////////////////////////////////////////   
   
   
   
   
   

       Fark=(((tepe_fiyats-dip_fiyats)*5)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat4=tepe_fiyats-Fark*Point;

       Fark=(((tepe_fiyats-dip_fiyats)*5.236)-(((tepe_fiyats-dip_fiyats)/100)*61.8))/Point;
double fiyat436=tepe_fiyats-Fark*Point;


   name = w+"Flag4Low"+HShift;

   //ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,Time[l],fiyat3,Time[l]+100*PeriodSeconds(),fiyat3236);
   ObjectDelete(ChartID(),name);
   ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[l],fiyat4,Time[l]+100*PeriodSeconds(),fiyat4);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,4+fside);   
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,true); 
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);


for (int y=WindowFirstVisibleBar();y>1;y--){
name=w+"Bolge"+y;
ObjectDelete(ChartID(),name);
}


   
   
for (int y=l;y>l-300;y-=4){

name=w+"Bolge"+y;
ObjectDelete(ChartID(),name);

if ( y-5 > 0 ) {
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[y],fiyat3,Time[y-5],fiyat4);
ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT); 
//Print(y);
}


}
      
   

flag5_updown_high=high_price;
   
if ( fside == "Left" ) flag5_updown_left=fiyat5;
if ( fside == "right" ) flag5_updown_right=fiyat5;   
flag5_updown=fiyat5;


//buy_mesafe=((flag5_updown_high-flag5_updown)/Point)/kademe;
//buy_profit=int(buy_mesafe);

return fiyat5;   

}

double flag5_downup_left;
double flag5_downup_right;
double flag5_downup=1;
double flag5_downup_low=1000000;

double flag5_updown_left;
double flag5_updown_right;
double flag5_updown=-1;
double flag5_updown_high=-1;

double buy_mesafe=100;
double sell_mesafe=100;

int buy_profit=8;
int sell_profit=8;   

void AlertObject(){

//Alert("Last_Object",last_object);

if ( ObjectFind(ChartID(),last_object) == -1 ) { 
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TREND);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TEXT);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TRENDBYANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_RECTANGLE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_VLINE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_HLINE);
ObjectsDeleteAlls(ChartID(),last_object,0,OBJ_TRIANGLE);
}

}

/////////////////////////////////////////////////////////////////////////////////////////////////////////

void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  //Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


}
       
    
    

void DailyCycle() {

   //ObjectsDeleteAll();

string sym=Symbol();
ENUM_TIMEFRAMES per=Period();

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  datetime some_time = StringToTime(yenitarih);
  
  datetime ty_work_start_time=some_time;
  int ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 13:00";
  some_time = StringToTime(yenitarih);
  datetime ty_work_end_time=some_time;
  int ty_work_end_shift=iBarShift(sym,per,some_time);


   string name="TokyoSession";
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
       
  
int tday=TimeDay(TimeCurrent());
for(int t=tday-1;t>0;t--) {

  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 11:00";
  datetime some_time = StringToTime(yenitarih);
  
  datetime ty_work_start_time=some_time;
  int ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 13:00";
  some_time = StringToTime(yenitarih);
  datetime ty_work_end_time=some_time;
  int ty_work_end_shift=iBarShift(sym,per,some_time);

   string name="TokyoSession"+t;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);




  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 15:25";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 17:00";
  some_time = StringToTime(yenitarih);
  
  ty_work_start_time=some_time;
  ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 17:00";
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 18:00";
  some_time = StringToTime(yenitarih);
  ty_work_end_time=some_time;
  ty_work_end_shift=iBarShift(sym,per,some_time);

   name="LondonSession"+t;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightBlue);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNONE);
   

  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 02:00";
  some_time = StringToTime(yenitarih);
  
  ty_work_start_time=some_time;
  ty_work_start_shift=iBarShift(sym,per,some_time);
  
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+t+" 03:00";
  some_time = StringToTime(yenitarih);
  ty_work_end_time=some_time;
  ty_work_end_shift=iBarShift(sym,per,some_time);

   name="NewyorkSession"+t;
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_work_start_time,WindowPriceMax(),ty_work_end_time,WindowPriceMin());
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightSlateGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BGCOLOR,clrNONE);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrNONE);
   
      
    
 }  
   
   
   
   }    
   
   


bool event_icon = false;

string TimeOH[11];
string TimeOM[11];

/*

int TimeConvert(int saat,int dakika,bool topla,bool cikar,int fark) {

int sonuc=-1;

return sonuc;

}*/


double tokyo_high;  
double tokyo_low;

double london_high;  
double london_low;

double newyork_high;  
double newyork_low;


void TimeFind() {


//ObjectsDeleteAll(ChartID(),-1,-1);


   int time_saat_farki = 0;
   int time_dakika_farki=0;
   bool time_cikar = false;
   bool time_topla = false;
   

   if ( TimeHour(TimeLocal()) > TimeHour(TimeCurrent()) ) {
   time_saat_farki=int(TimeHour(TimeLocal()))-int(TimeHour(TimeCurrent()));
   time_dakika_farki=(TimeLocal()-TimeCurrent())/60;
   time_cikar=true;
   time_topla=false;
   }
   
   if ( TimeHour(TimeCurrent()) > TimeHour(TimeLocal()) ) {
   time_saat_farki=int(TimeHour(TimeCurrent()))-int(TimeHour(TimeLocal()));
   time_dakika_farki=(TimeCurrent()-TimeLocal())/60;
   time_topla=true;
   time_cikar=false;
   }
   /*
   time_topla=true;
   time_saat_farki=1;
   time_dakika_farki=0;*/
      
   
  //ObjectsDeleteAll(ChartID(),-1,-1);

//TimeConvert(Time1,Time1dk,time_topla,time_cikar,time_saat_farki);
  
  
  /*
  int Time1=3;
  int Time1dk=0;
  int Time2=12;
  int Time2dk=00;
  int Time3=11; 
  int Time3dk=0;
  int Time4=20; 
  int Time4dk=0;
  int Time5=15; 
  int Time5dk=0;      
  int Time6=23; 
  int Time6dk=55;
  int Time7=23; 
  int Time7dk=0;
  int Time8=8; 
  int Time8dk=0; 
  int Time9=9; 
  int Time9dk=0;   
  int Time10=19; 
  int Time10dk=0  
    */  
  

  int Time1=3;
  int Time1dk=0;
  int Time2=12;
  int Time2dk=00;
  int Time3=10; 
  int Time3dk=0;
  int Time4=19; 
  int Time4dk=0;
  int Time5=15; 
  int Time5dk=0;      
  int Time6=23; 
  int Time6dk=55;

  int Time7=0; 
  int Time7dk=0;
  int Time8=7; 
  int Time8dk=0;
      
  int Time9=8; 
  int Time9dk=0;
  int Time10=17; 
  int Time10dk=0;
  
      
  
  /*
  int Time1=23;
  int Time1dk=0;
  int Time2=8;
  int Time2dk=00;
  int Time3=9; 
  int Time3dk=0;
  int Time4=18; 
  int Time4dk=0;
  int Time5=16; 
  int Time5dk=25;      
  int Time6=17; 
  int Time6dk=00;  */
  
  
/*
  int Time1=2;
  int Time1dk=0;
  int Time2=11;
  int Time2dk=00;
  int Time3=10; 
  int Time3dk=0;
  int Time4=18; 
  int Time4dk=0;
  int Time5=15; 
  int Time5dk=0;      
  int Time6=23; 
  int Time6dk=55;*/  
  
  
  
  if ( StringFind(Symbol(),"ETH",0) != -1 ) {
  Time4=17; 
  Time4dk=35;  
  Time1=19; 
  Time1dk=30;       
  }

  if ( StringFind(Symbol(),"BTC",0) != -1 ) {
  Time4=17; 
  Time4dk=35;
  Time1=19; 
  Time1dk=30;          
  }   
  
  
  if ( StringFind(Symbol(),"TECH",0) != -1 ) {
  Time2=17;
  Time2dk=25; 
  Time3=15; 
  Time3dk=0;   
  Time4=1; 
  Time4dk=0;      
  }
  
  if ( StringFind(Symbol(),"DE40",0) != -1 ) {
  Time1=16;
  Time1dk=30;  
  Time2=11;
  Time2dk=0; 
  Time3=10; 
  Time3dk=0; 
  Time4=1; 
  Time4dk=0;        
  }  
  

TimeOH[1]=Time1;
TimeOM[1]=Time1dk;
TimeOH[2]=Time2;
TimeOM[2]=Time2dk;
TimeOH[3]=Time3;
TimeOM[3]=Time3dk;
TimeOH[4]=Time4;
TimeOM[4]=Time4dk;  
TimeOH[5]=Time5;
TimeOM[5]=Time5dk;  
TimeOH[6]=Time6;
TimeOM[6]=Time6dk;  
TimeOH[7]=Time7;
TimeOM[7]=Time7dk;  
TimeOH[8]=Time8;
TimeOM[8]=Time8dk;  
TimeOH[9]=Time9;
TimeOM[9]=Time9dk;  
TimeOH[10]=Time10;
TimeOM[10]=Time10dk;  
  
      
  
    
  
  if ( DayOfWeek()==0 || DayOfWeek()==6 ) {
  ////////////////////////////////
  time_saat_farki=1;
  Time1=Time1-time_saat_farki;
  Time2=Time2-time_saat_farki;
  Time3=Time3-time_saat_farki;
  Time4=Time4-time_saat_farki;
  Time5=Time4-time_saat_farki;
  Time6=Time6-time_saat_farki;
  ////////////////////////////////  
  } else {
    
  
 
  if ( time_cikar == true ) {
  Time1=Time1-time_saat_farki;
  Time2=Time2-time_saat_farki;
  Time3=Time3-time_saat_farki;
  Time4=Time4-time_saat_farki;
  Time5=Time5-time_saat_farki;
  Time6=Time6-time_saat_farki;  
  }

  if ( time_topla == true ) {
  Time1=Time1+time_saat_farki;
  Time2=Time2+time_saat_farki;
  Time3=Time3+time_saat_farki;
  Time4=Time4+time_saat_farki;
  Time5=Time5+time_saat_farki;
  Time6=Time6+time_saat_farki;
  } 
  
  
  }
  

  
    
  
  

  //Alert(time_saat_farki);
  
   int saat;
   int dakika;
   
   saat = Time1;
   dakika = Time1dk;
  
   /*if ( time_topla == true ) {
   saat = Time1;
   dakika = Time1dk;
   }
   else{
   saat = Time1;
   dakika = Time1dk;
   }*/
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  datetime some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT1");
   ObjectCreate(0,"TimeT1",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT1",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT1",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT1",OBJPROP_STYLE,STYLE_DASHDOTDOT); 
   ObjectSetString(0,"TimeT1",OBJPROP_TOOLTIP,TimeOH[1]+":"+TimeOM[1]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE1");
   ObjectCreate(0,"TimeE1",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE1",OBJPROP_TOOLTIP,TimeOH[1]+":"+TimeOM[1]);
   ObjectSetInteger(0,"TimeE1",OBJPROP_COLOR,event_color);     
}   

   saat = Time2;
   dakika = Time2dk;

   /*if ( time_topla == true ) {
   saat = Time2+1;
   dakika = Time2dk;
   }
   else{
   saat = Time2-1;
   dakika = Time2dk;
   }*/
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT2");
   ObjectCreate(0,"TimeT2",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT2",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT2",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT2",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT2",OBJPROP_TOOLTIP,TimeOH[2]+":"+TimeOM[2]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE2");
   ObjectCreate(0,"TimeE2",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE2",OBJPROP_TOOLTIP,TimeOH[2]+":"+TimeOM[2]);
   ObjectSetInteger(0,"TimeE2",OBJPROP_COLOR,event_color);    
}   
   /*if ( time_topla == true ) {
   saat = Time3+1;
   dakika = Time3dk;
   }
   else{
   saat = Time3-1;
   dakika = Time3dk;
   }*/
   
   saat = Time3;
   dakika = Time3dk;
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT3");
   ObjectCreate(0,"TimeT3",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT3",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT3",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT3",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT3",OBJPROP_TOOLTIP,TimeOH[3]+":"+TimeOM[3]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE3");
   ObjectCreate(0,"TimeE3",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE3",OBJPROP_TOOLTIP,TimeOH[3]+":"+TimeOM[3]);
   ObjectSetInteger(0,"TimeE3",OBJPROP_COLOR,event_color);    
}   
          
   /*if ( time_topla == true ) {
   saat = Time4+1;
   dakika = Time4dk;
   }
   else{
   saat = Time4-1;
   dakika = Time4dk;
   }*/
   
   saat = Time4;
   dakika = Time4dk;
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT4");
   ObjectCreate(0,"TimeT4",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT4",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT4",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT4",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT4",OBJPROP_TOOLTIP,TimeOH[4]+":"+TimeOM[4]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE4");
   ObjectCreate(0,"TimeE4",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE4",OBJPROP_TOOLTIP,TimeOH[1]+":"+TimeOM[1]);
   ObjectSetInteger(0,"TimeE4",OBJPROP_COLOR,event_color);  
   
}      




   saat = Time5;
   dakika = Time5dk;
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT5");
   ObjectCreate(0,"TimeT5",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT5",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT5",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT5",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT5",OBJPROP_TOOLTIP,TimeOH[5]+":"+TimeOM[5]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE5");
   ObjectCreate(0,"TimeE5",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE5",OBJPROP_TOOLTIP,TimeOH[5]+":"+TimeOM[5]);
   ObjectSetInteger(0,"TimeE5",OBJPROP_COLOR,event_color);  
   
}      


   saat = Time6;
   dakika = Time6dk;
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT6");
   ObjectCreate(0,"TimeT6",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT6",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT6",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT6",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT6",OBJPROP_TOOLTIP,TimeOH[5]+":"+TimeOM[5]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE6");
   ObjectCreate(0,"TimeE6",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE6",OBJPROP_TOOLTIP,TimeOH[6]+":"+TimeOM[6]);
   ObjectSetInteger(0,"TimeE6",OBJPROP_COLOR,event_color);  
   
}      



   saat = Time7;
   dakika = Time7dk;
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT7");
   ObjectCreate(0,"TimeT7",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT7",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT7",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT7",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT7",OBJPROP_TOOLTIP,TimeOH[7]+":"+TimeOM[7]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE7");
   ObjectCreate(0,"TimeE7",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE7",OBJPROP_TOOLTIP,TimeOH[7]+":"+TimeOM[7]);
   ObjectSetInteger(0,"TimeE7",OBJPROP_COLOR,event_color);  
   
}      


   saat = Time8;
   dakika = Time8dk;
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT8");
   ObjectCreate(0,"TimeT8",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT8",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT8",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT8",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT8",OBJPROP_TOOLTIP,TimeOH[8]+":"+TimeOM[8]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE8");
   ObjectCreate(0,"TimeE8",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE8",OBJPROP_TOOLTIP,TimeOH[8]+":"+TimeOM[8]);
   ObjectSetInteger(0,"TimeE8",OBJPROP_COLOR,event_color);  
   
}      


   saat = Time9;
   dakika = Time9dk;
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT9");
   ObjectCreate(0,"TimeT9",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT9",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT9",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT9",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT9",OBJPROP_TOOLTIP,TimeOH[9]+":"+TimeOM[9]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE9");
   ObjectCreate(0,"TimeE9",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE9",OBJPROP_TOOLTIP,TimeOH[9]+":"+TimeOM[9]);
   ObjectSetInteger(0,"TimeE9",OBJPROP_COLOR,event_color);  
   
}      


   saat = Time10;
   dakika = Time10dk;
   
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+saat+":"+dakika;
  some_time = StringToTime(yenitarih);

   ObjectDelete(0,"TimeT10");
   ObjectCreate(0,"TimeT10",OBJ_VLINE,0,some_time,Ask);
   ObjectSetInteger(0,"TimeT10",OBJPROP_BACK,true); 
   ObjectSetInteger(0,"TimeT10",OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"TimeT10",OBJPROP_STYLE,STYLE_DASHDOTDOT);  
   ObjectSetString(0,"TimeT10",OBJPROP_TOOLTIP,TimeOH[10]+":"+TimeOM[10]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE10");
   ObjectCreate(0,"TimeE10",OBJ_EVENT,0,some_time,0);
   ObjectSetString(0,"TimeE10",OBJPROP_TOOLTIP,TimeOH[10]+":"+TimeOM[10]);
   ObjectSetInteger(0,"TimeE10",OBJPROP_COLOR,event_color);  
   
}      















//Sira Bulma
 //datetime some_time=D'2017.03.10 20:59';
  //shift=iBarShift(sym,PERIOD_M1,some_time);
  //Alert("index of the bar for the time ",TimeToStr(some_time)," is ",shift);
  
  
  
  
  
  int defaul_time=PERIOD_M5;
  int toplam_dakika=Bars*Period(); // M1
  if ( defaul_time != PERIOD_M1 ) {
  toplam_dakika=Bars;
  }
  toplam_dakika=5000;
  
  //defaul_time=Period();
  
 int last_shift,shift;
 int last_shifts,shifts;
 int last_shiftn,shiftn; 
 int last_shiftsd,shiftsd;
 int last_shiftf,shiftf;

 
 
//for (int t=(Bars-100);t>=1;t--) {
for (int t=(toplam_dakika);t>=1;t--) {
   
   //datetime times = Time[t];
   datetime times = iTime(Symbol(),defaul_time,t);
   

   int timeh = TimeHour(times);
   int timedk = TimeMinute(times);
   
   //Print(times,"/",timeh,"/",timedk,"/",Period(),"/",toplam_dakika,"/",Bars);
   
   
   //int timeh = TimeHour(times);
   //int timedk = TimeMinute(times);
   
   if ( timeh == Time1 && timedk == Time1dk ) {
   
   
   last_shift=iBarShift(Symbol(),defaul_time,times);
   
   ObjectDelete(0,"Time9-"+t);
   ObjectCreate(0,"Time9-"+t,OBJ_VLINE,0,times,Ask);
   ObjectSetInteger(0,"Time9-"+t,OBJPROP_BACK,true); 
   ObjectSetInteger(0,"Time9-"+t,OBJPROP_COLOR,clrBlack);   
   ObjectSetInteger(0,"Time9-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);    
   ObjectSetString(0,"Time9-"+t,OBJPROP_TOOLTIP,TimeOH[1]+":"+TimeOM[1]);

if ( event_icon == true ) {   
   ObjectDelete(0,"TimeE9-"+t);
   ObjectCreate(0,"TimeE9-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE9-"+t,OBJPROP_TOOLTIP,TimeOH[1]+":"+TimeOM[1]);
   ObjectSetInteger(0,"TimeE9-"+t,OBJPROP_COLOR,event_color);      
}   
   
   }
   
   if ( timeh == Time2 && timedk == Time2dk ) {
   
   shift=iBarShift(Symbol(),defaul_time,times);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   for(int s=shift;s<=last_shift;s++) {
   
   if ( iLow(Symbol(),defaul_time,s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=iLow(Symbol(),defaul_time,s);
   }
   
   if ( iHigh(Symbol(),defaul_time,s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=iHigh(Symbol(),defaul_time,s);
   }
      
   
   
   }
   
   
  /*int Trend_Screen_High_Shift = iHighest(Symbol(),defaul_time,MODE_HIGH,(last_shift-shift),last_shift);
  int Trend_Screen_Low_Shift = iLowest(Symbol(),defaul_time,MODE_LOW,(last_shift-shift),last_shift);*/
   
   //if ( TimeDayOfWeek(TimeDay(times)) != 5 && TimeDayOfWeek(TimeDay(iTime(Symbol(),defaul_time,last_shift))) != 1 ) {
   if ( int(TimeDay(iTime(Symbol(),defaul_time,shift))) == int(TimeDay(iTime(Symbol(),defaul_time,last_shift))) ) {
   //ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,shift),iHigh(Symbol(),defaul_time,Trend_Screen_High_Shift),iTime(Symbol(),defaul_time,last_shift),iLow(Symbol(),defaul_time,Trend_Screen_Low_Shift));
   ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,last_shift),high_price,iTime(Symbol(),defaul_time,shift),low_price);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),"Tokyo"+t,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_WIDTH,2);
   
   tokyo_high=high_price;
   tokyo_low=low_price;
   
   
   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50   
   
//datetime times = iTime(Symbol(),defaul_time,t);

  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(iTime(Symbol(),defaul_time,shift))+" "+23+":"+55;
  some_time = StringToTime(yenitarih);
  
  //shift=last_shift;
  //last_shift=iBarShift(Symbol(),defaul_time,some_time);
  

  
  

  string name="TokyoLevel"+t;
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
    
  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkBlue); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
  
   

  level=level45;
  levels="45";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),level,iTime(Symbol(),defaul_time,shift),level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
   
  level=level55;
  levels="55";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),level,iTime(Symbol(),defaul_time,shift),level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
 level=level79;
  levels="79";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),level,iTime(Symbol(),defaul_time,shift),level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
    
 level=level70;
  levels="70";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),level,iTime(Symbol(),defaul_time,shift),level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level21;
  levels="21";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),level,iTime(Symbol(),defaul_time,shift),level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level30;
  levels="30";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),level,iTime(Symbol(),defaul_time,shift),level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         





  level=level168;
  levels="u168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),high_price+level,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),high_price+level,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level272;
  levels="u272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),high_price+level,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
    
  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),high_price+level,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
     


  level=level168;
  levels="d168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),low_price-level,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
     
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),low_price-level,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),low_price-level,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
    
  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),low_price-level,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  
   
   
   
   }
   
   
   ObjectDelete(0,"Time10-"+t);
   ObjectCreate(0,"Time10-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time10-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time10-"+t,OBJPROP_COLOR,clrDarkGray);
   ObjectSetInteger(0,"Time10-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time10-"+t,OBJPROP_TOOLTIP,TimeOH[2]+":"+TimeOM[2]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE10-"+t);
   ObjectCreate(0,"TimeE10-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE10-"+t,OBJPROP_TOOLTIP,TimeOH[1]+":"+TimeOM[1]);
   ObjectSetInteger(0,"TimeE10-"+t,OBJPROP_COLOR,event_color);      
   
}
   
   }
/////////////////////////////   
   
   
   continue;
   
   
   if ( timeh == Time3 && timedk == Time3dk ) {
   
   last_shifts=iBarShift(Symbol(),defaul_time,times);
   
   
   ObjectDelete(0,"Time15-"+t);
   ObjectCreate(0,"Time15-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time15-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time15-"+t,OBJPROP_COLOR,clrDarkGray);
   ObjectSetInteger(0,"Time15-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time15-"+t,OBJPROP_TOOLTIP,TimeOH[3]+":"+TimeOM[3]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE15-"+t);
   ObjectCreate(0,"TimeE15-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE15-"+t,OBJPROP_TOOLTIP,TimeOH[3]+":"+TimeOM[3]);
   ObjectSetInteger(0,"TimeE15-"+t,OBJPROP_COLOR,event_color);     
}   
   
   }   
   
   if ( timeh == Time4 && timedk == Time4dk ) {
   
   

   shifts=iBarShift(Symbol(),defaul_time,times);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   for(int s=shifts;s<=last_shifts;s++) {
   
   if ( iLow(Symbol(),defaul_time,s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=iLow(Symbol(),defaul_time,s);
   }
   
   if ( iHigh(Symbol(),defaul_time,s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=iHigh(Symbol(),defaul_time,s);
   }
      
   
   
   }
   
   
  /*int Trend_Screen_High_Shift = iHighest(Symbol(),defaul_time,MODE_HIGH,(last_shift-shift),last_shift);
  int Trend_Screen_Low_Shift = iLowest(Symbol(),defaul_time,MODE_LOW,(last_shift-shift),last_shift);*/
   
   //if ( TimeDayOfWeek(TimeDay(times)) != 5 && TimeDayOfWeek(TimeDay(iTime(Symbol(),defaul_time,last_shift))) != 1 ) {
   if ( int(TimeDay(iTime(Symbol(),defaul_time,shifts))) == int(TimeDay(iTime(Symbol(),defaul_time,last_shifts))) ) {
   //ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,shift),iHigh(Symbol(),defaul_time,Trend_Screen_High_Shift),iTime(Symbol(),defaul_time,last_shift),iLow(Symbol(),defaul_time,Trend_Screen_Low_Shift));
   ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,last_shifts),high_price,iTime(Symbol(),defaul_time,shifts),low_price);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_COLOR,clrLightBlue);
   ObjectSetString(ChartID(),"Tokyo"+t,OBJPROP_TOOLTIP,"LONDON");
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_WIDTH,2);
   
london_high=high_price;  
london_low=low_price;
  
   

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50   


  string name="TokyoLevel"+t;
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shifts),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrWhite);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"LONDON EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4);

  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shifts),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkRed); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"LONDON EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
  

double session_high;
double session_low;


if ( london_high > tokyo_high ) {
session_high=london_high;
} else {
session_high=tokyo_high;
}


if ( london_low < tokyo_low ) {
session_low=london_low;
} else {
session_high=tokyo_low;
}


double seq=session_low+((session_high-session_low)/2);


  name="TokyoLevel"+t;
  ObjectDelete(ChartID(),name+"EqTL");
  ObjectCreate(ChartID(),name+"EqTL",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),seq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),seq);
  ObjectSetInteger(ChartID(),name+"EqTL",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"EqTL",OBJPROP_COLOR,clrWhite);   
  ObjectSetString(ChartID(),name+"EqTL",OBJPROP_TOOLTIP,"TOKYO LONDON EQ");   
  ObjectSetInteger(ChartID(),name+"EqTL",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"EqTL",OBJPROP_WIDTH,4);
       
  ObjectDelete(ChartID(),name+"EqTLs");
  ObjectCreate(ChartID(),name+"EqTLs",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shift),seq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),seq);
  ObjectSetInteger(ChartID(),name+"EqTLs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"EqTLs",OBJPROP_COLOR,clrChartreuse); 
  ObjectSetInteger(ChartID(),name+"EqTLs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"EqTLs",OBJPROP_TOOLTIP,"TOKYO LONDON EQ");   
  ObjectSetInteger(ChartID(),name+"EqTLs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"EqTLs",OBJPROP_WIDTH,2);
     
   
   
   }
   
      
   
   ObjectDelete(0,"Time01-"+t);
   ObjectCreate(0,"Time01-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time01-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time01-"+t,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(0,"Time01-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time01-"+t,OBJPROP_TOOLTIP,TimeOH[4]+":"+TimeOM[4]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE01-"+t);
   ObjectCreate(0,"TimeE01-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE01-"+t,OBJPROP_TOOLTIP,TimeOH[4]+":"+TimeOM[4]);
   ObjectSetInteger(0,"TimeE01-"+t,OBJPROP_COLOR,event_color);     
}
   
   } 
   
   
   if ( timeh == Time5 && timedk == Time5dk ) {
   
   last_shiftn=iBarShift(Symbol(),defaul_time,times);
   
   
   ObjectDelete(0,"Time0155-"+t);
   ObjectCreate(0,"Time0155-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time0155-"+t,OBJPROP_TOOLTIP,TimeOH[5]+":"+TimeOM[5]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE01-"+t);
   ObjectCreate(0,"TimeE01-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE01-"+t,OBJPROP_TOOLTIP,TimeOH[5]+":"+TimeOM[5]);
   ObjectSetInteger(0,"TimeE01-"+t,OBJPROP_COLOR,event_color);     
}
   
   } 
   


   if ( timeh == Time6 && timedk == Time6dk ) {
   
   


   shiftn=iBarShift(Symbol(),defaul_time,times);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   for(int s=shiftn;s<=last_shiftn;s++) {
   
   if ( iLow(Symbol(),defaul_time,s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=iLow(Symbol(),defaul_time,s);
   }
   
   if ( iHigh(Symbol(),defaul_time,s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=iHigh(Symbol(),defaul_time,s);
   }
      
   
   
   }
   
   
  /*int Trend_Screen_High_Shift = iHighest(Symbol(),defaul_time,MODE_HIGH,(last_shift-shift),last_shift);
  int Trend_Screen_Low_Shift = iLowest(Symbol(),defaul_time,MODE_LOW,(last_shift-shift),last_shift);*/
   
   //if ( TimeDayOfWeek(TimeDay(times)) != 5 && TimeDayOfWeek(TimeDay(iTime(Symbol(),defaul_time,last_shift))) != 1 ) {
   if ( int(TimeDay(iTime(Symbol(),defaul_time,shiftn))) == int(TimeDay(iTime(Symbol(),defaul_time,last_shiftn))) ) {
   //ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,shift),iHigh(Symbol(),defaul_time,Trend_Screen_High_Shift),iTime(Symbol(),defaul_time,last_shift),iLow(Symbol(),defaul_time,Trend_Screen_Low_Shift));
   ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,last_shiftn),high_price,iTime(Symbol(),defaul_time,shiftn),low_price);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_COLOR,clrLightGreen);
   ObjectSetString(ChartID(),"Tokyo"+t,OBJPROP_TOOLTIP,"NEWYORK");
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_BACK,false);
   
newyork_high=high_price;  
newyork_low=low_price;
  
   

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50   


  string name="TokyoLevel"+t;
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrWhite);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"NEWYORK EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4);

  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkGreen); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"NEWYORK EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
  
  

double session_high;
double session_low;


if ( london_high > newyork_high ) {
session_high=london_high;
} else {
session_high=newyork_high;
}


if ( london_low < newyork_low ) {
session_low=london_low;
} else {
session_high=newyork_low;
}


double seq=session_low+((session_high-session_low)/2);


  name="TokyoLevel"+t;
  ObjectDelete(ChartID(),name+"EqTLn");
  ObjectCreate(ChartID(),name+"EqTLn",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),seq,iTime(Symbol(),defaul_time,shift)+(tsp*2)*PeriodSeconds(),seq);
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_COLOR,clrWhite);   
  ObjectSetString(ChartID(),name+"EqTL",OBJPROP_TOOLTIP,"LONDON NEWYORK EQ");   
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_WIDTH,4);
       
  ObjectDelete(ChartID(),name+"EqTLsn");
  ObjectCreate(ChartID(),name+"EqTLsn",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),seq,iTime(Symbol(),defaul_time,shift)+(tsp*2)*PeriodSeconds(),seq);
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_COLOR,clrMagenta); 
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"EqTLsn",OBJPROP_TOOLTIP,"LONDON NEWTORK EQ");   
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_WIDTH,2);
     
        

   
   }
   
      
   
   ObjectDelete(0,"Time0166-"+t);
   ObjectCreate(0,"Time0166-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time0166-"+t,OBJPROP_TOOLTIP,TimeOH[6]+":"+TimeOM[6]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE0166-"+t);
   ObjectCreate(0,"TimeE0166-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE0166-"+t,OBJPROP_TOOLTIP,TimeOH[6]+":"+TimeOM[6]);
   ObjectSetInteger(0,"TimeE0166-"+t,OBJPROP_COLOR,event_color);     
}
   
   }    
//////////////////////////
// Sidney
/////////////////////////////

   if ( timeh == Time7 && timedk == Time7dk ) {
   
   last_shiftsd=iBarShift(Symbol(),defaul_time,times);
   
   
   ObjectDelete(0,"Time0155-"+t);
   ObjectCreate(0,"Time0155-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time0155-"+t,OBJPROP_TOOLTIP,TimeOH[7]+":"+TimeOM[7]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE01-"+t);
   ObjectCreate(0,"TimeE01-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE01-"+t,OBJPROP_TOOLTIP,TimeOH[7]+":"+TimeOM[7]);
   ObjectSetInteger(0,"TimeE01-"+t,OBJPROP_COLOR,event_color);     
}
   
   } 
   
   
   


   if ( timeh == Time8 && timedk == Time8dk ) {
   
   int last_shiftns=last_shiftsd;
 
   int shiftns=iBarShift(Symbol(),defaul_time,times);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   for(int s=shiftns;s<=last_shiftns;s++) {
   
   if ( iLow(Symbol(),defaul_time,s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=iLow(Symbol(),defaul_time,s);
   }
   
   if ( iHigh(Symbol(),defaul_time,s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=iHigh(Symbol(),defaul_time,s);
   }
      
   
   
   }
   
   
   int ext_fark_shift=((PERIOD_H1*60)*2)/PeriodSeconds();
   
  /*int Trend_Screen_High_Shift = iHighest(Symbol(),defaul_time,MODE_HIGH,(last_shift-shift),last_shift);
  int Trend_Screen_Low_Shift = iLowest(Symbol(),defaul_time,MODE_LOW,(last_shift-shift),last_shift);*/
   
   //if ( TimeDayOfWeek(TimeDay(times)) != 5 && TimeDayOfWeek(TimeDay(iTime(Symbol(),defaul_time,last_shift))) != 1 ) {
   if ( int(TimeDay(iTime(Symbol(),defaul_time,shiftns))) == int(TimeDay(iTime(Symbol(),defaul_time,last_shiftns))) ) {
   //ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,shift),iHigh(Symbol(),defaul_time,Trend_Screen_High_Shift),iTime(Symbol(),defaul_time,last_shift),iLow(Symbol(),defaul_time,Trend_Screen_Low_Shift));
   ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,last_shiftns+ext_fark_shift),high_price,iTime(Symbol(),defaul_time,shiftns),low_price);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_COLOR,clrLightYellow);
   ObjectSetString(ChartID(),"Tokyo"+t,OBJPROP_TOOLTIP,"SYDNEY");
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_STYLE,STYLE_DOT);
   
newyork_high=high_price;  
newyork_low=low_price;
  
   

   double yuzde = DivZero(high_price-low_price,100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50   

/*
  string name="TokyoLevel"+t;
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eqsd");
  ObjectCreate(ChartID(),name+"Eqsd",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eqsd",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqsd",OBJPROP_COLOR,clrWhite);   
  ObjectSetString(ChartID(),name+"Eqsd",OBJPROP_TOOLTIP,"SYDNEY");   
  ObjectSetInteger(ChartID(),name+"Eqsd",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqsd",OBJPROP_WIDTH,4);

  ObjectDelete(ChartID(),name+"Eqssd");
  ObjectCreate(ChartID(),name+"Eqssd",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eqssd",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqssd",OBJPROP_COLOR,clrDarkGreen); 
  ObjectSetInteger(ChartID(),name+"Eqssd",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqssd",OBJPROP_TOOLTIP,"SYDNEY");   
  ObjectSetInteger(ChartID(),name+"Eqssd",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqssd",OBJPROP_WIDTH,2);*/
  
  
/*
double session_high;
double session_low;


if ( london_high > newyork_high ) {
session_high=london_high;
} else {
session_high=newyork_high;
}


if ( london_low < newyork_low ) {
session_low=london_low;
} else {
session_high=newyork_low;
}


double seq=session_low+((session_high-session_low)/2);


  name="TokyoLevel"+t;
  ObjectDelete(ChartID(),name+"EqTLn");
  ObjectCreate(ChartID(),name+"EqTLn",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),seq,iTime(Symbol(),defaul_time,shift)+(tsp*2)*PeriodSeconds(),seq);
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_COLOR,clrWhite);   
  ObjectSetString(ChartID(),name+"EqTL",OBJPROP_TOOLTIP,"LONDON NEWYORK EQ");   
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_WIDTH,4);
       
  ObjectDelete(ChartID(),name+"EqTLsn");
  ObjectCreate(ChartID(),name+"EqTLsn",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),seq,iTime(Symbol(),defaul_time,shift)+(tsp*2)*PeriodSeconds(),seq);
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_COLOR,clrMagenta); 
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"EqTLsn",OBJPROP_TOOLTIP,"LONDON NEWTORK EQ");   
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_WIDTH,2);*/
     
        

   
   }
   
      
   
   ObjectDelete(0,"Time0166-"+t);
   ObjectCreate(0,"Time0166-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time0166-"+t,OBJPROP_TOOLTIP,TimeOH[7]+":"+TimeOM[7]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE0166-"+t);
   ObjectCreate(0,"TimeE0166-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE0166-"+t,OBJPROP_TOOLTIP,TimeOH[6]+":"+TimeOM[6]);
   ObjectSetInteger(0,"TimeE0166-"+t,OBJPROP_COLOR,event_color);     
}
   
   }    
//////////////////////////



//////////////////////////
// Frankfurt
/////////////////////////////

   if ( timeh == Time9 && timedk == Time9dk ) {
   
   last_shiftf=iBarShift(Symbol(),defaul_time,times);
   
   
   ObjectDelete(0,"Time0155-"+t);
   ObjectCreate(0,"Time0155-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(0,"Time0155-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time0155-"+t,OBJPROP_TOOLTIP,TimeOH[9]+":"+TimeOM[9]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE01-"+t);
   ObjectCreate(0,"TimeE01-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE01-"+t,OBJPROP_TOOLTIP,TimeOH[9]+":"+TimeOM[9]);
   ObjectSetInteger(0,"TimeE01-"+t,OBJPROP_COLOR,event_color);     
}
   
   } 
   
   
   


   if ( timeh == Time10 && timedk == Time10dk ) {
   
   int last_shiftnf=last_shiftf;
 
   int shiftnf=iBarShift(Symbol(),defaul_time,times);
   
   double low_price=1000000;
   double high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   for(int s=shiftnf;s<=last_shiftnf;s++) {
   
   if ( iLow(Symbol(),defaul_time,s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=iLow(Symbol(),defaul_time,s);
   }
   
   if ( iHigh(Symbol(),defaul_time,s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=iHigh(Symbol(),defaul_time,s);
   }
      
   
   
   }
   
   
  /*int Trend_Screen_High_Shift = iHighest(Symbol(),defaul_time,MODE_HIGH,(last_shift-shift),last_shift);
  int Trend_Screen_Low_Shift = iLowest(Symbol(),defaul_time,MODE_LOW,(last_shift-shift),last_shift);*/
   
   //if ( TimeDayOfWeek(TimeDay(times)) != 5 && TimeDayOfWeek(TimeDay(iTime(Symbol(),defaul_time,last_shift))) != 1 ) {
   if ( int(TimeDay(iTime(Symbol(),defaul_time,shiftnf))) == int(TimeDay(iTime(Symbol(),defaul_time,last_shiftnf))) ) {
   //ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,shift),iHigh(Symbol(),defaul_time,Trend_Screen_High_Shift),iTime(Symbol(),defaul_time,last_shift),iLow(Symbol(),defaul_time,Trend_Screen_Low_Shift));
   ObjectCreate(ChartID(),"Tokyo"+t,OBJ_RECTANGLE,0,iTime(Symbol(),defaul_time,last_shiftnf),high_price,iTime(Symbol(),defaul_time,shiftnf),low_price);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_COLOR,clrYellow);
   ObjectSetString(ChartID(),"Tokyo"+t,OBJPROP_TOOLTIP,"FRANKFURT");
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),"Tokyo"+t,OBJPROP_STYLE,STYLE_DOT);
   
newyork_high=high_price;  
newyork_low=low_price;
  
   

   double yuzde = DivZero(high_price-low_price,100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50   

/*
  string name="TokyoLevel"+t;
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eqsf");
  ObjectCreate(ChartID(),name+"Eqsd",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eqsf",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqsf",OBJPROP_COLOR,clrWhite);   
  ObjectSetString(ChartID(),name+"Eqsf",OBJPROP_TOOLTIP,"FRANKFURT");   
  ObjectSetInteger(ChartID(),name+"Eqsf",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqsf",OBJPROP_WIDTH,4);

  ObjectDelete(ChartID(),name+"Eqssf");
  ObjectCreate(ChartID(),name+"Eqssf",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),eq,iTime(Symbol(),defaul_time,shift)+tsp*PeriodSeconds(),eq);
  ObjectSetInteger(ChartID(),name+"Eqssf",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqssf",OBJPROP_COLOR,clrDarkGreen); 
  ObjectSetInteger(ChartID(),name+"Eqssf",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqssdf",OBJPROP_TOOLTIP,"FRANKFURT");   
  ObjectSetInteger(ChartID(),name+"Eqssf",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqssf",OBJPROP_WIDTH,2);*/
  
  
/*
double session_high;
double session_low;


if ( london_high > newyork_high ) {
session_high=london_high;
} else {
session_high=newyork_high;
}


if ( london_low < newyork_low ) {
session_low=london_low;
} else {
session_high=newyork_low;
}


double seq=session_low+((session_high-session_low)/2);


  name="TokyoLevel"+t;
  ObjectDelete(ChartID(),name+"EqTLn");
  ObjectCreate(ChartID(),name+"EqTLn",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),seq,iTime(Symbol(),defaul_time,shift)+(tsp*2)*PeriodSeconds(),seq);
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_COLOR,clrWhite);   
  ObjectSetString(ChartID(),name+"EqTL",OBJPROP_TOOLTIP,"LONDON NEWYORK EQ");   
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"EqTLn",OBJPROP_WIDTH,4);
       
  ObjectDelete(ChartID(),name+"EqTLsn");
  ObjectCreate(ChartID(),name+"EqTLsn",OBJ_TREND,0,iTime(Symbol(),defaul_time,last_shiftn),seq,iTime(Symbol(),defaul_time,shift)+(tsp*2)*PeriodSeconds(),seq);
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_COLOR,clrMagenta); 
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"EqTLsn",OBJPROP_TOOLTIP,"LONDON NEWTORK EQ");   
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"EqTLsn",OBJPROP_WIDTH,2);*/
     
        

   
   }
   
      
   
   ObjectDelete(0,"Time0166-"+t);
   ObjectCreate(0,"Time0166-"+t,OBJ_VLINE,0,times,Ask); 
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_BACK,true);    
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_COLOR,clrDarkRed);
   ObjectSetInteger(0,"Time0166-"+t,OBJPROP_STYLE,STYLE_DASHDOTDOT);     
   ObjectSetString(0,"Time0166-"+t,OBJPROP_TOOLTIP,TimeOH[7]+":"+TimeOM[7]);

if ( event_icon == true ) {
   ObjectDelete(0,"TimeE0166-"+t);
   ObjectCreate(0,"TimeE0166-"+t,OBJ_EVENT,0,times,0);
   ObjectSetString(0,"TimeE0166-"+t,OBJPROP_TOOLTIP,TimeOH[6]+":"+TimeOM[6]);
   ObjectSetInteger(0,"TimeE0166-"+t,OBJPROP_COLOR,event_color);     
}
   
   }    
//////////////////////////      
     
     
     
     
     
     
     
     
     
     
     
     
      
   
      
  }   
  
    
   
   
   
      Comment(TimeHour(TimeLocal()),"/",TimeHour(TimeCurrent()),"=",time_saat_farki,"/",time_dakika_farki);
   

}

bool time_line=false;
color event_color = clrLightSlateGray;
int tsp=145;