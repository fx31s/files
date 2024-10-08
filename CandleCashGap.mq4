//+------------------------------------------------------------------+
//|                                                  CandleRange.mq4 |
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

//if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME) != last_time ) {
draw=false;

SessionTokyo("Tokyo",ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME));
last_time=ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME);
Print(last_time,"/",ObjectGetInteger(ChartID(),sparam,OBJPROP_TIME));
//}


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

int magic=31;
string sym=Symbol();


int full_pips=-1;
int half_pips=-1;

bool draw=false;

bool gap=true;

void SessionTokyo(string sname,datetime ty_start_time) {


Print("Selam");

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
   
   
   if ( gap == false ) {
   if ( Open[shift] > Close[shift] ) {

   low_price=Low[shift+1];
   high_price=High[shift-1];      
   }
   
   if ( Close[shift] > Open[shift] ) {

   low_price=Low[shift-1];
   high_price=High[shift+1];      
   }
   gap=true;
   } else {
   gap=false;
   }  
   
   
   Comment("Gap",gap);
   
   draw=false;
   
   
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
