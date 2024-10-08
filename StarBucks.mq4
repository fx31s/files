//+------------------------------------------------------------------+
//|                                                    StarBucks.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double buy_low_price=-1;
double buy_high_price=-1;
datetime buy_time;

double sell_low_price=-1;
double sell_high_price=-1;
datetime sell_time;



double Lot=0.01;
int magic=0;

   extern double tp_oran=200; // TP Oran Yüzde
   double profit=25;
   
   extern double profits=25;
   extern double Lots=0.01;   
   
   extern int left_bar=105;
   extern int right_bar=7;
   extern int right_up_bar=5;
   
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
   profit=profits;
   Lot=Lots;
  
//--- create timer
   //EventSetTimer(60);
   buy_time=TimeCurrent();
   sell_time=TimeCurrent();
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


string sym=Symbol();
ENUM_TIMEFRAMES per=Period();

bool buy_order=true;
bool sell_order=true;

   int i=right_bar;
   double high_price=iHigh(sym,per,i);
   double high_pricer=iHigh(sym,per,i-1);
   double high_pricel=iHigh(sym,per,i+1);
   
   double low_price=iLow(sym,per,i);
   double low_pricer=iLow(sym,per,i-1);
    double low_pricel=iLow(sym,per,i+1);
   
    double open_price=iOpen(sym,per,i);
   double open_pricer=iOpen(sym,per,i-1);
   double open_pricel=iOpen(sym,per,i+1);
   
    double close_price=iClose(sym,per,i);
   double close_pricer=iClose(sym,per,i-1);
   double close_pricel=iClose(sym,per,i+1);
   
   
if ( buy_order == true ) {
  int low_say=0;
   bool find=false; 

for(int s=i+1;s<i+left_bar;s++) {

   if ( find == true ) continue;
   
   if ( iLow(sym,per,i) < Low[s] ) {
   low_say=low_say+1;    
   } else {
   find=true;
   }

}


   int lowr_say=0;
   bool findr=false; 

for(int s=i-1;s>i-right_bar;s--) {

if ( s < 0 ) {
//high_say=high_say+10;
continue;
}

   if ( findr == true ) continue;
   
   if ( iLow(sym,per,i) < Low[s] ) {
   lowr_say=lowr_say+1;    
   } else {
   findr=true;
   }

}




   int highhr_say=0;
   bool findhr=false; 

for(int s=i-1;s>i-right_bar;s--) {

if ( s < 0 ) {
//high_say=high_say+10;
continue;
}

   //if ( findhr == true ) continue;
   
   if ( iHigh(sym,per,i) < Open[s] && iHigh(sym,per,i) < Close[s] ) {
   highhr_say=highhr_say+1;    
   } else {
   findhr=true;
   }

}





if ( highhr_say >= right_up_bar && lowr_say >= right_bar-5 && low_say >= left_bar-5 && Time[i] > buy_time ) {
   ObjectCreate(ChartID(),"VLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   

   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],High[i],Time[i]+50*PeriodSeconds(),High[i]);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);

   ObjectCreate(ChartID(),"SLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],Low[i],Time[i]+50*PeriodSeconds(),Low[i]);
   ObjectSetInteger(ChartID(),"STLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"STLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SLINE"+(Time[i]+1),OBJPROP_RAY,False);
   
   
 //buy_high_price=High[i]+DivZero((High[i]-Low[i]),2);
 buy_high_price=High[i];
 buy_high_price=High[i]+DivZero((High[i]-Low[i]),3);
 buy_low_price=Low[i];
 buy_time=Time[i];
 
 
 
 
   ObjectCreate(ChartID(),"SLPLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],buy_low_price,Time[i]+50*PeriodSeconds(),buy_low_price);
   ObjectSetInteger(ChartID(),"SLPTLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SLPTLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SLPLINE"+(Time[i]+1),OBJPROP_RAY,False);
   

   ObjectCreate(ChartID(),"SHPLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],buy_high_price,Time[i]+50*PeriodSeconds(),buy_high_price);
   ObjectSetInteger(ChartID(),"SHPTLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SHPTLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SHPLINE"+(Time[i]+1),OBJPROP_RAY,False);
   
 
 
 
 
    int lowlr_say=0;
   bool findlr=false; 
   int leave_shift=i-1;
   

for(int s=i-1;s>i-right_bar;s--) {

if ( s < 0 ) {
//high_say=high_say+10;
continue;
}

   if ( findlr == true ) continue;
   
   if ( iHigh(sym,per,i) < Open[s] && iHigh(sym,per,i) < Close[s] && iHigh(sym,per,i) < Open[s] ) {
   leave_shift=s;
   findlr=true;
   }

}



   ObjectCreate(ChartID(),"SLVLLINE"+(Time[i]+1),OBJ_TREND,0,Time[leave_shift],Close[leave_shift],Time[leave_shift]+5*PeriodSeconds(),Close[leave_shift]);
   ObjectSetInteger(ChartID(),"SLVLLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SLVLLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SLVLLINE"+(Time[i]+1),OBJPROP_RAY,False); 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 }
 

if ( buy_high_price != -1 ) {

//if ( Low[0] < buy_high_price && Open[0] > buy_high_price ) {
if ( Low[2] < buy_high_price && Open[2] > buy_high_price && Low[1] > buy_high_price && Close[1] > buy_high_price  ) {


int shift=iBarShift(Symbol(),Period(),buy_time);

double swing_high_price=buy_high_price;
int swing_shift=shift;

for (int w=shift;w>0;w--) {
if ( swing_high_price < High[w] ) {
swing_high_price=High[w];
swing_shift=w;
}
}

   ObjectCreate(ChartID(),"SWLINE"+(Time[i]+1),OBJ_TREND,0,Time[swing_shift],Low[swing_shift],Time[swing_shift]+50*PeriodSeconds(),Low[swing_shift]);
   ObjectSetInteger(ChartID(),"SWTLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SWTLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SWLINE"+(Time[i]+1),OBJPROP_RAY,False);

   ObjectCreate(ChartID(),"SWHLINE"+(Time[i]+1),OBJ_TREND,0,Time[swing_shift],High[swing_shift],Time[swing_shift]+50*PeriodSeconds(),High[swing_shift]);
   ObjectSetInteger(ChartID(),"SWHTLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SWHTLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SWHLINE"+(Time[i]+1),OBJPROP_RAY,False);
   
   








   double pip_mesafe=(Ask-buy_low_price)/Point;
double pip_usd=PipPrice(Symbol(),0,1,1);
double pip_profit=profits;
double pip_oran=DivZero(pip_profit,pip_usd);
//double pip_mesafe=1340;
double pip_lot=DivZero(pip_oran,pip_mesafe);
pip_lot=NormalizeDouble(pip_lot,2);
   Lot=pip_lot;
   
   //Print("Lot:",Lot);
   
   double tp_yuzde=DivZero(pip_mesafe,100);
   double tp_level=tp_yuzde*tp_oran;
   pip_mesafe=int(tp_level);
   
   //Print(Lot,"/",pip_mesafe,"/",pip_profit);
   //OrderSend(Symbol(),OP_BUY,Lot,Ask,0,buy_low_price,High[swing_shift],"",magic,0,clrNONE);
   //OrderSend(Symbol(),OP_BUY,Lot,Ask,0,buy_low_price,Ask+pip_mesafe*Point,"",magic,0,clrNONE);

OrderSend(Symbol(),OP_BUY,Lot,Ask,0,buy_low_price-DivZero((buy_high_price-buy_low_price),2),Low[swing_shift],"",magic,0,clrNONE);


//int ticket=OrderSend(sym,OP_BUY,Lot,Ask,0,buy_low_price,Ask+((buy_high_price-buy_low_price)*1),"",magic,0,clrNONE);

buy_high_price=-1;
buy_low_price=-1;


}


}


}



if ( sell_order == true ) {


  int high_say=0;
  bool findz=false; 

for(int s=i+1;s<i+left_bar;s++) {

   if ( findz == true ) continue;
   
   if ( iHigh(sym,per,i) > High[s] ) {
   high_say=high_say+1;    
   } else {
   findz=true;
   }

}


   int highr_say=0;
   bool findrz=false; 

for(int s=i-1;s>i-right_bar;s--) {

if ( s < 0 ) {
//high_say=high_say+10;
continue;
}

   if ( findrz == true ) continue;
   
   if ( iHigh(sym,per,i) > High[s] ) {
   highr_say=highr_say+1;    
   } else {
   findrz=true;
   }

}



   int lowlr_say=0;
   bool findlr=false; 

for(int s=i-1;s>i-right_bar;s--) {

if ( s < 0 ) {
//high_say=high_say+10;
continue;
}

   //if ( findlr == true ) continue;
   
   if ( iLow(sym,per,i) > Open[s] && iLow(sym,per,i) > Close[s] ) {
   lowlr_say=lowlr_say+1;    
   } else {
   //findlr=true;
   }

}








if ( lowlr_say >= right_up_bar && highr_say >= right_bar-5 && high_say >= left_bar-5 && Time[i] > sell_time ) {
   ObjectCreate(ChartID(),"VLINE"+(Time[i]),OBJ_VLINE,0,Time[i],Ask);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"VLINE"+(Time[i]),OBJPROP_STYLE,STYLE_DOT);   

   ObjectCreate(ChartID(),"TLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],High[i],Time[i]+50*PeriodSeconds(),High[i]);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"TLINE"+(Time[i]+1),OBJPROP_RAY,False);

   ObjectCreate(ChartID(),"SLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],Low[i],Time[i]+50*PeriodSeconds(),Low[i]);
   ObjectSetInteger(ChartID(),"STLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"STLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SLINE"+(Time[i]+1),OBJPROP_RAY,False);

 sell_high_price=High[i];
 //sell_low_price=Low[i]-DivZero((High[i]-Low[i]),2);
 sell_low_price=Low[i]-DivZero((High[i]-Low[i]),3);
 //sell_low_price=Low[i];
 sell_time=Time[i];
 
 
   ObjectCreate(ChartID(),"SLPLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],sell_low_price,Time[i]+50*PeriodSeconds(),sell_low_price);
   ObjectSetInteger(ChartID(),"SLPTLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SLPTLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SLPLINE"+(Time[i]+1),OBJPROP_RAY,False);
   

   ObjectCreate(ChartID(),"SHPLINE"+(Time[i]+1),OBJ_TREND,0,Time[i],sell_high_price,Time[i]+50*PeriodSeconds(),sell_high_price);
   ObjectSetInteger(ChartID(),"SHPTLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SHPTLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SHPLINE"+(Time[i]+1),OBJPROP_RAY,False);
   
 
 
 
 
    int lowlr_say=0;
   bool findlr=false; 
   int leave_shift=i-1;
   

for(int s=i-1;s>i-right_bar;s--) {

if ( s < 0 ) {
//high_say=high_say+10;
continue;
}

   if ( findlr == true ) continue;
   
   if ( iLow(sym,per,i) > Open[s] && iLow(sym,per,i) > Close[s] && iLow(sym,per,i) > Open[s] ) {
   leave_shift=s;
   findlr=true;
   }

}



   ObjectCreate(ChartID(),"SLVLLINE"+(Time[i]+1),OBJ_TREND,0,Time[leave_shift],Close[leave_shift],Time[leave_shift]+5*PeriodSeconds(),Close[leave_shift]);
   ObjectSetInteger(ChartID(),"SLVLLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SLVLLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SLVLLINE"+(Time[i]+1),OBJPROP_RAY,False); 
 
 
 
 
 
 
 
 }
 

if ( sell_low_price != -1 ) {

//if ( High[0] > sell_low_price && Open[0] < sell_low_price ) {
if ( High[2] > sell_low_price && Open[2] < sell_low_price && High[1] < sell_low_price && Close[1] < sell_low_price) {



int shift=iBarShift(Symbol(),Period(),sell_time);

double swing_low_price=sell_low_price;
int swing_shift=shift;

for (int w=shift;w>0;w--) {
if ( swing_low_price > Low[w] ) {
swing_low_price=Low[w];
swing_shift=w;
}
}

   ObjectCreate(ChartID(),"SWLINE"+(Time[i]+1),OBJ_TREND,0,Time[swing_shift],Low[swing_shift],Time[swing_shift]+50*PeriodSeconds(),Low[swing_shift]);
   ObjectSetInteger(ChartID(),"SWTLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SWTLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SWLINE"+(Time[i]+1),OBJPROP_RAY,False);

   ObjectCreate(ChartID(),"SWHLINE"+(Time[i]+1),OBJ_TREND,0,Time[swing_shift],High[swing_shift],Time[swing_shift]+50*PeriodSeconds(),High[swing_shift]);
   ObjectSetInteger(ChartID(),"SWHTLINE"+(Time[i]+1),OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"SWHTLINE"+(Time[i]+1),OBJPROP_STYLE,STYLE_SOLID);
   ObjectSetInteger(ChartID(),"SWHLINE"+(Time[i]+1),OBJPROP_RAY,False);
   

   double pip=PipPrice(Symbol(),profit,0,Lot);
   //Bid-1000*Point
   
   
   double pip_mesafe=(sell_high_price-Bid)/Point;
double pip_usd=PipPrice(Symbol(),0,1,1);
double pip_profit=profits;
double pip_oran=DivZero(pip_profit,pip_usd);
//double pip_mesafe=1340;
double pip_lot=DivZero(pip_oran,pip_mesafe);
pip_lot=NormalizeDouble(pip_lot,2);
   Lot=pip_lot;   
   
   double tp_yuzde=DivZero(pip_mesafe,100);
   double tp_level=tp_yuzde*tp_oran;
   pip_mesafe=int(tp_level);
   
   
   //Print(Lot,"/",pip_mesafe,"/",pip_profit);
   
   //OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sell_high_price,Bid-pip_mesafe*Point,"",magic,0,clrNONE);
   //OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sell_high_price,High[swing_shift],"",magic,0,clrNONE);
   
   OrderSend(Symbol(),OP_SELL,Lot,Bid,0,sell_high_price+DivZero((sell_high_price-sell_low_price),2),High[swing_shift],"",magic,0,clrNONE);




//int ticket=OrderSend(sym,OP_SELL,Lot,Bid,0,sell_high_price,Bid-((sell_high_price-sell_low_price)*1),"",magic,0,clrNONE);

sell_high_price=-1;
sell_low_price=-1;


}


}



}












//if ( IsTesting() ) OnTimer();
   
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

////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandırır ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {


string OrderSymbols = sym;
double sonuc = 0;

//Print("Spread:",MarketInfo(OrderSymbols,MODE_SPREAD));


//if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;//DivZero((SymbolInfoDouble(Symbol(),SYMBOL_ASK)-SymbolInfoDouble(Symbol(),SYMBOL_BID)),Point);
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
        //if ( lots==0 ) lots=0.01;
        
   double BS_spread_one = DivZero(BS_spread_price,BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    
    /*
    if ( lots != 0 ) {
    lots=DivZero(Order_Profit,pips);    
    DoubleToString(lots,2);
    fiyat=0;
    pips=0;
    sonuc=lots;
    
    Print(lots);
    }*/
    
    //if ( BS_spread_one == 0 ) {Alert("BS_spread_one Hatası:",OrderSymbols);return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = DivZero(fiyat,BS_spread_one);   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kaç piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kaç $ kazandırır ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}

return sonuc;


}
