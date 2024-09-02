//+------------------------------------------------------------------+
//|                                                    VolumeBar.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

bool gsystem=false;
int last_shift=0;
string last_select_object="";

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


if ( sparam == 45 ) {

ObjectsDeleteAll();
gsystem=false;
last_select_object="";

}

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND ) {

/*
if ( last_select_object != sparam ) {
gsystem=false;
}*/

last_select_object=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME1);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME2);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME3);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE1);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE2);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE3);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          
        int shift1=iBarShift(Symbol(),Period(),obj_time1);
        int shift2=iBarShift(Symbol(),Period(),obj_time2);
        
        
        
          
if ( shift1 > shift2 ) {



if ( obj_prc1 > obj_prc2 ) {



int gshift=0;

bool find=false;
for(int i=shift1-1;i>shift1-50;i--){

if ( find == false ) {
if ( Open[i] < Close[i] ) {
find=true;
gshift=i+1;
}
}

}

/*



if ( gsystem == false ) {
last_shift=shift1;
shift1=gshift-1;
gsystem=true;

} else {
gsystem=false;
shift1=last_shift;
}
*/

ObjectDelete(ChartID(),"RecG");
ObjectCreate(ChartID(),"RecG",OBJ_VLINE,0,Time[gshift],Ask);

/*
ObjectDelete(ChartID(),"RecUpg");
ObjectCreate(ChartID(),"RecUpg",OBJ_RECTANGLE,0,Time[gshift],High[gshift],Time[gshift]+100*PeriodSeconds(),Low[gshift]);
ObjectSetInteger(ChartID(),"RecUpg",OBJPROP_COLOR,clrLightSlateGray);

ObjectDelete(ChartID(),"RecUpLowG");
ObjectCreate(ChartID(),"RecUpLowG",OBJ_TREND,0,Time[gshift],Low[gshift],Time[gshift]+100*PeriodSeconds(),Low[gshift]);
ObjectSetInteger(ChartID(),"RecUpLowG",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"RecUpLowG",OBJPROP_STYLE,STYLE_DOT);
*/



ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);


double eq=High[shift1]-((High[shift1]-Low[gshift])/2);
double yuzde=(High[shift1]-Low[shift2])/100;



ObjectDelete(ChartID(),"RecEq");
ObjectCreate(ChartID(),"RecEq",OBJ_TREND,0,Time[shift1],eq,Time[shift1]+100*PeriodSeconds(),eq);
ObjectSetInteger(ChartID(),"RecEq",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),"RecEq",OBJPROP_STYLE,STYLE_DOT);


ObjectDelete(ChartID(),"Rec75");
ObjectCreate(ChartID(),"Rec75",OBJ_TREND,0,Time[shift1],Low[shift2]+yuzde*75,Time[shift1]+100*PeriodSeconds(),Low[shift2]+yuzde*75);
ObjectSetInteger(ChartID(),"Rec75",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),"Rec75",OBJPROP_STYLE,STYLE_DOT);


//Alert(sparam);

ObjectDelete(ChartID(),"RecUp");
ObjectCreate(ChartID(),"RecUp",OBJ_RECTANGLE,0,Time[gshift-1],High[gshift-1],Time[gshift-1]+100*PeriodSeconds(),Low[gshift-1]);
ObjectSetInteger(ChartID(),"RecUp",OBJPROP_COLOR,clrLightSlateGray);

ObjectDelete(ChartID(),"RecUpHigh");
ObjectCreate(ChartID(),"RecUpHigh",OBJ_TREND,0,Time[gshift-1],High[gshift-1],Time[gshift-1]+100*PeriodSeconds(),High[gshift-1]);
ObjectSetInteger(ChartID(),"RecUpHigh",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"RecUpHigh",OBJPROP_STYLE,STYLE_DOT);


ObjectDelete(ChartID(),"RecDown");
ObjectCreate(ChartID(),"RecDown",OBJ_RECTANGLE,0,Time[shift1+1],High[shift1+1],Time[shift1+1]+100*PeriodSeconds(),Low[shift1+1]);
ObjectSetInteger(ChartID(),"RecDown",OBJPROP_COLOR,clrLightSlateGray);

ObjectDelete(ChartID(),"RecUpLow");
ObjectCreate(ChartID(),"RecUpLow",OBJ_TREND,0,Time[shift1+1],Low[shift1+1],Time[shift1+1]+100*PeriodSeconds(),Low[shift1+1]);
ObjectSetInteger(ChartID(),"RecUpLow",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"RecUpLow",OBJPROP_STYLE,STYLE_DOT);


}




if ( obj_prc2 > obj_prc1 ) {


int gshift=0;

bool find=false;
for(int i=shift1-1;i>shift1-50;i--){

if ( find == false ) {
if ( Open[i] > Close[i] ) {
find=true;
gshift=i+1;
}
}

}




/*
int gshift=0;

bool find=false;
for(int i=shift1+1;i<shift1+50;i++){

if ( find == false ) {
if ( Open[i] > Close[i] ) {
find=true;
gshift=i;
}
}

}

*/




ObjectDelete(ChartID(),"RecG");
ObjectCreate(ChartID(),"RecG",OBJ_VLINE,0,Time[gshift],Ask);

/*
if ( gsystem == false ) {
last_shift=shift1;
shift1=gshift-1;
gsystem=true;

} else {
gsystem=false;
shift1=last_shift;
}



ObjectDelete(ChartID(),"RecUpg");
ObjectCreate(ChartID(),"RecUpg",OBJ_RECTANGLE,0,Time[gshift],High[gshift],Time[shift1-1]+100*PeriodSeconds(),Low[gshift]);
ObjectSetInteger(ChartID(),"RecUpg",OBJPROP_COLOR,clrLightSlateGray);

ObjectDelete(ChartID(),"RecUpHighG");
ObjectCreate(ChartID(),"RecUpHighG",OBJ_TREND,0,Time[gshift],High[gshift],Time[gshift]+100*PeriodSeconds(),High[gshift]);
ObjectSetInteger(ChartID(),"RecUpHighG",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"RecUpHighG",OBJPROP_STYLE,STYLE_DOT);
*/


ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);


double eq=Low[shift1]+((High[gshift]-Low[shift1])/2);
double yuzde=(High[shift2]-Low[shift1])/100;



ObjectDelete(ChartID(),"RecEq");
ObjectCreate(ChartID(),"RecEq",OBJ_TREND,0,Time[shift1],eq,Time[shift1]+100*PeriodSeconds(),eq);
ObjectSetInteger(ChartID(),"RecEq",OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),"RecEq",OBJPROP_STYLE,STYLE_DOT);

ObjectDelete(ChartID(),"Rec75");
ObjectCreate(ChartID(),"Rec75",OBJ_TREND,0,Time[shift1],High[shift2]-yuzde*75,Time[shift1]+100*PeriodSeconds(),High[shift2]-yuzde*75);
ObjectSetInteger(ChartID(),"Rec75",OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),"Rec75",OBJPROP_STYLE,STYLE_DOT);


//Alert(sparam);

ObjectDelete(ChartID(),"RecUp");
ObjectCreate(ChartID(),"RecUp",OBJ_RECTANGLE,0,Time[gshift-1],High[gshift-1],Time[gshift-1]+100*PeriodSeconds(),Low[gshift-1]);
ObjectSetInteger(ChartID(),"RecUp",OBJPROP_COLOR,clrLightSlateGray);

ObjectDelete(ChartID(),"RecUpLow");
ObjectCreate(ChartID(),"RecUpLow",OBJ_TREND,0,Time[gshift-1],Low[gshift-1],Time[gshift-1]+100*PeriodSeconds(),Low[gshift-1]);
ObjectSetInteger(ChartID(),"RecUpLow",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"RecUpLow",OBJPROP_STYLE,STYLE_DOT);


ObjectDelete(ChartID(),"RecDown");
ObjectCreate(ChartID(),"RecDown",OBJ_RECTANGLE,0,Time[shift1+1],High[shift1+1],Time[shift1+1]+100*PeriodSeconds(),Low[shift1+1]);
ObjectSetInteger(ChartID(),"RecDown",OBJPROP_COLOR,clrLightSlateGray);

ObjectDelete(ChartID(),"RecUpHigh");
ObjectCreate(ChartID(),"RecUpHigh",OBJ_TREND,0,Time[shift1+1],High[shift1+1],Time[shift1+1]+100*PeriodSeconds(),High[shift1+1]);
ObjectSetInteger(ChartID(),"RecUpHigh",OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),"RecUpHigh",OBJPROP_STYLE,STYLE_DOT);


}




}


}
   
  }
//+------------------------------------------------------------------+
