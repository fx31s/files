//+------------------------------------------------------------------+
//|                                                     Pattern5.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string last_select_object;

bool mode=false;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
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

//Print(sparam);

if ( sparam == 50 ) {

if ( mode == false ) {mode=true;}else{mode=false;}

Comment("Mode:",mode);

}

if ( sparam == 45 ) ObjectsDeleteAll(ChartID(),-1,-1);

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Trendx",0) != -1 ) {
      
string select_object=sparam;
string select_object_y=sparam;
string select_object_l=sparam;
string select_object_q=sparam;
int rplc=StringReplace(select_object_y,"Trendx","Trendy");
int rplcl=StringReplace(select_object_l,"Trendx","Trendl");
int rplcq=StringReplace(select_object_q,"Trendx","Trendq");

          
          datetime obj_time1 = ObjectGetInteger(ChartID(),select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),select_object,OBJPROP_TIME,1);
          double obj_prc1 = ObjectGetDouble(ChartID(),select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),select_object,OBJPROP_PRICE,1);

          datetime obj_time1_y = ObjectGetInteger(ChartID(),select_object_y,OBJPROP_TIME,0);
          datetime obj_time2_y = ObjectGetInteger(ChartID(),select_object_y,OBJPROP_TIME,1);
          double obj_prc1_y = ObjectGetDouble(ChartID(),select_object_y,OBJPROP_PRICE,0);
          double obj_prc2_y = ObjectGetDouble(ChartID(),select_object_y,OBJPROP_PRICE,1);

          datetime obj_time1_l = ObjectGetInteger(ChartID(),select_object_l,OBJPROP_TIME,0);
          datetime obj_time2_l = ObjectGetInteger(ChartID(),select_object_l,OBJPROP_TIME,1);
          double obj_prc1_l = ObjectGetDouble(ChartID(),select_object_l,OBJPROP_PRICE,0);
          double obj_prc2_l = ObjectGetDouble(ChartID(),select_object_l,OBJPROP_PRICE,1);

         datetime obj_time1_q = ObjectGetInteger(ChartID(),select_object_q,OBJPROP_TIME,0);
          datetime obj_time2_q = ObjectGetInteger(ChartID(),select_object_q,OBJPROP_TIME,1);
          double obj_prc1_q = ObjectGetDouble(ChartID(),select_object_q,OBJPROP_PRICE,0);
          double obj_prc2_q = ObjectGetDouble(ChartID(),select_object_q,OBJPROP_PRICE,1);

Print(select_object);


double high_price;
double low_price;



if ( obj_prc1 > obj_prc2 ) {

//Alert("Selam");


int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),select_object,0,obj_time1,High[shift]);
high_price=High[shift];
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),select_object,1,obj_time2,Low[shift]);
low_price=Low[shift];


ObjectMove(ChartID(),select_object_y,0,obj_time2,Low[shift]);
ObjectMove(ChartID(),select_object_y,1,obj_time2+(obj_time2_y-obj_time1_y),Low[shift]+(obj_prc2_y-obj_prc1_y));

ObjectMove(ChartID(),select_object_l,0,obj_time2+(obj_time2_y-obj_time1_y),Low[shift]+(obj_prc2_y-obj_prc1_y));
ObjectMove(ChartID(),select_object_l,1,obj_time2+((obj_time2_y-obj_time1_y)*9),Low[shift]+(obj_prc2_y-obj_prc1_y));

ObjectMove(ChartID(),select_object_q,0,obj_time2+(obj_time2_y-obj_time1_y),Low[shift]+(obj_prc2_y-obj_prc1_y));
ObjectMove(ChartID(),select_object_q,1,(obj_time2+((obj_time2_y-obj_time1_y))+(obj_time2-obj_time1)),(Low[shift]+(obj_prc2_y-obj_prc1_y))-(high_price-low_price));


//datetime ty_start_time=obj_time1;
//datetime ty_end_time=obj_time1+300*PeriodSeconds();

datetime ty_start_time=obj_time2;
datetime ty_end_time=obj_time2+300*PeriodSeconds();

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   double level50=low_price+yuzde*50; // 50
   double level786=low_price+yuzde*78.6; // 50
   double level618s=low_price+yuzde*61.8; // 50
   
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level382=yuzde*38.2; // 38.2
   double level342=yuzde*34.2; // 50      
   double level1240=yuzde*124; // 50      
   //double level786=yuzde*78.6; // 50
   //double level500=yuzde*50; // 50
   
   
   double level0=0;
   double level100=0;    
   
   double level;
   string levels;
   string name=last_select_object+"Pattern5 ";
    
   
  level=level618s;
  levels="x618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level618s,ty_end_time,level618s);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);

  level=level786;
  levels="x786";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level786,ty_end_time,level786);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

  level=level50;
  levels="x50";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level50,ty_end_time,level50);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
/*
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
*/

  level=level0;
  levels="xd000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);   
      
       
       }
          


/////////////////////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////////////////////
if ( obj_prc2 > obj_prc1 ) {

//Alert("Selam");

int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),select_object,0,obj_time1,Low[shift]);
low_price=Low[shift];
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),select_object,1,obj_time2,High[shift]);
high_price=High[shift];



ObjectMove(ChartID(),select_object_y,0,obj_time2,High[shift]);
ObjectMove(ChartID(),select_object_y,1,obj_time2+(obj_time2_y-obj_time1_y),High[shift]-(obj_prc1_y-obj_prc2_y));

ObjectMove(ChartID(),select_object_l,0,obj_time2+(obj_time2_y-obj_time1_y),High[shift]-(obj_prc1_y-obj_prc2_y));
ObjectMove(ChartID(),select_object_l,1,obj_time2+((obj_time2_y-obj_time1_y)*9),High[shift]-(obj_prc1_y-obj_prc2_y));

ObjectMove(ChartID(),select_object_q,0,obj_time2+(obj_time2_y-obj_time1_y),High[shift]-(obj_prc1_y-obj_prc2_y));
ObjectMove(ChartID(),select_object_q,1,(obj_time2+((obj_time2_y-obj_time1_y))+(obj_time2-obj_time1)),(High[shift]-(obj_prc1_y-obj_prc2_y))+(high_price-low_price));


//datetime ty_start_time=obj_time1;
//datetime ty_end_time=obj_time1+300*PeriodSeconds();

datetime ty_start_time=obj_time2;
datetime ty_end_time=obj_time2+300*PeriodSeconds();

   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=high_price-yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=high_price-yuzde*70; // 50
   double level79=high_price-yuzde*79; // 50
   double level21=high_price-yuzde*21; // 50
   double level30=high_price-yuzde*30; // 50
   double level50=high_price-yuzde*50; // 50
   double level786=high_price-yuzde*78.6; // 50
   double level618s=high_price-yuzde*61.8; // 50
   
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level382=yuzde*38.2; // 38.2
   double level342=yuzde*34.2; // 50      
   double level1240=yuzde*124; // 50      
   //double level786=yuzde*78.6; // 50
   //double level500=yuzde*50; // 50
   
   
   double level0=0;
   double level100=0;    
   
   double level;
   string levels;
   string name=last_select_object+"Pattern5 ";
    
   
  level=level618s;
  levels="x618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level618s,ty_end_time,level618s);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);

  level=level786;
  levels="x786";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level786,ty_end_time,level786);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

  level=level50;
  levels="x50";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level50,ty_end_time,level50);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
/*
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
*/

  level=level100;
  levels="xd000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price-level,ty_end_time,high_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);   
      
       
       }













}


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Trendx",0) == -1 && StringFind(sparam,"Level",0) == -1 ) {

Comment("Trend:",sparam);

last_select_object=sparam;

          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);

double high_price;
double low_price;

if ( obj_prc1 > obj_prc2 ) {

//Alert("Selam");


int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),last_select_object,0,obj_time1,High[shift]);
high_price=High[shift];
obj_prc1=high_price;
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),last_select_object,1,obj_time2,Low[shift]);
low_price=Low[shift];
obj_prc2=low_price;



   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   double level50=low_price+yuzde*50; // 50
   double level786=low_price+yuzde*78.6; // 50
   double level618s=low_price+yuzde*61.8; // 50
   
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level382=yuzde*38.2; // 38.2
   double level342=yuzde*34.2; // 50      
   double level1240=yuzde*124; // 50      
   //double level786=yuzde*78.6; // 50
   //double level500=yuzde*50; // 50
   
   
   double level0=0;
   double level100=0; 

string name=last_select_object+"Pattern5 ";

datetime ty_start_time=obj_time1;
datetime ty_end_time=obj_time1+300*PeriodSeconds();

double level;
string levels;

//if ( mode == false ) {

  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level0;
  levels="d000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2,low_price-level,obj_time2+10*PeriodSeconds(),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  
  
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  double price=low_price-level;

  level=level1240;
  levels="d1240";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


int z1=8;
int z2=16;
int z3=64;
///////////////////////////////////////////////////////
if ( (obj_time1-obj_time2)/PeriodSeconds() > 10 ) {
z1=4;
z2=8;
z3=12;
 }
 
 

  level=level1240;
  levels="df1240";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time1,high_price,obj_time2+((obj_time1-obj_time2)*z1),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);


  level=level618;
  levels="df618";  
           double yuzdes = DivZero(high_price-(low_price-level1240), 100);   
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z1),low_price-level1240,obj_time2+((obj_time1-obj_time2)*z2),(low_price-level1240)+yuzdes*61.8);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
  
  
  level=level618;
  levels="dfabcd";  
           //double yuzdes = DivZero(high_price-(low_price-level1240), 100);   
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z1),low_price-level1240,obj_time2+((obj_time1-obj_time2)*z2),(low_price-level1240)+(obj_prc1-obj_prc2));
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
  
    
  
  
  level=level618;
  levels="dff1240";  
           //double yuzdes = DivZero(high_price-(low_price-level1240), 100);
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  //ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*16),(low_price-level1240)+yuzdes*61.8,obj_time2+((obj_time1-obj_time2)*64),((low_price-level1240)+yuzdes*61.8)-(high_price-(low_price-level1240)));
  if ( obj_time2+((obj_time1-obj_time2)*z3) < TimeCurrent() ) ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z2),(low_price-level1240)+yuzdes*61.8,obj_time2+((obj_time1-obj_time2)*z3),((low_price-level1240)+yuzdes*61.8)-(high_price-(low_price-level1240)));
  if ( obj_time2+((obj_time1-obj_time2)*z3) > TimeCurrent() ) ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z2),(low_price-level1240)+yuzdes*61.8,Time[0],((low_price-level1240)+yuzdes*61.8)-(high_price-(low_price-level1240)));  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
  
    
      




//}
       
shift=iBarShift(Symbol(),Period(),obj_time1);

ObjectDelete(ChartID(),"v");
ObjectCreate(ChartID(),"v",OBJ_VLINE,0,Time[shift],Ask);
ObjectSetInteger(ChartID(),"v",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"v",OBJPROP_WIDTH,2);

int say=0;
bool first=false;
bool find=false;
int last_i=0;


datetime up_time=ty_start_time;
      
for (int i=shift;i>0;i--){

ObjectDelete(ChartID(),"v"+i);

if ( first==false && price > Low[i]) {
if ( low_price > Low[i] ) {
Print(low_price,"/",Low[i]);
//ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);
low_price=Low[i];
ty_start_time=Time[i];
ty_end_time=Time[i]+500*PeriodSeconds();
last_i=i;
//first=true;


/*
say=0;


for (int r=i;r>i-50;r--){

if ( r < 0 ) continue;

if ( low_price < Low[r] ) {
say=say+1;
if ( say == 20 ) find=true;
ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);
} else {
say=0;
}


}
*/

}


if ( last_i-i > 10 ) {
first=true;
}

/*
if ( first == true ) {

if ( find==false ) {
if ( low_price > Low[i] ) {
low_price=Low[i];
ty_end_time=Time[i];
say=0;
Print(i);
} else {
say=say+1;
Print(i);
if ( say == 10 ) find=true;
ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);


}
}

}
*/


}



/*
if ( find==false ) {
if ( low_price > Low[i] ) {
low_price=Low[i];
ty_end_time=Time[i];
say=0;

Print(i);

} else {
say=say+1;
//Print(i);
if ( say == 10 ) find=true;

//ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);


}
}
*/


}

  level=level618s;
  levels="Trendx";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,up_time,high_price,ty_start_time,low_price);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,up_time,high_price,ty_start_time,low_price);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,true);  
  ObjectSetString(ChartID(),name+"LevelT"+levels,OBJPROP_TOOLTIP,"XX");  
  

  levels="Trendy";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,up_time,high_price,ty_start_time,low_price);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,low_price,ty_start_time+(obj_time1-obj_time2),low_price+(obj_prc1-obj_prc2));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,true);  
  ObjectSetString(ChartID(),name+"LevelT"+levels,OBJPROP_TOOLTIP,"YY");
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);    
  

  levels="Trendl";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,up_time,high_price,ty_start_time,low_price);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time+(obj_time1-obj_time2),low_price+(obj_prc1-obj_prc2),ty_start_time+((obj_time1-obj_time2)*9),low_price+(obj_prc1-obj_prc2));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);  
  //ObjectSetString(ChartID(),name+"LevelT"+levels,OBJPROP_TOOLTIP,"YY");
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);    
  

  level=level618s;
  levels="Trendq";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time+(obj_time1-obj_time2),low_price+(obj_prc1-obj_prc2),ty_start_time+(((obj_time1-obj_time2))+((ty_start_time-obj_time1))),(low_price+(obj_prc1-obj_prc2))-(high_price-low_price));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGreen);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);  
       
   yuzde = DivZero(high_price-low_price, 100);           
   level50=low_price+yuzde*50; // 50
   level786=low_price+yuzde*78.6; // 50
   level618s=low_price+yuzde*61.8; // 50

       
       
//if ( mode == true ) {

  level=level618s;
  levels="x618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level618s,ty_end_time,level618s);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);

  level=level786;
  levels="x786";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level786,ty_end_time,level786);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

  level=level50;
  levels="x50";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level50,ty_end_time,level50);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
/*
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
*/

  level=level0;
  levels="xd000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);



//}         
         
            

}

/////////////////////////////////////////////////////////////////////////////////////////////////


if ( obj_prc2 > obj_prc1 ) {

int shift=iBarShift(Symbol(),Period(),obj_time1);
ObjectMove(ChartID(),last_select_object,0,obj_time1,Low[shift]);
low_price=Low[shift];
obj_prc1=low_price;
shift=iBarShift(Symbol(),Period(),obj_time2);
ObjectMove(ChartID(),last_select_object,1,obj_time2,High[shift]);
high_price=High[shift];
obj_prc2=high_price;


   double yuzde = DivZero(high_price-low_price, 100);
   
   
   double eq=low_price+yuzde*50; // 50
   
   double level45=low_price+yuzde*45; // 50
   double level55=low_price+yuzde*55; // 50
   
   double level70=low_price+yuzde*70; // 50
   double level79=low_price+yuzde*79; // 50
   double level21=low_price+yuzde*21; // 50
   double level30=low_price+yuzde*30; // 50
   double level50=low_price+yuzde*50; // 50
   double level786=low_price+yuzde*78.6; // 50
   double level618s=low_price+yuzde*61.8; // 50
   
   

   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level382=yuzde*38.2; // 38.2
   double level342=yuzde*34.2; // 50      
   double level1240=yuzde*124; // 50      
   //double level786=yuzde*78.6; // 50
   //double level500=yuzde*50; // 50
   
  
   
   double level0=0;
   double level100=0; 

string name=last_select_object+"Pattern5 ";

datetime ty_start_time=obj_time2;
datetime ty_end_time=obj_time2+300*PeriodSeconds();

double level;
string levels;



//if ( mode == false ) {

  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level0;
  levels="d000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2,low_price-level,obj_time2+10*PeriodSeconds(),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  
  
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  double price=high_price+level;

  level=level1240;
  levels="d1240";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
      

int z1=8;
int z2=16;
int z3=64;
///////////////////////////////////////////////////////
if ( (obj_time1-obj_time2)/PeriodSeconds() > 10 ) {
z1=4;
z2=8;
z3=12;
 }
 

  level=level1240;
  levels="df1240";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time1,low_price,obj_time2+((obj_time1-obj_time2)*z1),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);


  level=level618;
  levels="df618";  
           double yuzdes = DivZero((high_price+level1240)-low_price, 100);
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z1),high_price+level1240,obj_time2+((obj_time1-obj_time2)*z2),(high_price+level1240)-yuzdes*61.8);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);



  level=level618;
  levels="dfabcd";  
           //double yuzdes = DivZero((high_price+level1240)-low_price, 100);
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z1),high_price+level1240,obj_time2+((obj_time1-obj_time2)*z2),(high_price+level1240)-+(obj_prc2-obj_prc1));
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
  
    
  
  level=level618;
  levels="dff1240";  
           
   
  ObjectDelete(ChartID(),name+"Level"+levels);
  if ( obj_time2+((obj_time1-obj_time2)*64) < TimeCurrent() ) ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z2),(high_price+level1240)-yuzdes*61.8,obj_time2+((obj_time1-obj_time2)*z3),(high_price+level1240)-yuzdes*61.8+((high_price+level1240)-low_price));
  if ( obj_time2+((obj_time1-obj_time2)*64) > TimeCurrent() ) ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,obj_time2+((obj_time1-obj_time2)*z2),(high_price+level1240)-yuzdes*61.8,Time[0],(high_price+level1240)-yuzdes*61.8+((high_price+level1240)-low_price));  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
  
  
  

//}

//return;


       
shift=iBarShift(Symbol(),Period(),obj_time1);

ObjectDelete(ChartID(),"v");
ObjectCreate(ChartID(),"v",OBJ_VLINE,0,Time[shift],Ask);
ObjectSetInteger(ChartID(),"v",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"v",OBJPROP_WIDTH,2);

int say=0;
bool first=false;
bool find=false;
int last_i=0;


datetime up_time=ty_start_time;
      
for (int i=shift;i>0;i--){

ObjectDelete(ChartID(),"v"+i);

if ( first==false && price < High[i]) {
if ( high_price < High[i] ) {
Print(high_price,"/",High[i]);
//ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);
high_price=High[i];
ty_start_time=Time[i];
ty_end_time=Time[i]+500*PeriodSeconds();
last_i=i;
//first=true;


/*
say=0;


for (int r=i;r>i-50;r--){

if ( r < 0 ) continue;

if ( low_price < Low[r] ) {
say=say+1;
if ( say == 20 ) find=true;
ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);
} else {
say=0;
}


}
*/

}


if ( last_i-i > 10 ) {
first=true;
}

/*
if ( first == true ) {

if ( find==false ) {
if ( low_price > Low[i] ) {
low_price=Low[i];
ty_end_time=Time[i];
say=0;
Print(i);
} else {
say=say+1;
Print(i);
if ( say == 10 ) find=true;
ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);


}
}

}
*/


}



/*
if ( find==false ) {
if ( low_price > Low[i] ) {
low_price=Low[i];
ty_end_time=Time[i];
say=0;

Print(i);

} else {
say=say+1;
//Print(i);
if ( say == 10 ) find=true;

//ObjectCreate(ChartID(),"v"+i,OBJ_VLINE,0,Time[i],Ask);


}
}
*/


}

  level=level618s;
  levels="Trendx";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,obj_time1,low_price,ty_start_time,high_price);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,true);
  

  level=level618s;
  levels="Trendy";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,ty_start_time+(obj_time1-obj_time2),high_price-(obj_prc2-obj_prc1));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,true);  
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);  
  

  level=level618s;
  levels="Trendl";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time+(obj_time1-obj_time2),high_price-(obj_prc2-obj_prc1),ty_start_time+((obj_time1-obj_time2)*9),high_price-(obj_prc2-obj_prc1));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,true);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);  
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);    
  //return;  
  
  level=level618s;
  levels="Trendq";       
  ObjectDelete(ChartID(),name+"LevelT"+levels);
  //ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time,high_price,up_time,low_price);
  ObjectCreate(ChartID(),name+"LevelT"+levels,OBJ_TREND,0,ty_start_time+(obj_time1-obj_time2),high_price-(obj_prc2-obj_prc1),ty_start_time+(((obj_time1-obj_time2))+((ty_start_time-obj_time1))),(high_price-(obj_prc2-obj_prc1))+(high_price-low_price));
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_COLOR,clrLightGreen);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTABLE,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_SELECTED,false);
  ObjectSetInteger(ChartID(),name+"LevelT"+levels,OBJPROP_STYLE,STYLE_DOT);
    
  //return;
  
       
   yuzde = DivZero(high_price-low_price, 100);           
   level50=high_price-yuzde*50; // 50
   level786=high_price-yuzde*78.6; // 50
   level618s=high_price-yuzde*61.8; // 50

       
       
//if ( mode == true ) {

  level=level618s;
  levels="x618s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level618s,ty_end_time,level618s);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);

  level=level786;
  levels="x786";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level786,ty_end_time,level786);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

  level=level50;
  levels="x50";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level50,ty_end_time,level50);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
/*
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_start_time+10*PeriodSeconds(),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
*/

  level=level0;
  levels="xd000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price-level,ty_end_time,high_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);



//}         
         
            

}

          
          
}

   
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
