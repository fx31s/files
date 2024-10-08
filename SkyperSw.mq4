//+------------------------------------------------------------------+
//|                                                       Skyper.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

string last_select_object;

double high_price;
double low_price;
int shift_1;
int shift_2;
double price_1;
double price_2;
bool lock=false;

     long sinyal_charid=ChartID();
     long currChart=ChartID();
     
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


double Ortalama;


//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  
   
 int k=10;

 for(int i=0;i<k;i++)
        {
         //PrintFormat("result[%d]=%s",i,results[i]);
         
     
     string LabelChartu = "Bilgi"+i;
     ObjectDelete(sinyal_charid,LabelChartu);
     ObjectCreate(sinyal_charid,LabelChartu, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(sinyal_charid,LabelChartu,OBJPROP_TEXT,"");
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_CORNER, 1);
     ObjectSetString(sinyal_charid,LabelChartu, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_XDISTANCE, 50);
     ObjectSetInteger(sinyal_charid,LabelChartu, OBJPROP_YDISTANCE, i*20); 
 
        }
        
        
	int min, sec;
	
   min = Time[0] + Period()*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   

     string LabelChartu = "Bilgi"+1;
     ObjectSetString(sinyal_charid,LabelChartu,OBJPROP_TEXT,min + ":" + sec);
             //Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec"+"\nBar Ortalama:",int(Ortalama/Point));
             Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec");
             
          
//--- create timer
   EventSetTimer(1);
   
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
   
   	int min, sec;
	
   min = Time[0] + Period()*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   

     string LabelChartu = "Bilgi"+1;
     ObjectSetString(sinyal_charid,LabelChartu,OBJPROP_TEXT,min + ":" + sec);
   
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


if ( sparam == 38 ) {

//if ( lock == true ) {lock=false;}
lock=true;

Comment("Lock:",lock);


}


if ( sparam == 45 ) {
ClearExp();
//ObjectsDeleteAll(ChartID(),-1,-1);
lock=false;ChartRedraw(ChartID());}















if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false ) {


last_select_object=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
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
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          shift_1=shift1;
          shift_2=shift2;
          
          price_1=obj_prc1;
          price_2=obj_prc2;
          

          
          
if ( obj_prc1 > obj_prc2 ) {





   Ortalama=BarOrtalama(shift2,shift1,Symbol(),Period());
   
   //Comment("Bar Ortalama:",Ortalama);
   
   //Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec"+"\nBar Ortalama:",int(Ortalama/Point));
   
  string sym=Symbol();
  ENUM_TIMEFRAMES per=Period();
       
       
       
       for (int i=shift2;i>0;i--) {
       
       ObjectDelete(ChartID(),"MAL"+i);
       
     if ( iClose(sym,per,i)-iOpen(sym,per,i) > Ortalama*1.5 ) {
     
     double ort=DivZero(iClose(sym,per,i)-iOpen(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     ObjectDelete(ChartID(),"MAL"+i);
  }
  

  
  
    
    }
    
    
    


ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);


low_price=Low[shift2];
high_price=High[shift1];


//Alert(low_price,"/",shift2);

//Sleep(100);

for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}







ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);


if ( obj_prc1 > obj_prc2 && shift_1 < shift_2) {



for (int i=shift1;i<shift2;i++) {
//for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i>shift1;i--) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}











double birim=DivZero(high_price-low_price,87);
low_price=low_price-(birim*13.0);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],low_price);
ObjectMove(ChartID(),last_select_object,0,Time[shift1],high_price);



double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,Time[shift2]+4000*PeriodSeconds(),low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_VLINE,0,Time[shift2],low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);




}









double yuzde = DivZero(high_price-low_price, 100);

low_price=low_price-(yuzde*16.8);
yuzde = DivZero(high_price-low_price, 100);

ObjectMove(ChartID(),last_select_object,1,Time[shift2],low_price);


double last_ma_high=0;
double last_mb_high=0;
double last_mc_high=0;
int last_ma=0;
int last_mb=0;
int last_mc=0;


for(int i=shift1;i>=shift2;i--){

double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);
double mb=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, i);
double mc=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, i);

if ( last_ma_high < ma ) {last_ma_high=ma;last_ma=i;}
if ( last_mb_high < mb ) {last_mb_high=mb;last_mb=i;}
if ( last_mc_high < mc ) {last_mc_high=mc;last_mc=i;}


}



double levels=50;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_ma],last_ma_high,Time[last_ma]+4000*PeriodSeconds(),last_ma_high);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);



levels=10;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mb],last_mb_high,Time[last_mb]+4000*PeriodSeconds(),last_mb_high);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=20;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mc],last_mc_high,Time[last_mc]+4000*PeriodSeconds(),last_mc_high);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);





double last_ma_low=100000;
double last_mb_low=100000;
double last_mc_low=100000;
int last_mal=0;
int last_mbl=0;
int last_mcl=0;


for(int i=shift1;i>=shift2;i--){

double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);
double mb=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, i);
double mc=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, i);

if ( last_ma_low > ma ) {last_ma_low=ma;last_mal=i;}
if ( last_mb_low > mb ) {last_mb_low=mb;last_mbl=i;}
if ( last_mc_low > mc ) {last_mc_low=mc;last_mcl=i;}


}


//Alert("Selam");


levels=500;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mal],last_ma_low,Time[last_mal]+4000*PeriodSeconds(),last_ma_low);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=100;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mbl],last_mb_low,Time[last_mbl]+4000*PeriodSeconds(),last_mb_low);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=200;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mcl],last_mc_low,Time[last_mcl]+4000*PeriodSeconds(),last_mc_low);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);






levels=45;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,Time[shift2]+4000*PeriodSeconds(),low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);



levels=55;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,Time[shift2]+4000*PeriodSeconds(),low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=61.80;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,Time[shift2]+4000*PeriodSeconds(),low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1]-333*PeriodSeconds(),low_price+yuzde*levels,Time[shift1]+4000*PeriodSeconds(),low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrRed);
//ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);











} else {




   Ortalama=BarOrtalama(1,300,Symbol(),Period());
   
   //Comment("Bar Ortalama:",Ortalama);
   
   //Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec"+"\nBar Ortalama:",int(Ortalama/Point));
   
  string sym=Symbol();
  ENUM_TIMEFRAMES per=Period();
       
       
       
       for (int i=shift2;i>0;i--) {
       
       ObjectDelete(ChartID(),"MAL"+i);
       
     /*
     if ( iClose(sym,per,i)-iOpen(sym,per,i) > Ortalama*2 ) {
     
     double ort=DivZero(iClose(sym,per,i)-iOpen(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrDarkGreen);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrLimeGreen);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     

          
  
  }*/
  
     if ( iOpen(sym,per,i)-iClose(sym,per,i) > Ortalama*2 ) {
     
     double ort=DivZero(iOpen(sym,per,i)-iClose(sym,per,i),Ortalama);

     ObjectDelete(ChartID(),"MAL"+i);
     ObjectCreate(ChartID(),"MAL"+i,OBJ_TREND,0,Time[i],Open[i],Time[i],Close[i]);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_RAY,False);
     //ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrCrimson);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_COLOR,clrYellow);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_WIDTH,3);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_BACK,false);
     ObjectSetInteger(ChartID(),"MAL"+i,OBJPROP_SELECTABLE,false);
     //ObjectSetString(ChartID(),"MAL"+i,OBJPROP_TOOLTIP,TFtoStr(per));
     ObjectDelete(ChartID(),"MAL"+i);

          
  
  }
    
    }
    
    


ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);


low_price=Low[shift1];
high_price=High[shift2];

/*
for (int i=shift1;i>shift2;i--) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}
*/


//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

//for (int i=shift1;i>shift2;i--) {
for (int i=shift1;i>shift2;i--) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}







ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);
ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);


if ( obj_prc1 < obj_prc2 && shift_1 < shift_2) {


//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i>shift1;i--) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

//for (int i=shift1;i>shift2;i--) {
for (int i=shift1;i<shift2;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}




double birim=DivZero(high_price-low_price,87);
high_price=high_price+(birim*13.0);

ObjectMove(ChartID(),last_select_object,1,Time[shift2],high_price);
ObjectMove(ChartID(),last_select_object,0,Time[shift1],low_price);


double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price,Time[shift2]+4000*PeriodSeconds(),high_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_VLINE,0,Time[shift2],high_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrCrimson);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


}




double yuzde = DivZero(high_price-low_price, 100);

high_price=high_price+(yuzde*16.8);
yuzde = DivZero(high_price-low_price, 100);

ObjectMove(ChartID(),last_select_object,1,Time[shift2],high_price);



double last_ma_low=100000;
double last_mb_low=100000;
double last_mc_low=100000;
int last_ma=0;
int last_mb=0;
int last_mc=0;


for(int i=shift1;i>=shift2;i--){

double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);
double mb=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, i);
double mc=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, i);

if ( last_ma_low > ma ) {last_ma_low=ma;last_ma=i;}
if ( last_mb_low > mb ) {last_mb_low=mb;last_mb=i;}
if ( last_mc_low > mc ) {last_mc_low=mc;last_mc=i;}


}


//Alert("Selam");


double levels=50;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_ma],last_ma_low,Time[last_ma]+4000*PeriodSeconds(),last_ma_low);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=10;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mb],last_mb_low,Time[last_mb]+4000*PeriodSeconds(),last_mb_low);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=20;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mc],last_mc_low,Time[last_mc]+4000*PeriodSeconds(),last_mc_low);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);




double last_ma_high=0;
double last_mb_high=0;
double last_mc_high=0;
int last_mah=0;
int last_mbh=0;
int last_mch=0;


for(int i=shift1;i>=shift2;i--){

double ma=iMA(sym, PERIOD_CURRENT, MA_W, ma_shift, MaMethod, MaPrice, i);
double mb=iMA(sym, PERIOD_CURRENT, MB_W, ma_shift, MaMethod, MaPrice, i);
double mc=iMA(sym, PERIOD_CURRENT, MC_W, ma_shift, MaMethod, MaPrice, i);

if ( last_ma_high < ma ) {last_ma_high=ma;last_mah=i;}
if ( last_mb_high < mb ) {last_mb_high=mb;last_mbh=i;}
if ( last_mc_high < mc ) {last_mc_high=mc;last_mch=i;}


}



levels=500;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mah],last_ma_high,Time[last_mah]+4000*PeriodSeconds(),last_ma_high);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=100;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mbh],last_mb_high,Time[last_mbh]+4000*PeriodSeconds(),last_mb_high);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);

levels=200;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[last_mch],last_mc_high,Time[last_mch]+4000*PeriodSeconds(),last_mc_high);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


levels=45;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,Time[shift2]+4000*PeriodSeconds(),high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);



levels=55;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,Time[shift2]+4000*PeriodSeconds(),high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=61.80;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,Time[shift2]+4000*PeriodSeconds(),high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=13;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1]-333*PeriodSeconds(),high_price-yuzde*levels,Time[shift1]+4000*PeriodSeconds(),high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrRed);
//ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);



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

void ClearExp() {


ObjectDelete(ChartID(),last_select_object);


    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     //string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     if (  StringFind(names,"Exp",0) != -1 || StringFind(names,"MBL",0) != -1 ) {
     
     ObjectDelete(ChartID(),names);
     
     
     }
     
     
     
     }
     

}







void EngineClear() {

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     //string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     if (  StringFind(names,"MAL",0) != -1 || StringFind(names,"MBL",0) != -1 ) {
     
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




   int ortalama_last_bar= -1;

 
double BarOrtalama(int StartVisibleBar,int FinishVisibleBarLenght,string Sym,int Per) { 

///FinishVisibleBarLenght=PERIOD_W1/Period();
//Print("FinishVisibleBarLenght",FinishVisibleBarLenght);
///if ( FinishVisibleBarLenght > Bars ) FinishVisibleBarLenght=Bars;



if ( ortalama_last_bar == WindowFirstVisibleBar() && StartVisibleBar == -1 ) return Ortalama;


if ( ortalama_last_bar != WindowFirstVisibleBar() ) {
ortalama_last_bar = WindowFirstVisibleBar();
}

//Print("FinishVisibleBarLenght2",FinishVisibleBarLenght);


int mumanaliz_shift;
int mumanaliz_shiftb;

   if ( WindowFirstVisibleBar()-WindowBarsPerChart() > 0 ) {
   mumanaliz_shift=WindowFirstVisibleBar()-WindowBarsPerChart();
   } else {
   mumanaliz_shift=0;
   }
   mumanaliz_shiftb=WindowFirstVisibleBar();
   
   
   
   if ( StartVisibleBar != -1 ) mumanaliz_shift=StartVisibleBar;
   
   if ( FinishVisibleBarLenght != -1 ) mumanaliz_shiftb=mumanaliz_shift+FinishVisibleBarLenght;
   
   
   int bar_toplam = mumanaliz_shiftb-mumanaliz_shift;
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=mumanaliz_shift;t<=mumanaliz_shiftb;t++) {
   
   //bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   ///bar_pip = bar_pip + MathAbs(Close(select_sym,select_per,t)-Open(select_sym,select_per,t));
   bar_pip = bar_pip + MathAbs(iClose(Sym,Per,t)-iOpen(Sym,Per,t));
   
   }
  
   
   bar_ortalama = bar_pip / bar_toplam;
   
   return bar_ortalama;

}



//////////////////////////////////////////////////////////
int StrtoTF(string sinyal_sym_periyod){
int Chart_Config_per=-1;
//sinyal_sym_periyod=StringToUpper(sinyal_sym_periyod);
   if ( sinyal_sym_periyod == "M1" ) Chart_Config_per = PERIOD_M1;
   if ( sinyal_sym_periyod == "M5" ) Chart_Config_per = PERIOD_M5;
   if ( sinyal_sym_periyod == "M15" ) Chart_Config_per = PERIOD_M15;
   if ( sinyal_sym_periyod == "M30" ) Chart_Config_per = PERIOD_M30;
   if ( sinyal_sym_periyod == "H1" ) Chart_Config_per = PERIOD_H1;
   if ( sinyal_sym_periyod == "H4" ) Chart_Config_per = PERIOD_H4;
   if ( sinyal_sym_periyod == "D1" ) Chart_Config_per = PERIOD_D1;
   if ( sinyal_sym_periyod == "W1" ) Chart_Config_per = PERIOD_W1;
   if ( sinyal_sym_periyod == "MN1" ) Chart_Config_per = PERIOD_MN1;
return Chart_Config_per;
}

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
  default    : 0;//return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader
