//+------------------------------------------------------------------+
//|                                                         ipda.mq4 |
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

ENUM_TIMEFRAMES per=Period();
bool start_clear=false;
string sym=Symbol();

int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
   if ( per == Period() ) start_clear = false;
   if ( sym!=Symbol() ) start_clear=false;
   
   if (start_clear == false ) ObjectsDeleteAll(ChartID(),-1,-1);
   start_clear=true;
   
   
for (int i=1;i<=3;i++) {

  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  string yenitarih= TimeYear(TimeCurrent())+"."+i+"."+IntegerToString(22)+" 00:00";
  //if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  datetime some_time = StringToTime(yenitarih);
  
  int shift=iBarShift(Symbol(),PERIOD_D1,some_time);
  
  Print(some_time);
  //iTime(Symbol(),PERIOD_D1,i)
  ObjectCreate(ChartID(),"Month"+i,OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"Month"+i,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"Month"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Month"+i,OBJPROP_STYLE,STYLE_DOT);
  
  if ( i >= 1 ) {
  
  string yenitarih= TimeYear(TimeCurrent())+"."+IntegerToString(i-1)+"."+IntegerToString(23)+" 00:00";
  if ( i == 1 ) yenitarih= IntegerToString(TimeYear(TimeCurrent())-1)+"."+IntegerToString(12)+"."+IntegerToString(23)+" 00:00";
  //if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  datetime some_times = StringToTime(yenitarih);
  
  ObjectCreate(ChartID(),"Monthe"+i,OBJ_VLINE,0,some_times,Ask);
  ObjectSetInteger(ChartID(),"Monthe"+i,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),"Monthe"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthe"+i,OBJPROP_STYLE,STYLE_DOT);



int shiftss=iBarShift(Symbol(),PERIOD_D1,some_times);

  
  double high_prices=-1;
  double low_prices=1000000000;
  bool find=false;
  int total=0;
  int high_shift=0;
  int low_shift=0;
  
  for (int r=shiftss;r>shiftss-23;r--) {
  
  if ( TimeDay(iTime(Symbol(),PERIOD_D1,r)) == 23 ) total=total+1;
  
  if ( total > 1 ) continue;
  
  //int(TimeMonth(iTime(Symbol(),PERIOD_D1,r)))== i
  //int(TimeMonth(iTime(Symbol(),PERIOD_D1,r)))+1 == i
  
  if ( high_prices < iHigh(Symbol(),PERIOD_D1,r) ) {high_prices=iHigh(Symbol(),PERIOD_D1,r);high_shift=r;}
  if ( low_prices > iLow(Symbol(),PERIOD_D1,r) ) {low_prices=iLow(Symbol(),PERIOD_D1,r);low_shift=r;}


  }
  

  //ObjectCreate(ChartID(),"Monthntrx"+i,OBJ_TREND,0,some_time,high_prices,some_times,low_prices);
  ObjectCreate(ChartID(),"Monthntrx"+i,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,high_shift),high_prices,iTime(Symbol(),PERIOD_D1,low_shift),low_prices);
  ObjectSetInteger(ChartID(),"Monthntrx"+i,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),"Monthntrx"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthntrx"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthntrx"+i,OBJPROP_RAY,false);
  
    
  
      
  
  
  int shifts=iBarShift(Symbol(),PERIOD_D1,some_times);
  
int shift_range=(shifts-shift);  
  
//int val_index=iHighest(NULL,PERIOD_D1,MODE_HIGH,23,shift);
///int val_index=iHighest(sym,PERIOD_D1,MODE_HIGH,shift_range,shift);

  ObjectCreate(ChartID(),"Monthh"+i,OBJ_TREND,0,some_times,high_prices,some_time,high_prices);
  //ObjectCreate(ChartID(),"Monthh"+i,OBJ_TREND,0,some_times,high_prices,some_time,low_prices);
  ObjectSetInteger(ChartID(),"Monthh"+i,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"Monthh"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthh"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthh"+i,OBJPROP_RAY,false);
  

  ObjectCreate(ChartID(),"Monthhs"+i,OBJ_TREND,0,some_time,high_prices,some_time+PeriodSeconds(PERIOD_MN1),high_prices);
  ObjectSetInteger(ChartID(),"Monthhs"+i,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"Monthhs"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthhs"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthhs"+i,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"Monthhs"+i,OBJPROP_WIDTH,2);
    

//int val_indexs=iLowest(NULL,PERIOD_D1,MODE_LOW,23,shift);
///int val_indexs=iLowest(sym,PERIOD_D1,MODE_LOW,shift_range,shift);

  ObjectCreate(ChartID(),"Monthl"+i,OBJ_TREND,0,some_times,low_prices,some_time,low_prices);
  ObjectSetInteger(ChartID(),"Monthl"+i,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),"Monthl"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthl"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthl"+i,OBJPROP_RAY,false);

  ObjectCreate(ChartID(),"Monthls"+i,OBJ_TREND,0,some_time,low_prices,some_time+PeriodSeconds(PERIOD_MN1),low_prices);
  ObjectSetInteger(ChartID(),"Monthls"+i,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),"Monthls"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthls"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthls"+i,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"Monthls"+i,OBJPROP_WIDTH,2);
  
  ObjectCreate(ChartID(),"Monthnt"+i,OBJ_TREND,0,some_times,high_prices,some_time,low_prices);
  ObjectSetInteger(ChartID(),"Monthnt"+i,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"Monthnt"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthnt"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthnt"+i,OBJPROP_RAY,false);
/*
  ObjectCreate(ChartID(),"Monthntr"+i,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,val_index),iHigh(Symbol(),PERIOD_D1,val_index),iTime(Symbol(),PERIOD_D1,val_indexs),iLow(Symbol(),PERIOD_D1,val_indexs));
  ObjectSetInteger(ChartID(),"Monthntr"+i,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"Monthntr"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthntr"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthntr"+i,OBJPROP_RAY,false);*/
  
      
    

   //double high_price=iHigh(Symbol(),PERIOD_D1,val_index);
   //double low_price=iLow(Symbol(),PERIOD_D1,val_indexs);
   double high_price=high_prices;
   double low_price=low_prices;
   double yuzde = DivZero(high_price-low_price, 100);
   
   double level618=yuzde*61.8; // 50 
   double level382=yuzde*38.2; // 38.2
   double level500=yuzde*50; // 50 
   
   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50   
   double level886=yuzde*88.6; // 50   
   
      

 double level=level382;
 string levels="382s"+i;  
 string name="Month"+i+"-";     
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,some_time,low_price+level,some_time+PeriodSeconds(PERIOD_MN1),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);         

 level=level618;
  levels="618s"+i;       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,some_time,low_price+level,some_time+PeriodSeconds(PERIOD_MN1),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);               
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);         

 level=level500;
  levels="500s"+i;       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,some_time,low_price+level,some_time+PeriodSeconds(PERIOD_MN1),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);               
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,1);     



  datetime ty_start_time=some_time;
  datetime ty_end_time=some_time+PeriodSeconds(PERIOD_MN1);

  level=level272;
  levels="u272";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
 
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


  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
    
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
       
    
  
  }
  
  
  
  }
  

for (int i=1;i<=12;i++) {

  //string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  string yenitarih= 2022+"."+i+"."+IntegerToString(22)+" 00:00";
  //if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  datetime some_time = StringToTime(yenitarih);
  
  int shift=iBarShift(Symbol(),PERIOD_D1,some_time);
  
  Print(some_time);
  //iTime(Symbol(),PERIOD_D1,i)
  ObjectCreate(ChartID(),"Montho"+i,OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"Montho"+i,OBJPROP_COLOR,clrBlack);
  ObjectSetInteger(ChartID(),"Montho"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Montho"+i,OBJPROP_STYLE,STYLE_DOT);
  
  /*
  double high_price=-1;
  double low_price=1000000000;
  
  for (int r=shift;r<shift-23;r--) {
  
  TimeDay(iTime(Symbol(),PERIOD_D1,r))  
  
  int(TimeMonth(iTime(Symbol(),PERIOD_D1,r)))== i
  int(TimeMonth(iTime(Symbol(),PERIOD_D1,r)))+1 == i
  
  if ( high_price < iHigh(Symbol(),PERIOD_D1,r) ) high_price=iHigh(Symbol(),PERIOD_D1,r);
  if ( low_price > iLow(Symbol(),PERIOD_D1,r) ) low_price=iLow(Symbol(),PERIOD_D1,r);


  }*/
  
  

  if ( i > 1 ) {
  
  string yenitarih= IntegerToString(2022)+"."+IntegerToString(i-1)+"."+IntegerToString(23)+" 00:00";
  if ( i == 1 ) yenitarih= IntegerToString(2022-1)+"."+IntegerToString(12)+"."+IntegerToString(23)+" 00:00";
  //if ( StringFind(AccountCompany(),"Robo",0) != -1 ) yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" 02:00";
  datetime some_times = StringToTime(yenitarih);
  
  ObjectCreate(ChartID(),"Monthe"+i,OBJ_VLINE,0,some_times,Ask);
  ObjectSetInteger(ChartID(),"Monthe"+i,OBJPROP_COLOR,clrDarkGray);
  ObjectSetInteger(ChartID(),"Monthe"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthe"+i,OBJPROP_STYLE,STYLE_DOT);
  


int shiftss=iBarShift(Symbol(),PERIOD_D1,some_times);

  
  double high_prices=-1;
  double low_prices=1000000000;
  bool find=false;
  int total=0;
  int high_shift=0;
  int low_shift=0;
  
  for (int r=shiftss;r>shiftss-23;r--) {
  
  if ( TimeDay(iTime(Symbol(),PERIOD_D1,r)) == 23 ) total=total+1;
  
  if ( total > 1 ) continue;
  
  //int(TimeMonth(iTime(Symbol(),PERIOD_D1,r)))== i
  //int(TimeMonth(iTime(Symbol(),PERIOD_D1,r)))+1 == i
  
  if ( high_prices < iHigh(Symbol(),PERIOD_D1,r) ) {high_prices=iHigh(Symbol(),PERIOD_D1,r);high_shift=r;}
  if ( low_prices > iLow(Symbol(),PERIOD_D1,r) ) {low_prices=iLow(Symbol(),PERIOD_D1,r);low_shift=r;}


  }
  

  //ObjectCreate(ChartID(),"Monthntrx"+i,OBJ_TREND,0,some_time,high_prices,some_times,low_prices);
  ObjectCreate(ChartID(),"Monthntrx"+i,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,high_shift),high_prices,iTime(Symbol(),PERIOD_D1,low_shift),low_prices);
  ObjectSetInteger(ChartID(),"Monthntrx"+i,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),"Monthntrx"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthntrx"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthntrx"+i,OBJPROP_RAY,false);
  
      
    
  
  int shifts=iBarShift(Symbol(),PERIOD_D1,some_times);
  
  int shift_range=(shifts-shift);
  
  ObjectSetString(ChartID(),"Monthe"+i,OBJPROP_TOOLTIP,shift_range);
  


  
  
//int val_index=iHighest(NULL,PERIOD_D1,MODE_HIGH,23,shift);
///int val_index=iHighest(Symbol(),PERIOD_D1,MODE_HIGH,shift_range,shift);

  ObjectCreate(ChartID(),"Monthho"+i,OBJ_TREND,0,some_times,high_prices,some_time,high_prices);
  ObjectSetInteger(ChartID(),"Monthho"+i,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"Monthho"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthho"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthho"+i,OBJPROP_RAY,false);
  
  ObjectCreate(ChartID(),"Monthhos"+i,OBJ_TREND,0,some_time,high_prices,some_time+PeriodSeconds(PERIOD_MN1),high_prices);
  ObjectSetInteger(ChartID(),"Monthhos"+i,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"Monthhos"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthhos"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthhos"+i,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"Monthhos"+i,OBJPROP_WIDTH,2);
    

//int val_indexs=iLowest(NULL,PERIOD_D1,MODE_LOW,23,shift);
///int val_indexs=iLowest(Symbol(),PERIOD_D1,MODE_LOW,shift_range,shift);

  ObjectCreate(ChartID(),"Monthlo"+i,OBJ_TREND,0,some_times,low_prices,some_time,low_prices);
  ObjectSetInteger(ChartID(),"Monthlo"+i,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),"Monthlo"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthlo"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthlo"+i,OBJPROP_RAY,false);

  ObjectCreate(ChartID(),"Monthlos"+i,OBJ_TREND,0,some_time,low_prices,some_time+PeriodSeconds(PERIOD_MN1),low_prices);
  ObjectSetInteger(ChartID(),"Monthlos"+i,OBJPROP_COLOR,clrRed);
  ObjectSetInteger(ChartID(),"Monthlos"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthlos"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthlos"+i,OBJPROP_RAY,false);
  ObjectSetInteger(ChartID(),"Monthlos"+i,OBJPROP_WIDTH,2);
  

  ObjectCreate(ChartID(),"Montht"+i,OBJ_TREND,0,some_times,high_prices,some_time,low_prices);
  ObjectSetInteger(ChartID(),"Montht"+i,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"Montht"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Montht"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Montht"+i,OBJPROP_RAY,false);
  /*
  ObjectCreate(ChartID(),"Monthnttr"+i,OBJ_TREND,0,iTime(Symbol(),PERIOD_D1,val_index),iHigh(Symbol(),PERIOD_D1,val_index),iTime(Symbol(),PERIOD_D1,val_indexs),iLow(Symbol(),PERIOD_D1,val_indexs));
  ObjectSetInteger(ChartID(),"Monthnttr"+i,OBJPROP_COLOR,clrBlue);
  ObjectSetInteger(ChartID(),"Monthnttr"+i,OBJPROP_BACK,true);
  ObjectSetInteger(ChartID(),"Monthnttr"+i,OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"Monthnttr"+i,OBJPROP_RAY,false);*/
    

   //double high_price=iHigh(Symbol(),PERIOD_D1,val_index);
   //double low_price=iLow(Symbol(),PERIOD_D1,val_indexs);
   double high_price=high_prices;
   double low_price=low_prices;
   
   double yuzde = DivZero(high_price-low_price, 100);
   
   double level618=yuzde*61.8; // 50 
   double level382=yuzde*38.2; // 38.2
   double level500=yuzde*50; // 38.2
   
   double level168=yuzde*16.18; // 50
   double level130=yuzde*13; // 50
   double level272=yuzde*27.2; // 50
   double level414=yuzde*41.4; // 50   
   double level886=yuzde*88.6; // 50   
      
   
 double level=level382;
 string levels="382s"+i;  
 string name="Montho"+i+"-";     
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,some_time,low_price+level,some_time+PeriodSeconds(PERIOD_MN1),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);         
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);         

 level=level618;
  levels="618s"+i;       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,some_time,low_price+level,some_time+PeriodSeconds(PERIOD_MN1),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);  
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,2);         


 level=level500;
  levels="500s"+i;       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,some_time,low_price+level,some_time+PeriodSeconds(PERIOD_MN1),low_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrWhite);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_STYLE,STYLE_DOT);               
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_WIDTH,1);     
  



  datetime ty_start_time=some_time;
  datetime ty_end_time=some_time+PeriodSeconds(PERIOD_MN1);

  level=level272;
  levels="u272";  
        
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,high_price+level,ty_end_time,high_price+level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
 
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


  level=level272;
  levels="d272";       
  ObjectDelete(ChartID(),name+"Level"+levels);
  ObjectCreate(ChartID(),name+"Level"+levels,OBJ_TREND,0,ty_start_time,low_price-level,ty_end_time,low_price-level);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_RAY,False);
  ObjectSetInteger(ChartID(),name+"Level"+levels,OBJPROP_COLOR,clrYellow);
  
    
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


  
  }
  
  
    
  
  }
  
  
  
    ChartRedraw(ChartID());
     
   
   
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
