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
   
   DailyCycle();
   
   
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

   ObjectsDeleteAll();

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