//+------------------------------------------------------------------+
//|                                                  CandleRange.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double Lot=0.10;
//double Lot=1;

int magic=317;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   ObjectsDeleteAll();
   
   Ortalama=BarOrtalama(1,300,Symbol(),Period());
   
   if ( Ortalama < 13*Point ) {
   Ortalama=13*Point;
   }
   
   Comment("Ortalama:",Ortalama/Point);
   /*
   for (int i=1;i<300;i++) {
   
   if ( MathAbs(Open[i]-Close[i]) > Ortalama*6 ) {
   
   ObjectCreate(ChartID(),"V"+i,OBJ_VLINE,0,Time[i],Ask);
   
 SessionTokyo("Tokyo",Time[i]);
   
   
   }
   
   
   }
   */
   
   ChartSetInteger(ChartID(),CHART_AUTOSCROLL,true);
   
   ObjectDelete("VLINE");
   ObjectCreate(ChartID(),"VLINE",OBJ_VLINE,0,Time[87],Ask);
   
   
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

datetime last_bar_time=-1;

void OnTick()
  {
//---

if ( MathAbs(Open[1]-Close[1]) > Ortalama*6 && last_bar_time!=Time[1] ) {

ObjectCreate(ChartID(),"V"+Time[1],OBJ_VLINE,0,Time[1],Ask);
last_bar_time=Time[1];


   double low_price=Low[1];
   double high_price=High[1];


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
   double level342=yuzde*34.2; // 50      
   
   double level0=0;
   double level100=0; 


   double tepe_prc=high_price;
   double dip_prc=low_price;
   double fractal133=(tepe_prc-dip_prc)*1.133;
         //fractal133=dip_prc+fractal133;  
         
         
  datetime ty_start_time=Time[1];
  datetime ty_end_time=Time[1]+5*PeriodSeconds();
  

  double level=fractal133*1.3;
  string levels="uf1133";  
  string name="CandleCash"+Time[1];      
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
  
  /*
  if ( int(TimeHour(Time[1])) > 8 && int(TimeHour(Time[1])) < 15 ) {
  if ( Open[1] > Close[1] ) {
  int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,Open[1],low_price-level,"SELL",magic,0,clrNONE);
  }
  
  if ( Close[1] > Open[1] ) {
  int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Open[1],high_price-level,"BUY",magic,0,clrNONE);
  }
  }
  */
  
  
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////

  level=level342;
  levels="u342";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);


  level=level618;
  levels="u618";   
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

/*
if ( int(TimeHour(Time[1])) > 8 && int(TimeHour(Time[1])) < 15 ) {
  if ( Open[1] > Close[1] ) {
  //int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,Open[1],low_price-level,"SELL",magic,0,clrNONE);
  int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,high_price+level,low_price-level,"SELL",magic,0,clrNONE);
  }
  
  if ( Close[1] > Open[1] ) {
  //int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Open[1],high_price+level,"BUY",magic,0,clrNONE);
  int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,low_price-level,high_price+level,"BUY",magic,0,clrNONE);
  }
}
  */
 
  
  

  level=level886;
  levels="u886";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

//yuzde <= 6*Point &&
if ( int(TimeHour(Time[1])) > 8 && int(TimeHour(Time[1])) < 15 &&  DayOfWeek()!=5
) {
  if ( Open[1] > Close[1] ) {
  //int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,Open[1],low_price-level,"SELL",magic,0,clrNONE);
  int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,high_price+level,low_price-level,"SELL",magic,0,clrNONE);
  }
  
  if ( Close[1] > Open[1] ) {
  //int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,Open[1],high_price+level,"BUY",magic,0,clrNONE);
  int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,low_price-level,high_price+level,"BUY",magic,0,clrNONE);
  }
  }
  

  level=fractal133*1.3;
  levels="df1133";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2); 
    


////////////////////////////////////////////////////////////////////////////////////////////////////////////

  level=level342;
  levels="d342";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);



  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level886;
  levels="d886";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////   









}

   
   
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

datetime last_time;

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---


if ( sparam == 45 ) {
draw = false;
ObjectsDeleteAll(ChartID(),-1,OBJ_RECTANGLE);
ObjectsDeleteAll(ChartID(),-1,OBJ_TREND);
ObjectsDeleteAll(ChartID(),-1,OBJ_HLINE);
ObjectsDeleteAll(ChartID(),-1,OBJ_VLINE);

}

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_VLINE ) {

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME) == 0 ) return;

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME) != last_time ) {draw=false;

SessionTokyo("Tokyo",ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME));
last_time=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME);
Print(last_time,"/",ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME));

ObjectSetInteger(ChartID(),sparam,OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STYLE,STYLE_DOT);

}


  int obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     
     if ( ObjectGetInteger(ChartID(),name,OBJPROP_TYPE) == OBJ_TREND ) {
     ObjectSetInteger(ChartID(),name,OBJPROP_TIME,1,Time[0]);
     }
     
     
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


double Ortalama;
   //string sym=Symbol();
   ENUM_TIMEFRAMES per=Period();
   
   string symi=Symbol();
   ENUM_TIMEFRAMES peri=Period();   
   

double Openi(int shifti) {
return iOpen(symi,peri,shifti);
}

double Closei(int shifti) {
return iClose(symi,peri,shifti);
}

double Highi(int shifti) {
return iHigh(symi,peri,shifti);
}

double Lowi(int shifti) {
return iLow(symi,peri,shifti);
}

double Timei(int shifti) {
return iTime(symi,peri,shifti);
}


//datetime ty_start_time;
datetime ty_end_time;

datetime lnd_start_time;
datetime lnd_end_time;

bool london_start=false;
bool london_end=false;
bool tokyo_start=false;
bool tokyo_end=false;

//int magic=31;
string sym=Symbol();


int full_pips=-1;
int half_pips=-1;

bool draw=false;

void SessionTokyo(string sname,datetime ty_start_time) {

if ( draw == true ) return;


draw=true;
/*
ChartSetSymbolPeriod(ChartID(),Symbol(),PERIOD_M1);
peri=PERIOD_M1;
per=PERIOD_M1;*/
per=Period();
//SessionOrder("Tokyo");


ObjectsDeleteAll(ChartID(),-1,OBJ_RECTANGLE);
ObjectsDeleteAll(ChartID(),-1,OBJ_TREND);
ObjectsDeleteAll(ChartID(),-1,OBJ_HLINE);



if ( sname=="Tokyo" ) {




  int cshift=iBarShift(sym,per,ty_start_time);
 
   if ( Close[cshift] > Open[cshift] ) {
   
   //Alert("Selam");
   
 
  string cname="TokyoLevelB+1"+Timei(1);
  string cn="OP";

  ObjectDelete(ChartID(),cname+cn);
  if ( Close[cshift+1] > Open[cshift+1] ) ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift+1],Open[cshift+1],Time[cshift+100],Open[cshift+1]);
  if ( Close[cshift+1] < Open[cshift+1] ) ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift+1],Close[cshift+1],Time[cshift+100],Close[cshift+1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 
  
  cname="TokyoLevelB-1"+Timei(1);

  ObjectDelete(ChartID(),cname+cn);
  if ( Close[cshift-1] > Open[cshift-1] ) ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift-1],Open[cshift-1],Time[cshift+100],Open[cshift-1]);
  if ( Close[cshift-1] < Open[cshift-1] ) ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift-1],Close[cshift-1],Time[cshift+100],Close[cshift-1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 
  
    
  
  cname="TokyoLevelB+1"+Timei(1);
  cn="HIGH";

  ObjectDelete(ChartID(),cname+cn);
  ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift+1],High[cshift+1],Time[cshift+100],High[cshift+1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 
  
  cname="TokyoLevelB-1"+Timei(1);
  cn="LOW";

  ObjectDelete(ChartID(),cname+cn);
  ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift-1],Low[cshift-1],Time[cshift+100],Low[cshift-1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 


  cname="TokyoLevelB-1"+Timei(1);
  cn="HIGH";

  ObjectDelete(ChartID(),cname+cn);
  ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift-1],High[cshift-1],Time[cshift+100],High[cshift-1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 
  
  
    
  
   }
   
 


   if ( Open[cshift] > Close[cshift] ) {
 
  string cname="TokyoLevelB+1"+Timei(1);
  string cn="OP";

  ObjectDelete(ChartID(),cname+cn);
  if ( Close[cshift+1] < Open[cshift+1] ) ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift+1],Open[cshift+1],Time[cshift+100],Open[cshift+1]);
  if ( Close[cshift+1] > Open[cshift+1] ) ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift+1],Close[cshift+1],Time[cshift+100],Close[cshift+1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 
  
  cname="TokyoLevelB-1"+Timei(1);

  ObjectDelete(ChartID(),cname+cn);
  if ( Close[cshift-1] < Open[cshift-1] ) ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift-1],Open[cshift-1],Time[cshift+100],Open[cshift-1]);
  if ( Close[cshift-1] > Open[cshift-1] ) ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift-1],Close[cshift-1],Time[cshift+100],Close[cshift-1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 
  
    
  
  cname="TokyoLevelB-1"+Timei(1);
  cn="HIGH";

  ObjectDelete(ChartID(),cname+cn);
  ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift-1],High[cshift-1],Time[cshift+100],High[cshift-1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 
  
  cname="TokyoLevelB+1"+Timei(1);
  cn="LOW";

  ObjectDelete(ChartID(),cname+cn);
  ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift+1],Low[cshift+1],Time[cshift+100],Low[cshift+1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 


  cname="TokyoLevelB-1"+Timei(1);
  cn="LOW";

  ObjectDelete(ChartID(),cname+cn);
  ObjectCreate(ChartID(),cname+cn,OBJ_TREND,0,Time[cshift-1],Low[cshift-1],Time[cshift+100],Low[cshift-1]);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),cname+cn,OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_WIDTH,1); 
  ObjectSetInteger(ChartID(),cname+cn,OBJPROP_ZORDER,1); 
  
  
    
  
   }
   
   
   
 
 //return;
 

//Alert("Tokyo");


//if ( (int(TimeHour(Timei(1))) == 11  && int(TimeMinute(Timei(1))) == 0 && tokyo_end == false) || (int(TimeHour(Timei(1))) > 11  &&  tokyo_end == false)  ) {

//Alert("Tokyo2");



  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
 /* string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 03:00";
  if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 03:00";
  datetime some_time = StringToTime(yenitarih);
  
  ty_start_time=some_time;*/


  ///yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  /*yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 12:00";
  if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 12:00";
  some_time = StringToTime(yenitarih);*/
  
  datetime some_time = ty_start_time+PeriodSeconds();
  
  
  
  /*
//////////////////////////////////////////////////////////////////////////////////////
// Cdbr Change Time
//////////////////////////////////////////////////////////////////////////////////////  
  if ( int(int(TimeHour(TimeCurrent()))) < 12 ) {
  int cevap=MessageBox("Cdbr Time","Cdbr Session",4); //  / Spread:"+Spread_Yuzde+"%"
  if ( cevap == 6 && int(int(TimeHour(TimeCurrent()))) < 12  ) {
  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 09:00";
  string   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent()))-1)+" 21:00"; 
  if ( StringFind(AccountCompany(),"Robo",0) == -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+int(int(TimeDay(TimeCurrent()))-1)+" 21:00";
  datetime some_time = StringToTime(yenitarih);
  
  ty_start_time=some_time;


  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 11:00";
  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 15:25";
  //yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 16:25";  // tr
   yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 03:00";
  if ( StringFind(AccountCompany(),"Robo",0) == -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 03:00";
  some_time = StringToTime(yenitarih);   
  }
  }
//////////////////////////////////////////////////////////////////////////////////////
  */
  
  
  
  
  
  if ( Time[0] < some_time ) some_time=Time[0];
  

  int ty_end_shift=iBarShift(sym,per,some_time);


   ty_end_time=Timei(ty_end_shift);
   //ty_end_time=Timei(1);

   string name="TOKYO-END-"+Timei(ty_end_shift);
   
   ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(ty_end_shift),Highi(ty_end_shift));
   //ObjectCreate(ChartID(),name,OBJ_VLINE,0,Timei(1),Highi(1));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //ObjectSetString(ChartID(),name,OBJPROP_TEXT,"Fark Oran:"+fark_oran);
   ObjectDelete(ChartID(),name);
   

   
   tokyo_end=true;


 int shift=iBarShift(sym,per,ty_start_time);
   
   double low_price=Low[shift];
   double high_price=High[shift];
   
   int Trend_Screen_High_Shift=shift;
   int Trend_Screen_Low_Shift=shift-1;
   
   //for(int s=shift;s>0;s--) {
   /*for(int s=shift;s>=ty_end_shift;s--) {
   
      
   if ( Lowi(s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=Lowi(s);
   }
   
   if ( Highi(s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=Highi(s);
   }
      
   
   
   }*/








   name="TokyoSession"+Timei(1);
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,ty_start_time,high_price,ty_end_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetString(ChartID(),name,OBJPROP_TOOLTIP,"TOKYO");
   ObjectSetInteger(ChartID(),name,OBJPROP_BACK,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);
   ObjectSetInteger(ChartID(),name,OBJPROP_FILL,false);
   ObjectDelete(name);
   
   
   /*
if ( MarketInfo(sym,MODE_ASK) <= high_price && MarketInfo(sym,MODE_BID) >= low_price ) {
//Alanın İçi 
} else {
//Alanın Dışı
tokyo_end=true;
return;
}*/
   
   
   
   full_pips=(high_price-low_price)/Point;
   half_pips=DivZero(full_pips,2);
   
    //Alert(full_pips,"/",half_pips);
  

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
   double level342=yuzde*34.2; // 50      
   
   double level0=0;
   double level100=0; 


   double tepe_prc=high_price;
   double dip_prc=low_price;
   double fractal133=(tepe_prc-dip_prc)*1.133;
         //fractal133=dip_prc+fractal133;     

   

  name="TokyoLevel"+Timei(1);
  double level;   
  string levels; 
  ObjectDelete(ChartID(),name+"Eq");
  ObjectCreate(ChartID(),name+"Eq",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_COLOR,clrLightGray);   
  ObjectSetString(ChartID(),name+"Eq",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_WIDTH,4); 
  ObjectSetInteger(ChartID(),name+"Eq",OBJPROP_ZORDER,1);  
  
  
  ObjectDelete(ChartID(),name+"Eqs");
  ObjectCreate(ChartID(),name+"Eqs",OBJ_TREND,0,ty_start_time,eq,ty_end_time,eq);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_COLOR,clrDarkBlue); 
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_ZORDER,2);  
  ObjectSetString(ChartID(),name+"Eqs",OBJPROP_TOOLTIP,"TOKYO EQ");   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_STYLE,STYLE_DOT);   
  ObjectSetInteger(ChartID(),name+"Eqs",OBJPROP_WIDTH,2);
  
   
/*
  level=level45;
  levels="45";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
     
   
  level=level55;
  levels="55";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
  
 level=level79;
  levels="79";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);
    
 level=level70;
  levels="70";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level21;
  levels="21";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);

 level=level30;
  levels="30";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,level,ty_end_time,level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         

*/
  int ticket;
  


  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  


  level=level168;
  levels="u168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  

     
  level=level130;
  levels="u130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
   /*
  price=NormalizeDouble(high_price+level,MarketInfo(sym,MODE_DIGITS));
  //if ( (high_price-MarketInfo(sym,MODE_ASK))/MarketInfo(sym,MODE_POINT) > 5 )
  if ( (high_price-MarketInfo(sym,MODE_ASK)) > MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID) )  price=NormalizeDouble(high_price,MarketInfo(sym,MODE_DIGITS));
  if ( sell_total == 0 ) ticket=OrderSend(sym,OP_SELLLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);*/


  level=level272;
  levels="u272";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  levels="u272line";  
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_HLINE,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);  



  level=level342;
  levels="u342";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
    

   level=fractal133*1.3;
  levels="uf1133";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);

    
  
  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
     


////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="u618";   
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level886;
  levels="u886";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////  










/*
////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level0;
  levels="d00";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
  
  
  level=level100;
  levels="u100";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////  
*/  
  


  level=level0;
  levels="d000";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  

  level=level168;
  levels="d168";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level130;
  levels="d130";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
/*
  price=NormalizeDouble(low_price-level,MarketInfo(sym,MODE_DIGITS));
  //if ( (MarketInfo(sym,MODE_BID)-low_price)/MarketInfo(sym,MODE_POINT) > 5 ) price=NormalizeDouble(low_price,MarketInfo(sym,MODE_DIGITS));
  if ( (MarketInfo(sym,MODE_BID)-low_price) > MarketInfo(sym,MODE_ASK)-MarketInfo(sym,MODE_BID) ) price=NormalizeDouble(low_price,MarketInfo(sym,MODE_DIGITS));
    
  if ( buy_total == 0 ) ticket=OrderSend(sym,OP_BUYLIMIT,Lot,price,0,0,0,levels,magic,0,clrNONE);*/

  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  levels="d272line"; 
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_HLINE,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  

  level=level342;
  levels="d342";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrLightGray);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);


  level=fractal133*1.3;
  levels="df1133";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2); 
    
     
   
  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);     



////////////////////////////////////////////////////////////////////////////////////////////////////////////
  level=level618;
  levels="d618";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level886;
  levels="d886";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
///////////////////////////////////////////////////////////////////////////////////////////////////////////   





   



   
//}



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
   
   //bar_pip = bar_pip + MathAbs(Close[t]-Open[t]);
   ///bar_pip = bar_pip + MathAbs(Close[t]-Open[t]);
   bar_pip = bar_pip + MathAbs(iClose(Sym,Per,t)-iOpen(Sym,Per,t));
   
   }
  
   
   bar_ortalama = bar_pip / bar_toplam;
   
   return bar_ortalama;

}

