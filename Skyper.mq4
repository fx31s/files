//+------------------------------------------------------------------+
//|                                                       Skyper.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

//## Skyper Bomb 13-01-2024



bool skyper=false;

string last_select_object="";

double high_price;
double low_price;
int shift_1;
int shift_2;
double price_1;
double price_2;
bool lock=false;

bool fibo_tp_level=false;
color tp_level=clrBlack;



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

datetime mnt;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  
  ///////////////////////////////////////////////////////////////////////////////
  // Us30 Modeli
  ///////////////////////////////////////////////////////////////////////////////
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+16+":"+"30";
  datetime some_time = StringToTime(yenitarih);
  
  
  if ( StringFind(Symbol(),"30",0) != -1 ) {
  ObjectDelete(ChartID(),"Us30Time");
  ObjectCreate(ChartID(),"Us30Time",OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"Us30Time",OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_COLOR,clrRed);
  
  
   for(int t=5;t<Bars-100;t++) {
   
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M5,t))) == 16 && int(TimeMinute(iTime(Symbol(),PERIOD_M5,t))) == 30 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_VLINE,0,iTime(Symbol(),PERIOD_M5,t),iHigh(Symbol(),PERIOD_M5,t));
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightGray);   
   
   }
   
   }
   
   
   
   
  
  }
  ///////////////////////////////////////////////////////////////////////////
    
  ///////////////////////////////////////////////////////////////////////////////
  // Currency Modeli
  ///////////////////////////////////////////////////////////////////////////////
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+15+":"+"30";
  some_time = StringToTime(yenitarih);
  
  
  if ( StringFind(Symbol(),"30",0) == -1 ) {
  ObjectDelete(ChartID(),"UsdTime");
  ObjectCreate(ChartID(),"UsdTime",OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_COLOR,clrBlue);
  }
  

   for(int t=5;t<Bars-100;t++) {
   
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M5,t))) == 15 && int(TimeMinute(iTime(Symbol(),PERIOD_M5,t))) == 30 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_VLINE,0,iTime(Symbol(),PERIOD_M5,t),iHigh(Symbol(),PERIOD_M5,t));
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightGray);   
   
   }
   
   }
   
     
  ///////////////////////////////////////////////////////////////////////////
    
        
    
  
  /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
  }
  ////////////////////////////
  
   
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
             



ObjectsDeleteAlls(ChartID(),"Sweet",-1,-1);

   dPt = Point;
   if(Digits==3||Digits==5){
      dPt=dPt*10;
   } 
   
   if ( StringFind(Symbol(),"XAUUSD",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US30",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"SP500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"USDZAR",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"USDMXN",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"USDJPY",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"NAS100",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"GER30",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"GER40",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"EURMXN",0) != -1 ) dPt=dPt*100;
   
   
   if ( StringFind(AccountCompany(),"Robo",0) != -1 ) {
   
   
   if ( StringFind(Symbol(),"DE40",0) != -1 ) dPt=dPt*10;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*0.1;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=1;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=Point*100;
   if ( StringFind(Symbol(),"USTECH",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"BTC",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"BNB",0) != -1 ) dPt=dPt*10;
   }
   
   //Alert(Point*100);
  
   Ict();
   Ict250();
   
             
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


Print(sparam,"/",last_select_object);



if ( StringFind(sparam,"77777",0) != -1 ) {
skyper=true;
Comment("Skyper:",skyper);
}


if ( sparam == 19 ) {

if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == True ) {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False); } else {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);}

}


if ( sparam == 20 ) {


if ( fibo_tp_level == true ) {fibo_tp_level=false;}else{fibo_tp_level=true;}

Comment("Fibo Tp Level:",fibo_tp_level);


}

if ( sparam == 46 ) {

Print("Copy",last_select_object);


EngineCopyFibLevel();
EngineCopyFibLevel();


}



if ( sparam == 2 ) {



   //color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrSlateGray);    

   //color_up = ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,clrBlack);    
      
   //color_down = ChartGetInteger(ChartID(),CHART_COLOR_CHART_DOWN);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,clrBlack);
   
   //color_bull = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BULL);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,clrDodgerBlue);    
      
   //color_bear = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,clrBlue);
   
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_LINE,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrBlack);
   ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
   
   //ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);
   
   tp_level=clrYellow;
   

}


if ( sparam == 3 ) {



   //color_bg = ChartGetInteger(ChartID(),CHART_COLOR_BACKGROUND);
   ChartSetInteger(ChartID(),CHART_COLOR_BACKGROUND,clrWhite);    

   //color_up = ChartGetInteger(ChartID(),CHART_COLOR_CHART_UP);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_UP,clrMediumSeaGreen);    
      
   //color_down = ChartGetInteger(ChartID(),CHART_COLOR_CHART_DOWN);
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_DOWN,clrOrangeRed);
   
   //color_bull = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BULL);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BULL,clrMediumSeaGreen);    
      
   //color_bear = ChartGetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR);
   ChartSetInteger(ChartID(),CHART_COLOR_CANDLE_BEAR,clrOrangeRed);
   
   ChartSetInteger(ChartID(),CHART_COLOR_CHART_LINE,clrBlack);
   
   ChartSetInteger(ChartID(),CHART_COLOR_ASK,clrBlack);
   ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
   
   //ChartSetInteger(ChartID(),CHART_AUTOSCROLL,false);
   
   
   tp_level=clrDarkBlue;
   
   

}






//Print(sparam);


if ( sparam == 33 ) {
if ( skyper == true ) {skyper=false;} else{skyper=true;}

Comment("Skyper:",skyper);

}


if ( skyper == false ) {

SkyperBomb(sparam);

}

if ( sparam == 38 ) {

//if ( lock == true ) {lock=false;}
lock=true;

Comment("Lock:",lock);


}


if ( sparam == 45 ) {
ClearExp();
//ObjectsDeleteAll(ChartID(),-1,-1);
lock=false;ChartRedraw(ChartID());
skyper=false;
Comment("Skyper:",skyper);
}





if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE) {

string last_select_objectr=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          
          if ( obj_prc1 > obj_prc2 ) {
          
        
ObjectDelete(ChartID(),last_select_objectr+"ExpC");
ObjectCreate(ChartID(),last_select_objectr+"ExpC",OBJ_TREND,0,Time[shift1],obj_prc1-((obj_prc1-obj_prc2)/2),Time[shift2],obj_prc1-((obj_prc1-obj_prc2)/2));
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_RAY,True);
           
          }
          

          if ( obj_prc2 > obj_prc1 ) {

ObjectDelete(ChartID(),last_select_objectr+"ExpC");
ObjectCreate(ChartID(),last_select_objectr+"ExpC",OBJ_TREND,0,Time[shift1],obj_prc2-((obj_prc2-obj_prc1)/2),Time[shift2],obj_prc2-((obj_prc2-obj_prc1)/2));
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_RAY,True);
    

          
          }
              
              
              
              
                    
          
          
          
          }
          
          


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"ExpEx45.01",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == true) {


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
          
          

//Alert("Selam");

          
          
if ( obj_prc1 > obj_prc2 ) {


//return;


double high_price=High[shift1];
double low_price=Low[shift2];

double yuzde = DivZero(high_price-low_price, 100);

string last_select_objects=last_select_object+"ExpFib61.81";

          int obj_typ = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BACK);
          
          
          int shift1s=iBarShift(Symbol(),Period(),obj_time1);
          int shift2s=iBarShift(Symbol(),Period(),obj_time2);
          
          
          //int time_diff=shift1s

          

double high_prices=High[shift2s];
double low_prices=Low[shift1s];


double fib_high_price=high_prices;
double fib_low_price=low_prices;
double fib_yuzde=DivZero(fib_high_price-fib_low_price,100);


ObjectDelete(ChartID(),last_select_object+"Exp272");
ObjectCreate(ChartID(),last_select_object+"Exp272",OBJ_TREND,0,Time[shift2s],high_prices+fib_yuzde*27.2,mnt,high_prices+fib_yuzde*27.2);
ObjectSetInteger(ChartID(),last_select_object+"Exp272",OBJPROP_WIDTH,3);




double z=DivZero(shift1-shift2,4);


datetime obj_time2s = ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME,1);
int shift2ss=iBarShift(Symbol(),Period(),obj_time2s);

ObjectMove(ChartID(),sparam,1,Time[shift2ss],Low[shift2ss]);


datetime obj_time1s = ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME,0);
int shift1ss=iBarShift(Symbol(),Period(),obj_time1s);


double low_pricess=Low[shift2ss];

for (int i=shift2ss;i<shift1ss;i++) {

if ( Low[i] < low_pricess ) {low_pricess=Low[i];shift2ss=i;}

}


ObjectMove(ChartID(),sparam,1,Time[shift2ss],Low[shift2ss]);







double levels=61.81;
string level=DoubleToString(levels,2);


levels=45.01;
level=DoubleToString(levels,2);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTED,True);



levels=45.03;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2ss],Low[shift2ss],Time[shift2ss]+int(z+(z/0.5))*PeriodSeconds(),fib_high_price+fib_yuzde*88.6);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);    


levels=45.04;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/0.5))*PeriodSeconds(),fib_high_price+fib_yuzde*88.6,Time[shift2]+1000*PeriodSeconds(),fib_high_price+fib_yuzde*88.6);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);    

levels=45.05;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2ss],Low[shift2ss],Time[shift2ss]+(shift1s-shift2s)*PeriodSeconds(),Low[shift2ss]+(obj_prc2-obj_prc1));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);    
ObjectSetString(ChartID(),last_select_object+"Exp"+level,OBJPROP_TOOLTIP,"abcd");   




}




if ( obj_prc2 > obj_prc1 ) {


//return;


double high_price=High[shift2];
double low_price=Low[shift1];

double yuzde = DivZero(high_price-low_price, 100);

string last_select_objects=last_select_object+"ExpFib61.81";

          int obj_typ = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BACK);
          
          
          int shift1s=iBarShift(Symbol(),Period(),obj_time1);
          int shift2s=iBarShift(Symbol(),Period(),obj_time2);
          
          

          

double high_prices=High[shift1s];
double low_prices=Low[shift2s];


double fib_high_price=high_prices;
double fib_low_price=low_prices;
double fib_yuzde=DivZero(fib_high_price-fib_low_price,100);


ObjectDelete(ChartID(),last_select_object+"Exp272");
ObjectCreate(ChartID(),last_select_object+"Exp272",OBJ_TREND,0,Time[shift2s],low_prices-fib_yuzde*27.2,mnt,low_prices-fib_yuzde*27.2);
ObjectSetInteger(ChartID(),last_select_object+"Exp272",OBJPROP_WIDTH,3);




double z=DivZero(shift1-shift2,4);


datetime obj_time2s = ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME,1);
int shift2ss=iBarShift(Symbol(),Period(),obj_time2s);

ObjectMove(ChartID(),sparam,1,Time[shift2ss],High[shift2ss]);


datetime obj_time1s = ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME,0);
int shift1ss=iBarShift(Symbol(),Period(),obj_time1s);


double high_pricess=High[shift2ss];

for (int i=shift2ss;i<shift1ss;i++) {

if ( High[i] > high_pricess ) {high_pricess=High[i];shift2ss=i;}

}


ObjectMove(ChartID(),sparam,1,Time[shift2ss],High[shift2ss]);








double levels=61.81;
string level=DoubleToString(levels,2);


levels=45.01;
level=DoubleToString(levels,2);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTED,True);



levels=45.03;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2ss],High[shift2ss],Time[shift2ss]+int(z+(z/0.5))*PeriodSeconds(),fib_low_price-fib_yuzde*88.6);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);    


levels=45.04;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/0.5))*PeriodSeconds(),fib_high_price+fib_yuzde*88.6,Time[shift2]+1000*PeriodSeconds(),fib_high_price+fib_yuzde*88.6);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);    


levels=45.05;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2ss],High[shift2ss],Time[shift2ss]+(shift1s-shift2s)*PeriodSeconds(),High[shift2ss]-(obj_prc1-obj_prc2));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);  
ObjectSetString(ChartID(),last_select_object+"Exp"+level,OBJPROP_TOOLTIP,"abcd");   


}





}







if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Fib",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == true) {



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
          
          

//Alert("Selam");

          
          
if ( obj_prc1 > obj_prc2 ) {

double high_price=High[shift1];
double low_price=Low[shift2];

double yuzde = DivZero(high_price-low_price, 100);

string last_select_objects=sparam;

          int obj_typ = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BACK);
          
          
          int shift1s=iBarShift(Symbol(),Period(),obj_time1);
          int shift2s=iBarShift(Symbol(),Period(),obj_time2);
          
          

          

double high_prices=High[shift2s];
double low_prices=Low[shift1s];




for (int i=shift2s;i<shift1s;i++) {

if ( High[i] > high_prices ) {high_prices=High[i];shift2s=i;}

}



ObjectMove(ChartID(),last_select_objects,1,Time[shift2s],high_prices);



      
double z=DivZero(shift1s-shift2s,4);


double levels=61.81;
string level=DoubleToString(levels,2);


double fib_high_price=high_prices;
double fib_low_price=low_prices;
double fib_yuzde=DivZero(fib_high_price-fib_low_price,100);

levels=38.21;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpEx"+level);
ObjectCreate(ChartID(),last_select_object+"ExpEx"+level,OBJ_TREND,0,Time[shift2s],fib_high_price,Time[shift2s]+int(z+(z/2))*PeriodSeconds(),fib_high_price-(fib_yuzde*levels));
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTED,False);



levels=45.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpEx"+level);
ObjectCreate(ChartID(),last_select_object+"ExpEx"+level,OBJ_TREND,0,Time[shift2s],fib_high_price,Time[shift2s]+int(z+(z/2))*PeriodSeconds(),fib_high_price-(fib_yuzde*levels));
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTED,False);

levels=45.02;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/1))*PeriodSeconds(),fib_high_price-(fib_yuzde*levels),Time[shift2]-int(z+(z/10))*PeriodSeconds(),fib_high_price-(fib_yuzde*levels));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


levels=38.02;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/1))*PeriodSeconds(),fib_high_price-(fib_yuzde*levels),Time[shift2]-int(z+(z/10))*PeriodSeconds(),fib_high_price-(fib_yuzde*levels));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);




levels=45.03;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2s]+int(z+(z/2))*PeriodSeconds(),fib_high_price-(fib_yuzde*levels),Time[shift2s]+((int(z+(z/2))+500)*PeriodSeconds()),fib_high_price+(fib_yuzde*88.6));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkRed);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);    


}


if ( obj_prc2 > obj_prc1 ) {

double high_price=High[shift2];
double low_price=Low[shift1];

double yuzde = DivZero(high_price-low_price, 100);

string last_select_objects=sparam;

          int obj_typ = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objects,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objects,OBJPROP_BACK);
          
          
          int shift1s=iBarShift(Symbol(),Period(),obj_time1);
          int shift2s=iBarShift(Symbol(),Period(),obj_time2);
          
          

          

double high_prices=High[shift1s];
double low_prices=Low[shift2s];

ObjectMove(ChartID(),last_select_objects,1,Time[shift2s],low_prices);


for (int i=shift2s;i<shift1s;i++) {

if ( Low[i] < low_prices ) {low_prices=Low[i];shift2s=i;}

}


ObjectMove(ChartID(),last_select_objects,1,Time[shift2s],low_prices);





      
double z=DivZero(shift1-shift2,4);


double levels=61.81;
string level=DoubleToString(levels,2);


double fib_high_price=high_prices;
double fib_low_price=low_prices;
double fib_yuzde=DivZero(fib_high_price-fib_low_price,100);

levels=38.21;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpEx"+level);
ObjectCreate(ChartID(),last_select_object+"ExpEx"+level,OBJ_TREND,0,Time[shift2s],fib_low_price,Time[shift2s]+int(z+(z/2))*PeriodSeconds(),fib_low_price+(fib_yuzde*levels));
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTED,False);



levels=45.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpEx"+level);
ObjectCreate(ChartID(),last_select_object+"ExpEx"+level,OBJ_TREND,0,Time[shift2s],fib_low_price,Time[shift2s]+int(z+(z/2))*PeriodSeconds(),fib_low_price+(fib_yuzde*levels));
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTED,False);


levels=38.22;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/1))*PeriodSeconds(),fib_low_price+(fib_yuzde*levels),Time[shift2]-int(z+(z/10))*PeriodSeconds(),fib_low_price+(fib_yuzde*levels));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);



levels=45.02;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/1))*PeriodSeconds(),fib_low_price+(fib_yuzde*levels),Time[shift2]-int(z+(z/10))*PeriodSeconds(),fib_low_price+(fib_yuzde*levels));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


levels=45.03;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2s]+int(z+(z/2))*PeriodSeconds(),fib_low_price+(fib_yuzde*levels),Time[shift2s]+int(z+(z/0.5))*PeriodSeconds(),fib_low_price-(fib_yuzde*88.6));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);    


}







}





if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == true) {

RefreshRates();
ChartRedraw();
WindowRedraw();



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
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
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
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
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
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=48.82;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*52.69);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




levels=61.80;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=60.00;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=79.00;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=38.20;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
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

////////////////////////////////////////////////////////////////////////////////////////////

double z=DivZero(shift1-shift2,4);


levels=61.81;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpFib"+level);
ObjectCreate(ChartID(),last_select_object+"ExpFib"+level,OBJ_TREND,0,Time[shift2],low_price,Time[shift2]+int(z)*PeriodSeconds(),low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_SELECTED,True);



double fib_high_price=low_price+yuzde*levels;
double fib_low_price=low_price;
double fib_yuzde=DivZero(fib_high_price-fib_low_price,100);

levels=45.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpEx"+level);
ObjectCreate(ChartID(),last_select_object+"ExpEx"+level,OBJ_TREND,0,Time[shift2]+int(z)*PeriodSeconds(),fib_high_price,Time[shift2]+int(z+(z/2))*PeriodSeconds(),fib_high_price-fib_yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTED,False);

levels=45.02;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/1))*PeriodSeconds(),fib_high_price-fib_yuzde*levels,Time[shift2]-int(z+(z/10))*PeriodSeconds(),fib_high_price-fib_yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


levels=45.03;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/2))*PeriodSeconds(),fib_high_price-fib_yuzde*levels,Time[shift2]+int(z+(z/0.5))*PeriodSeconds(),fib_high_price+fib_yuzde*88.6);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);






//Alert(int(z));





if ( fibo_tp_level == true ) {



  
        double tepe_fiyats=high_price;
        double dip_fiyats=low_price;
        
        datetime time1=Time[shift1];
        
        
        

        
        //Alert("Selam");

   double high_price=tepe_fiyats;
   double low_price=dip_fiyats;
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
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50 
   double level1618=yuzde*161.8; // 50 
   double level1886=yuzde*188.6; // 50       
   
   double level0=0;
   double level100=0; 

  double level=level168;
  string levels="u168";       
  string names=last_select_object +"Exp";
  

  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,mnt,high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);  
    
  
  level=eq;
  levels="ueq";    
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,eq,mnt,eq);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   
     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,mnt,high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);

  level=level272;
  levels="u272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,mnt,high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);

  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,mnt,high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_WIDTH,3);
  

  level=level414;
  levels="u414c";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_CHANNEL,0,time1,High[shift1],Time[shift2]+(((shift1-shift2)*1.5)*PeriodSeconds()),high_price+level,time1,high_price-(level/3));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_BGCOLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_BACK,True);
  
    

  level=level618;
  levels="u618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,mnt,high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);

  level=level886;
  levels="u886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+level,mnt,high_price+level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);



  level=level1618;
  levels="u1618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+(level*1),mnt,high_price+(level*1));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrChartreuse);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_WIDTH,1);
  

  level=level1886;
  levels="u1886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+(level*1),mnt,high_price+(level*1));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrChartreuse);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_WIDTH,1);
    
  

  level=level886;
  levels="u886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,high_price+(level*2),mnt,high_price+(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrLimeGreen);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_WIDTH,2);
     
     
     




}

/////////////////////////////////////////////////////////////////////////////////////////////

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
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price,mnt,high_price);
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
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
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
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
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
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=48.82;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*52.69);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




levels=60.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=79.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=38.2;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
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




////////////////////////////////////////////////////////////////////////////////////////////




double z=DivZero(shift1-shift2,4);


levels=61.81;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpFib"+level);
ObjectCreate(ChartID(),last_select_object+"ExpFib"+level,OBJ_TREND,0,Time[shift2],high_price,Time[shift2]+int(z)*PeriodSeconds(),high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpFib"+level,OBJPROP_SELECTED,True);


double fib_high_price=high_price;
double fib_low_price=high_price-yuzde*levels;
double fib_yuzde=DivZero(fib_high_price-fib_low_price,100);

levels=45.01;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpEx"+level);
ObjectCreate(ChartID(),last_select_object+"ExpEx"+level,OBJ_TREND,0,Time[shift2]+int(z)*PeriodSeconds(),fib_low_price,Time[shift2]+int(z+(z/2))*PeriodSeconds(),fib_low_price+fib_yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpEx"+level,OBJPROP_SELECTED,False);

levels=45.02;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/1))*PeriodSeconds(),fib_low_price+fib_yuzde*levels,Time[shift2]-int(z+(z/10))*PeriodSeconds(),fib_low_price+fib_yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);


levels=45.03;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+int(z+(z/2))*PeriodSeconds(),fib_low_price+fib_yuzde*levels,Time[shift2]+int(z+(z/0.5))*PeriodSeconds(),fib_low_price-fib_yuzde*88.6);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);




if ( fibo_tp_level == true ) {


//Alert("Selam");



       double tepe_fiyats=high_price;
        double dip_fiyats=low_price;
        
        
        datetime time1=Time[shift1];
        
        
        


//Alert("Selam");


  double high_price=tepe_fiyats;
   double low_price=dip_fiyats;
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
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50   
   double level1618=yuzde*161.8; // 50 
   double level1886=yuzde*188.6; // 50 
   
   double level0=0;
   double level100=0; 

  double level=level168;
  string levels="d168";       
  string names=last_select_object +"Exp";
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,mnt,low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);   


  level=eq;
  levels="deq";    
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,eq,mnt,eq);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,mnt,low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,mnt,low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);

  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,mnt,low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_WIDTH,3);
  
  
  level=level414;
  levels="d414c";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_CHANNEL,0,time1,Low[shift1],Time[shift2]+(((shift1-shift2)*1.5)*PeriodSeconds()),low_price-level,time1,Low[shift1]+(level/3));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_WIDTH,1);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_BGCOLOR,clrYellow);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_BACK,True);
  
  
  //Alert(shift1-shift2);
  
  

  level=level618;
  levels="d618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,mnt,low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);
  

  level=level886;
  levels="d886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-level,mnt,low_price-level);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,tp_level);
  

  level=level1618;
  levels="d1618";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-(level*1),mnt,low_price-(level*1));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrChartreuse);
  
  level=level1886;
  levels="d1886";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-(level*1),mnt,low_price-(level*1));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrChartreuse);
  
  
  
  
  level=level886;
  levels="d886sl";       
  ObjectDelete(ChartID(),names+"Level"+levels);
  ObjectCreate(ChartID(),names+"Level"+levels,OBJ_TREND,0,time1,low_price-(level*2),mnt,low_price-(level*2));
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_COLOR,clrLimeGreen);
  ObjectSetInteger(ChartID(),names+"Level"+levels,OBJPROP_WIDTH,2);
  

  
  


}

/////////////////////////////////////////////////////////////////////////////////////////////



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


void EngineCopyFibLevel() {

    int obj_total=ObjectsTotal()-1;
  string names;
  for(int ii=ObjectsTotal();ii>=0;ii--)
    {
     names = ObjectName(ii);
     
     //string obj_tooltip=ObjectGetString(ChartID(),names,OBJPROP_TOOLTIP);
     
     if (  StringFind(names,last_select_object,0) != -1 ) {
     
     if (  StringFind(names,"Exp45",0) != -1 || StringFind(names,"Exp55",0) != -1 || StringFind(names,"Exp61",0) != -1 ) {
     
          int obj_typ = ObjectGetInteger(ChartID(),names,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),names,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),names,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),names,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),names,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),names,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),names,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),names,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),names,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),names,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),names,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),names,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),names,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),names,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),names,OBJPROP_BACK);     
          int obj_style = ObjectGetInteger(ChartID(),names,OBJPROP_STYLE); 
          
          
              
          datetime obj_times = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          
          
          
          string level=names;
          
          
          int rplc=StringReplace(level,last_select_object+"Exp","");
          
          string last_select_objectx=last_select_object;
          
          int rplcs=StringReplace(last_select_objectx,"Trendline ",+int(obj_times)+"CopyLine ");
          
          
          //rplc+=StringReplace(last_select_objectx,last_select_object+"Exp","CopyObject"+int(obj_time1));
          

//ObjectDelete(ChartID(),last_select_objectx+"Exp"+level);

Print(level);


ObjectCreate(ChartID(),last_select_objectx+"Exp"+level,OBJ_TREND,0,obj_time1,obj_prc1,obj_time2,obj_prc2);
ObjectSetInteger(ChartID(),last_select_objectx+"Exp"+level,OBJPROP_RAY,obj_ray);
ObjectSetInteger(ChartID(),last_select_objectx+"Exp"+level,OBJPROP_COLOR,obj_color);
ObjectSetInteger(ChartID(),last_select_objectx+"Exp"+level,OBJPROP_STYLE,obj_style);
ObjectSetInteger(ChartID(),last_select_objectx+"Exp"+level,OBJPROP_WIDTH,obj_width);
ObjectSetInteger(ChartID(),last_select_objectx+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectx+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_objectx+"Exp"+level,OBJPROP_SELECTED,False);


          
     
     
     }
     
     }
     
     
     
     
     
     }
     

}









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



void SkyperBomb (string sparam) {



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp41.40",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false ) {

string last_select_object_backup=last_select_object;
last_select_object=sparam;

//Alert("Selam");




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
          
         ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTABLE,True);
         ObjectSetInteger(ChartID(),last_select_object,OBJPROP_SELECTED,True);
         
          

if ( price_1 > price_2 ) {          
         // Alert("Selam");
          
double low_price=Low[shift2];
double high_price=High[shift1];
          

for (int i=shift2;i<shift1;i++) {
//for (int i=shift2;i>shift1;i--) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


ObjectMove(ChartID(),last_select_object,1,Time[shift2],low_price);



last_select_object=last_select_object_backup;




double levels=41.5;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


          obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          int shifts1=iBarShift(Symbol(),Period(),obj_time1);
          int shifts2=iBarShift(Symbol(),Period(),obj_time2);

          obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          
          
levels=41.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_CHANNEL,0,Time[shifts2],obj_prc2,Time[shift2],low_price,Time[shifts2],obj_prc2+20*Point);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=41.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shifts2]+500*PeriodSeconds(),obj_prc2,Time[shifts2+500],obj_prc2+20*Point);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Bars,obj_prc2,mnt,obj_prc2+20*Point);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

          
levels=41.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shifts1],obj_prc1,Time[shift2],low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


levels=41.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"77777"+level);
ObjectCreate(ChartID(),last_select_object+"77777"+level,OBJ_TREND,0,Time[shifts1],obj_prc1,Time[shift2],low_price);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_SELECTED,True);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_WIDTH,2);


          

         
          
          } else {
          
          
double low_price=Low[shift1];
double high_price=High[shift2];
          

for (int i=shift2;i<shift1;i++) {
//for (int i=shift2;i>shift1;i--) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


ObjectMove(ChartID(),last_select_object,1,Time[shift2],high_price);



last_select_object=last_select_object_backup;




double levels=41.5;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price,mnt,high_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


          obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          int shifts1=iBarShift(Symbol(),Period(),obj_time1);
          int shifts2=iBarShift(Symbol(),Period(),obj_time2);

          obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          
          
levels=41.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_CHANNEL,0,Time[shifts2],obj_prc2,Time[shift2],high_price,Time[shifts2],obj_prc2-20*Point);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=41.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shifts2]+500*PeriodSeconds(),obj_prc2,Time[shifts2+500],obj_prc2+20*Point);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Bars,obj_prc2,mnt,obj_prc2-20*Point);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrYellow);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

          
levels=41.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shifts1],obj_prc1,Time[shift2],high_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

 
levels=41.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"77777"+level);
ObjectCreate(ChartID(),last_select_object+"77777"+level,OBJ_TREND,0,Time[shifts1],obj_prc1,Time[shift2],high_price);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_SELECTED,True);
ObjectSetInteger(ChartID(),last_select_object+"77777"+level,OBJPROP_WIDTH,2);

          
          
          
          
          
          
          }
          


          
          
          
          
          }
          
          
          
          



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"Exp21.00",0) != -1 && StringFind(sparam,"MAL",0) == -1 && lock == false ) {

string last_select_object_backup=last_select_object;
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
          

if ( price_2 > price_1 ) {          
         // Alert("Selam");
          
double low_price=Low[shift1];
double high_price=High[shift2];
          

for (int i=shift2;i<shift1;i++) {
//for (int i=shift2;i>shift1;i--) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


ObjectMove(ChartID(),last_select_object,1,Time[shift2],high_price);

double yuzde = DivZero(high_price-low_price, 100);



double high_prices=high_price;//low_price+(levels*yuzde);
double low_prices=low_price;

double yuzdes = DivZero(high_prices-low_prices, 100);


last_select_object=last_select_object_backup;


double levels=41.4;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices,Time[shift2]+30*PeriodSeconds(),low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.5;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),mnt,low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.8;
level=DoubleToString(levels,2);
levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),mnt,low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=88.6;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),mnt,low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=161.8;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),mnt,low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=241.4;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices-(levels*yuzdes),mnt,low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

         
          
          } else {
          

double low_price=Low[shift2];
double high_price=High[shift1];
          

for (int i=shift2;i<shift1;i++) {
//for (int i=shift2;i>shift1;i--) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


ObjectMove(ChartID(),last_select_object,1,Time[shift2],low_price);



double yuzde = DivZero(high_price-low_price, 100);



double high_prices=high_price;//low_price+(levels*yuzde);
double low_prices=low_price;

double yuzdes = DivZero(high_prices-low_prices, 100);


last_select_object=last_select_object_backup;


double levels=41.4;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_prices,Time[shift2]+30*PeriodSeconds(),high_prices+(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);



levels=41.5;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices+(levels*yuzdes),mnt,high_prices+(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.8;
level=DoubleToString(levels,2);
levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices+(levels*yuzdes),mnt,high_prices+(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=88.6;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices+(levels*yuzdes),mnt,high_prices+(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrNavy);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=161.8;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices+(levels*yuzdes),mnt,high_prices+(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=241.4;
level=DoubleToString(levels,2);
//levels=41.4;
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices+(levels*yuzdes),mnt,high_prices+(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrMaroon);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

         
          
          
          
          
          }
          


          
          
          
          
          
          
          
          
          }
          
          
          


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"77777",0) == -1 && StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false ) {





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


double yuzde = DivZero(high_price-low_price, 100);


double levels=21;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,Time[shift2]+30*PeriodSeconds(),low_price+(levels*yuzde));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

double high_prices=low_price+(levels*yuzde);
double low_prices=low_price;

double yuzdes = DivZero(high_prices-low_prices, 100);


levels=41.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+30*PeriodSeconds(),high_prices,Time[shift2]+50*PeriodSeconds(),low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.5;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+30*PeriodSeconds(),low_prices-(levels*yuzdes),mnt,low_prices-(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);


} else {


ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);


low_price=Low[shift1];
high_price=High[shift2];



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



double yuzde = DivZero(high_price-low_price, 100);


double levels=21;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price,Time[shift2]+30*PeriodSeconds(),high_price-(levels*yuzde));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


double high_prices=high_price;
double low_prices=high_price-(levels*yuzde);

double yuzdes = DivZero(high_prices-low_prices, 100);


levels=41.4;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+30*PeriodSeconds(),low_prices,Time[shift2]+50*PeriodSeconds(),high_prices+(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.5;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+30*PeriodSeconds(),high_prices+(levels*yuzdes),mnt,high_prices+(levels*yuzdes));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGray);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=41.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);





}


ChartRedraw();


}

}


extern int LinesAboveBelow= 10;
color LineColorMain= DarkGray;
color LineColorSub= DarkGray;

double dPt;


double open_order=false;
double first_question=false;

void Ict() {


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%50;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*50); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
            
      

      
      
         
      SetLevel(DoubleToStr(ds1,Digits), ds1,  linecolor, style, Time[10]);
   }
   
   
}


void Ict250() {


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%25;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*25); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
      SetLevel(DoubleToStr(ds1,Digits), ds1,  clrLightGray, STYLE_DOT, Time[10]);
   }
   
   
}



void SetLevel(string text, double level, color col1, int linestyle, datetime startofday)
{
   int digits= Digits;
   string linename= "[SweetSpot] " + text + " Line",
          pricelabel; 

   // create or move the horizontal line   
   if (ObjectFind(ChartID(),linename) != 0) {
      ObjectCreate(ChartID(),linename, OBJ_HLINE, 0, 0, level);
      ObjectSetInteger(ChartID(),linename, OBJPROP_STYLE, linestyle);
      ObjectSetInteger(ChartID(),linename, OBJPROP_COLOR, col1);
      ObjectSetInteger(ChartID(),linename, OBJPROP_WIDTH, 0);
   }
   else {
      ObjectMove(ChartID(),linename, 0, Time[0], level);
   }
}

void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


}
