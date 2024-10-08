//+------------------------------------------------------------------+
//|                                                  NewyorkTime.mq4 |
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
   
   Comment("NewYork Soliton (S)aat (D)akika(25/30) (T) Saat M MaxSize");
   
   
   NewyorkTime();
   /*
   ObjectsDeleteAll();
   
   
   for(int i=Bars;i>0;i--) {
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 17 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) {
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 19 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) { // Nas
   string name="V1800"+i;
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,i),iClose(Symbol(),PERIOD_M1,i),iTime(Symbol(),PERIOD_M1,i)+90*PeriodSeconds(PERIOD_M1),iClose(Symbol(),PERIOD_M1,i));
   //ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M15,i),iHigh(Symbol(),PERIOD_M1,i),iTime(Symbol(),PERIOD_M1,i)+90*PeriodSeconds(PERIOD_M1),iLow(Symbol(),PERIOD_M15,i));
   ObjectCreate(ChartID(),name,OBJ_RECTANGLE,0,iTime(Symbol(),PERIOD_M1,i),iHigh(Symbol(),PERIOD_M1,i),iTime(Symbol(),PERIOD_M1,i)-900*PeriodSeconds(PERIOD_M1),iLow(Symbol(),PERIOD_M1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrKhaki);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);

      
   
   }
   
      
   
   }
      
   */
   
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

int dakika=25;
int saat=9;
bool max_size=true;

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

//Print(sparam);

if ( sparam == 50 ) {


if ( max_size == true ) { max_size=false;} else {max_size=true;}

Comment("MaxSize:",max_size);

NewyorkTime();

}

if ( sparam == 32 ) {

if ( dakika==30 ) { dakika=25;} else {dakika=30;}

Comment("Dakika:",dakika);

NewyorkTime();


}


if ( sparam == 31 ) {

if ( saat==9 ) { saat=2;} else {saat=9;}

Comment("Saat:",saat);

NewyorkTime();


}

if ( sparam == 20 ) {

if ( saat==11 ) { saat=9;} else {saat=11;}

Comment("Saat:",saat);

NewyorkTime();


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


void NewyorkTime() {



   
   datetime ny_start_time;
   double ny_start_price;
   datetime lnd_start_time;
   double lnd_start_price;
   double high_price;
   double low_price;
   
   ObjectsDeleteAll();
   
   
   for(int i=150000;i>0;i--) {
   
   if( Bars < i ) continue;
   

   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 9 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) {
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 2 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) {
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == saat && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) {
   
   string name="V100"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,i),iClose(Symbol(),PERIOD_M1,i),iTime(Symbol(),PERIOD_M1,i)+90*PeriodSeconds(PERIOD_M1),iClose(Symbol(),PERIOD_M1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrKhaki);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   lnd_start_time=iTime(Symbol(),PERIOD_M1,i);
   lnd_start_price=iClose(Symbol(),PERIOD_M1,i);
   }
   
   
   

   
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 15 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 30  ) {
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 15 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 25  ) {
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 15 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == dakika  ) {
   
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 19 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 0  ) {
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 15 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 0  ) {
   ///if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 16 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 30  ) {
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 17 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) { // nas
   
   
   ///if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 18 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) { // london close
   
   string name="V1630"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,i),iClose(Symbol(),PERIOD_M1,i),iTime(Symbol(),PERIOD_M1,i)+90*PeriodSeconds(PERIOD_M1),iClose(Symbol(),PERIOD_M1,i));
   //ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   if ( max_size == true ) ObjectDelete(name);
   
   ny_start_time=iTime(Symbol(),PERIOD_M1,i);
   ny_start_price=iClose(Symbol(),PERIOD_M1,i);
   
   name="VBoxLnd"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,ny_start_time,ny_start_price,lnd_start_time,lnd_start_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   


   
      
   
   
   //double high_price;
   //double low_price;
   
   if ( lnd_start_price < ny_start_price ) {low_price=lnd_start_price;high_price=ny_start_price;}
   if ( lnd_start_price > ny_start_price ) {high_price=lnd_start_price;low_price=ny_start_price;}
   
/////////////////////////////////////////////////////////////////////////////////////////////////////////


if ( max_size == true ) {
 int shift=iBarShift(Symbol(),PERIOD_M1,lnd_start_time);
 int end_shift=iBarShift(Symbol(),PERIOD_M1,ny_start_time);
   
   low_price=1000000;
   high_price=-1;
   
   int Trend_Screen_High_Shift;
   int Trend_Screen_Low_Shift;
   
   //for(int s=shift;s>0;s--) {
   for(int s=shift;s>=end_shift;s--) {
   
      
   if ( iLow(Symbol(),PERIOD_M1,s) < low_price ) {
   Trend_Screen_Low_Shift=s;
   low_price=iLow(Symbol(),PERIOD_M1,s);
   }
   
   if ( iHigh(Symbol(),PERIOD_M1,s) > high_price ) {
   Trend_Screen_High_Shift=s;
   high_price=iHigh(Symbol(),PERIOD_M1,s);
   }
      
   
   
   }

   double yuzde = DivZero(high_price-low_price, 100);

   double eq=low_price+yuzde*50; // 50


  string yenitarih= TimeYear(iTime(Symbol(),PERIOD_M1,i))+"."+TimeMonth(iTime(Symbol(),PERIOD_M1,i))+"."+TimeDay(iTime(Symbol(),PERIOD_M1,i))+" 15:25";
  datetime some_time = StringToTime(yenitarih);

   name="VLine1625"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,high_price,some_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLimeGreen);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);  
   
      

   name="VBoxHL"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,Trend_Screen_High_Shift),high_price,iTime(Symbol(),PERIOD_M1,Trend_Screen_Low_Shift),low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrKhaki);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,2);


   name="VBoxHLRangeEq"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,Trend_Screen_High_Shift),eq,iTime(Symbol(),PERIOD_M1,Trend_Screen_Low_Shift)+480*PeriodSeconds(PERIOD_M1),eq);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);
   //ObjectSetInteger(ChartID(),name,OBJPROP_BACK,true);
   //ChartRedraw();
      


//if ( lnd_start_price < ny_start_price ) {iTime(Symbol(),PERIOD_M1,i)-90*PeriodSeconds(PERIOD_M1)
   name="V1630High"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,lnd_start_time,high_price,iTime(Symbol(),PERIOD_M1,i)+90*PeriodSeconds(PERIOD_M1),high_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   //}

//if ( lnd_start_price > ny_start_price ) {iTime(Symbol(),PERIOD_M1,i)-90*PeriodSeconds(PERIOD_M1)
   name="V1630Low"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,lnd_start_time,low_price,iTime(Symbol(),PERIOD_M1,i)+90*PeriodSeconds(PERIOD_M1),low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
//}
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////   
      
   
   double yuzde = DivZero(high_price-low_price, 100);

   double eq=low_price+yuzde*50; // 50
   
   //tokyo_eq=eq;
   
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
   
////////////////////////////////////////////   
   double level618=yuzde*61.8; // 50 
   double level886=yuzde*88.6; // 50 
////////////////////////////////////////////    

string levels;
double level;


//if ( lnd_start_price > ny_start_price ) {

  level=level886;
  levels="d886";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,low_price-level,ny_start_time+90*PeriodSeconds(PERIOD_M1),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);


  level=level618;
  levels="d618";    
    
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,low_price-level,ny_start_time+90*PeriodSeconds(PERIOD_M1),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);



  level=level414;
  levels="d414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,low_price-level,ny_start_time+90*PeriodSeconds(PERIOD_M1),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);   
  
  
  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,low_price-level,ny_start_time+90*PeriodSeconds(PERIOD_M1),low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow); 

  level=level272;
  levels="d272s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,low_price+level,ny_start_time+90*PeriodSeconds(PERIOD_M1),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrCrimson);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
  
  
//}  


//if ( lnd_start_price < ny_start_price ) {  

  level=level886;
  levels="u886";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,high_price+level,ny_start_time+90*PeriodSeconds(PERIOD_M1),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
       

  level=level618;
  levels="u618";
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,high_price+level,ny_start_time+90*PeriodSeconds(PERIOD_M1),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
     
   
  level=level414;
  levels="u414";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,high_price+level,ny_start_time+90*PeriodSeconds(PERIOD_M1),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);

  level=level272;
  levels="u272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,high_price+level,ny_start_time+90*PeriodSeconds(PERIOD_M1),high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
  level=level272;
  levels="u272s";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ny_start_time,high_price-level,ny_start_time+90*PeriodSeconds(PERIOD_M1),high_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrCrimson);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);
  
  
  

  
  
  
//}




  string yenitarih= TimeYear(iTime(Symbol(),PERIOD_M1,i))+"."+TimeMonth(iTime(Symbol(),PERIOD_M1,i))+"."+TimeDay(iTime(Symbol(),PERIOD_M1,i))+" 17:00";
  datetime some_time = StringToTime(yenitarih);
  
  int ii=iBarShift(Symbol(),PERIOD_M1,some_time);
  
  







   name="VLineLnd"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,high_price+level886,some_time,low_price-level886);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);  
   
   
/*
  yenitarih= TimeYear(iTime(Symbol(),PERIOD_M1,ii))+"."+TimeMonth(iTime(Symbol(),PERIOD_M1,ii))+"."+TimeDay(iTime(Symbol(),PERIOD_M1,ii))+" 19:30";
  some_time = StringToTime(yenitarih);
   
      
   name="VLineEnd"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,high_price,some_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);  */   
   
  yenitarih= TimeYear(iTime(Symbol(),PERIOD_M1,i))+"."+TimeMonth(iTime(Symbol(),PERIOD_M1,i))+"."+TimeDay(iTime(Symbol(),PERIOD_M1,i))+" 18:00";
  some_time = StringToTime(yenitarih);
  
  int iii=iBarShift(Symbol(),PERIOD_M1,some_time);
  
  //if ( iii > 0 ) {} else {continue;}

   name="V1800"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,high_price,some_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);   
   
   
   
   if ( ii > 0 ) {} else {continue;}
   
   name="VBox"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,ny_start_time,ny_start_price,iTime(Symbol(),PERIOD_M1,ii),iClose(Symbol(),PERIOD_M1,ii));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);




   
   /*

  yenitarih= TimeYear(iTime(Symbol(),PERIOD_M1,ii))+"."+TimeMonth(iTime(Symbol(),PERIOD_M1,ii))+"."+TimeDay(iTime(Symbol(),PERIOD_M1,ii))+" 16:30";
  some_time = StringToTime(yenitarih);
   
      
   name="VLine"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,high_price,some_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   */
   


      
      
   
   }
   
/*
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 18 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) {


  string yenitarih= TimeYear(iTime(Symbol(),PERIOD_M1,i))+"."+TimeMonth(iTime(Symbol(),PERIOD_M1,i))+"."+TimeDay(iTime(Symbol(),PERIOD_M1,i))+" 17:00";
  datetime some_time = StringToTime(yenitarih);
   
      
   string name="VLine"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,high_price,some_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   

   
   }   */
   
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 17 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) {
   
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 19 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) { // Nas
   
   
   //if ( int(TimeHour(iTime(Symbol(),PERIOD_M1,i))) == 18 && int(TimeMinute(iTime(Symbol(),PERIOD_M1,i))) == 00  ) {
   /*
   string name="V1800"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,i),iClose(Symbol(),PERIOD_M1,i),iTime(Symbol(),PERIOD_M1,i)+90*PeriodSeconds(PERIOD_M1),iClose(Symbol(),PERIOD_M1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);

   name="VBox"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,ny_start_time,ny_start_price,iTime(Symbol(),PERIOD_M1,i),iClose(Symbol(),PERIOD_M1,i));
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
      
   name="VLineLnd"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,iTime(Symbol(),PERIOD_M1,i),high_price,iTime(Symbol(),PERIOD_M1,i),low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGray);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);   
   
  string yenitarih= TimeYear(iTime(Symbol(),PERIOD_M1,i))+"."+TimeMonth(iTime(Symbol(),PERIOD_M1,i))+"."+TimeDay(iTime(Symbol(),PERIOD_M1,i))+" 17:00";
  datetime some_time = StringToTime(yenitarih);
   
      
   name="VLine"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,high_price,some_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1);      
   

  yenitarih= TimeYear(iTime(Symbol(),PERIOD_M1,i))+"."+TimeMonth(iTime(Symbol(),PERIOD_M1,i))+"."+TimeDay(iTime(Symbol(),PERIOD_M1,i))+" 19:30";
  some_time = StringToTime(yenitarih);
   
      
   name="VLineEnd"+i;
   ObjectCreate(ChartID(),name,OBJ_TREND,0,some_time,high_price,some_time,low_price);
   ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrBlack);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,false);
   ObjectSetInteger(ChartID(),name,OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),name,OBJPROP_RAY,False);
   ObjectSetInteger(ChartID(),name,OBJPROP_WIDTH,1); */ 
   
      

   
   }
      



      
      
         
   
   
   
}


}