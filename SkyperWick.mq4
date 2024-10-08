//+------------------------------------------------------------------+
//|                                                   SkyperWick.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



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
//--- create timer
   //EventSetTimer(60);
   
     /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
  }
  
  
  
  ////////////////////////////   
   
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

double buy_price=-1;

void OnTick()
  {
//---

return;


if ( buy_price != -1 ) {

if ( Bid <= buy_price ) {

if ( OrdersTotal() == 0  ) {

OrderSend(Symbol(),OP_BUY,0.01,Ask,0,buy_price-100*Point,Ask+200*Point,"",0,0,clrNONE);

}

}

}


int shift1=1;

last_select_object=Time[shift1];

mnt=Time[1]+10*PeriodSeconds();

          if ( Open[shift1] >= Close[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Open[shift1],2);
          double eql=DivZero(Close[shift1]-Low[shift1],2);

double levels=0;
string level=DoubleToString(levels,2);

if ( (Close[shift1]-Low[shift1])/Point >= 200 ) {          
          
double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);


buy_price=Low[shift1]+eql;


}

if ( (High[shift1]-Open[shift1])/Point >= 20 ) {   

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);          
          
}         
         
          
          
          }
          
          
          if ( Close[shift1] > Open[shift1] ) {
          
          
          return;
          
          double eqh=DivZero(High[shift1]-Close[shift1],2);
          double eql=DivZero(Open[shift1]-Low[shift1],2);
          
double levels=0;
string level=DoubleToString(levels,2);

if ( (Open[shift1]-Low[shift1])/Point >= 20 ) {   

ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

}

if ( (High[shift1]-Close[shift1])/Point >= 20 ) {   

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrWhite);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1); 

}
          
          
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
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---


   if(id==CHARTEVENT_CLICK)
     {
      //--- Prepare variables
      int      x     =(int)lparam;
      int      y     =(int)dparam;
      datetime dt    =0;
      double   price =0;
      int      window=0;
      //--- Convert the X and Y coordinates in terms of date/time
      if(ChartXYToTimePrice(0,x,y,window,dt,price))
        {
        
        
        

RefreshRates();
ChartRedraw();
WindowRedraw();


//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


last_select_object=sparam;



          datetime obj_time1 = dt;//ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME);
          
         int shift1=iBarShift(Symbol(),Period(),obj_time1);
         

          
          
          if ( Open[shift1] >= Close[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Open[shift1],2);
          double eql=DivZero(Close[shift1]-Low[shift1],2);
          

datetime levels=dt;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"s";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);



          
          
         
          }
          

          if ( Close[shift1] > Open[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Close[shift1],2);
          double eql=DivZero(Open[shift1]-Low[shift1],2);
          

datetime levels=dt;//0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;//1;
level=DoubleToString(levels,2)+"s";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);          
         
          }
          
                  
                  
                          
        
        /*
         PrintFormat("Window=%d X=%d  Y=%d  =>  Time=%s  Price=%G",window,x,y,TimeToString(dt),price);
         //--- Perform reverse conversion: (X,Y) => (Time,Price)
         if(ChartTimePriceToXY(0,window,dt,price,x,y))
            PrintFormat("Time=%s  Price=%G  =>  X=%d  Y=%d",TimeToString(dt),price,x,y);
         else
            Print("ChartTimePriceToXY return error code: ",GetLastError());
         //--- delete lines
         ObjectDelete(0,"V Line");
         ObjectDelete(0,"H Line");
         //--- create horizontal and vertical lines of the crosshair
         ObjectCreate(0,"H Line",OBJ_HLINE,window,dt,price);
         ObjectSetInteger(ChartID(),"H Line",OBJPROP_BACK,True);
         ObjectCreate(0,"V Line",OBJ_VLINE,window,dt,price);
         ObjectSetInteger(ChartID(),"V Line",OBJPROP_BACK,True);
         ChartRedraw(0);*/
         
         
         
         
         
         
        }
        
        }
        
        


if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_VLINE  ) {

RefreshRates();
ChartRedraw();
WindowRedraw();


//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


last_select_object=sparam;



          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME);
          
         int shift1=iBarShift(Symbol(),Period(),obj_time1);
         
          int yil=TimeYear(obj_time1);
          
          if ( yil != 1970 ) {
          
          
          if ( Open[shift1] >= Close[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Open[shift1],2);
          double eql=DivZero(Close[shift1]-Low[shift1],2);
          

double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);



          
          
         
          }
          

          if ( Close[shift1] > Open[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Close[shift1],2);
          double eql=DivZero(Open[shift1]-Low[shift1],2);
          

double levels=0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);

levels=1;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqh,mnt,High[shift1]-eqh);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrChartreuse);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,1);          
         
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