//+------------------------------------------------------------------+
//|                                                       Bilinc.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict


double Lot;

int magic=0;

string sym=Symbol();


int buy_total=0;
int sell_total=0;
double buy_profit=0;
double sell_profit=0;
double buy_lot=0;
double sell_lot=0;
double buy_pen_lot=0;
double sell_pen_lot=0;


bool eq_order=false;
int eq_live_order=0;
int eq_pen_order=0;
bool eq_system=false; // Eq Sistem
int eq_lot_carpan=1;

bool lock_order_buy_total=0;
bool lock_order_sell_total=0;

string last_select_object="";

double price=0;


double sell_total_profit_loss=0;
double buy_total_profit_loss=0;

double sell_total_profit=0;
double buy_total_profit=0;

double sell_pen_total_profit_loss=0;
double buy_pen_total_profit_loss=0;

double sell_pen_total_profit=0;
double buy_pen_total_profit=0;


int active_magic_buy=0;
int active_magic_sell=0;


double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;

int OrderTotal=OrdersTotal();

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
  /* int fiboset_Fark=(price-Ask)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,1);
   
   Comment(Pips_Price_valued);*/
   
   
   
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

if ( OrderTotal != OrdersTotal() ) {
if ( price != 0 ) {
Bilinc();
}
OrderTotal=OrdersTotal();
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



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND || ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_HLINE ) {

last_select_object=sparam;

          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
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


if ( obj_prc1 == obj_prc2 || obj_typ == OBJ_HLINE ) {




price=obj_prc1;


Bilinc();
return;


OrderCommetssTypeMulti(sym);


double mrg=(MarketInfo(sym,MODE_MARGINREQUIRED)/1);




double buy_pen_mrg=buy_pen_lot*mrg;
double sell_pen_mrg=sell_pen_lot*mrg;

double buy_mrg=buy_lot*mrg;
double sell_mrg=sell_lot*mrg;

//double MarginLevel=StringConcatenate("MarginLevel=",DoubleToStr(AccountEquity()/AccountMargin()*100,2),"% ");
//double Buy_MarginLevel=StringConcatenate("MarginLevel=",DoubleToStr((AccountBalance()-buy_total_profit_loss)/buy_mrg*100,2),"% ");

if ( buy_lot > 0 ) {
double Buy_MarginLevel=((AccountBalance()-buy_total_profit_loss)/(buy_mrg*1))*100;
}
if ( buy_pen_lot > 0 ) {
double Buy_PenMarginLevel=((AccountBalance()-(buy_pen_total_profit_loss))/(buy_pen_mrg*1))*100;
}
double Buy_TotalMarginLevel;
if ( buy_lot > 0 || buy_pen_lot > 0 ) {
Buy_TotalMarginLevel=((AccountBalance()-(buy_pen_total_profit_loss+buy_total_profit_loss))/(buy_pen_mrg+buy_mrg*1))*100;
}


if ( sell_lot > 0 ) {
double Sell_MarginLevel=((AccountBalance()-sell_total_profit_loss)/(sell_mrg*1))*100;
}
if ( sell_pen_lot > 0 ) {
double Sell_PenMarginLevel=((AccountBalance()-(sell_pen_total_profit_loss))/(sell_pen_mrg*1))*100;
}

double Sell_TotalMarginLevel;
if ( sell_lot > 0 || sell_pen_lot > 0 ) {
Sell_TotalMarginLevel=((AccountBalance()-(sell_pen_total_profit_loss+sell_total_profit_loss))/(sell_pen_mrg+sell_mrg*1))*100;
}

Comment("Object_Name:",last_select_object,"\n Price:",obj_prc1
,"\n sell_profit_total_lose:",sell_total_profit_loss,"\n buy_profit_total_lose:",buy_total_profit_loss
,"\n sell_profit_total:",sell_total_profit,"\n buy_profit_total:",buy_total_profit

,"\n sell_pen_profit_total_lose:",sell_pen_total_profit_loss,"\n buy_pen_profit_total_lose:",buy_pen_total_profit_loss
,"\n sell_pen_profit_total:",sell_pen_total_profit,"\n buy_pen_profit_total:",buy_pen_total_profit


,"\n\n Total_sell_lose:",sell_pen_total_profit_loss+sell_total_profit_loss,"\n Total_buy_lose:",buy_pen_total_profit_loss+buy_total_profit_loss
,"\n Total_sell_profit:",sell_pen_total_profit+sell_total_profit,"\n Total_buy_profit:",buy_pen_total_profit+buy_total_profit
/*
,"\n mrg:",mrg
,"\n buy_mrg:",buy_mrg
,"\n buy_lot:",buy_lot
,"\n buy_margin_level:",Buy_MarginLevel*/
/*
,"\n buy_mrg:",buy_pen_mrg
,"\n buy_lot:",buy_pen_lot
,"\n buy_margin_level:",Buy_PenMarginLevel*/

,"\n buy_mrg:",buy_pen_mrg+buy_mrg
,"\n buy_lot:",buy_pen_lot+buy_lot
,"\n buy_margin_level:",Buy_TotalMarginLevel

,"\n sell_mrg:",sell_pen_mrg+sell_mrg
,"\n sell_lot:",sell_pen_lot+sell_lot
,"\n sell_margin_level:",Sell_TotalMarginLevel





);

AvarageSystem(0);

}


}






   
  }
  
//+------------------------------------------------------------------+
bool OrderCommetssTypeMulti(string sym){

bool sonuc=false;

buy_total=0;
sell_total=0;
buy_profit=0;
sell_profit=0;
buy_lot=0;
sell_lot=0;

eq_live_order=0;
eq_pen_order=0;


lock_order_buy_total=0;
lock_order_sell_total=0;

sell_total_profit_loss=0;
buy_total_profit_loss=0;

sell_total_profit=0;
buy_total_profit=0;

sell_pen_total_profit_loss=0;
buy_pen_total_profit_loss=0;

sell_pen_total_profit=0;
buy_pen_total_profit=0;

buy_pen_lot=0;
sell_pen_lot=0;



//int cnt = 0;
for(int cnts=OrdersTotal()-1;cnts>=0;cnts--){


if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) ) {
eq_pen_order=eq_pen_order+1;
//buy_profit=buy_profit+OrderProfit();
}



if(!OrderSelect(cnts, SELECT_BY_POS, MODE_TRADES))continue;

Print(OrderTicket());


//Sonuna Rakam Ekledik Hangi Tutar Kazaniyor diye onun icin instr veya indexof yapip comment icinde arama yapiyoruz.
//int index=StringFind(OrderComment(), cmt, 0);

if ( OrderSymbol() == sym && OrderMagicNumber() == magic+1 ) {
eq_live_order=eq_live_order+1;
//buy_profit=buy_profit+OrderProfit();
}
/*
////////////////////////////////////////////////////
if ( OrderSymbol() == sym && OrderType() == OP_BUY && OrderMagicNumber() == magic && OrderComment() == "HEDGE" ) {
//hedge_buy_profit=OrderProfit();
lock_order_buy_total=lock_order_buy_total+1;
}

if ( OrderSymbol() == sym && OrderType() == OP_SELL && OrderMagicNumber() == magic && OrderComment() == "HEDGE" ) {
//hedge_sell_profit=OrderProfit();
lock_order_sell_total=lock_order_sell_total+1;
}
////////////////////////////
*/



//Alert(OrderType(),"/",OrderComment(),"/",cmt,"/",index);
//if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
if ( OrderSymbol() == sym && OrderType() == OP_BUY //&& OrderMagicNumber() == magic 
) {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
buy_lot=buy_lot+OrderLots();


if ( price < OrderOpenPrice() ) {
   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_total_profit_loss=buy_total_profit_loss+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}   
  
   
if ( price > OrderOpenPrice() ) {
   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_total_profit=buy_total_profit+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}  



}




if ( OrderSymbol() == sym && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_BUYSTOP )  //&& OrderMagicNumber() == magic 
) {/*
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
*/
buy_pen_lot=buy_pen_lot+OrderLots();


if ( price < OrderOpenPrice() ) {
   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_pen_total_profit_loss=buy_pen_total_profit_loss+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}   
  
   
if ( price > OrderOpenPrice() ) {
   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   buy_pen_total_profit=buy_pen_total_profit+Pips_Price_valued;
   //Comment(Pips_Price_valued);
}  



}




if ( OrderSymbol() == sym && OrderType() == OP_SELL //&& OrderMagicNumber() == magic 
 ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
sell_lot=sell_lot+OrderLots();



if ( price > OrderOpenPrice() ) {

   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_total_profit_loss=sell_total_profit_loss+Pips_Price_valued;
}   
  

if ( price < OrderOpenPrice() ) {

   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_total_profit=sell_total_profit+Pips_Price_valued;
}   
  

   //Comment(Pips_Price_valued);


}



if ( OrderSymbol() == sym && (OrderType() == OP_SELLLIMIT || OrderType() == OP_SELLSTOP )//&& OrderMagicNumber() == magic 
 ) {
 

//sell_total=sell_total+1;
//sell_profit=sell_profit+OrderProfit();
sell_pen_lot=sell_pen_lot+OrderLots();



if ( price > OrderOpenPrice() ) {

   int fiboset_Fark=(price-OrderOpenPrice())/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_pen_total_profit_loss=sell_pen_total_profit_loss+Pips_Price_valued;
}   
  

if ( price < OrderOpenPrice() ) {

   int fiboset_Fark=(OrderOpenPrice()-price)/Point;
   double Pips_Price_valued = PipPrice(sym,0,fiboset_Fark,OrderLots());
   sell_pen_total_profit=sell_pen_total_profit+Pips_Price_valued;
}   
  

   //Comment(Pips_Price_valued);


}








}

sonuc=true;

/*
if ( lock_order_buy_total == 0 ) lock_order_buy = false;
if ( lock_order_sell_total == 0 ) lock_order_sell = false;
*/
return sonuc;
};

/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 


////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandirir ?
////////////////////////////////////////////////////////////////////////////

double PipPrice(string sym,double fiyat,int pips,double lots) {



string OrderSymbols = sym;
double sonuc = 0;

if ( MarketInfo(OrderSymbols,MODE_SPREAD) == 0 ) return sonuc;

          int BS_spread = MarketInfo(OrderSymbols,MODE_SPREAD);
              BS_spread = 1;
    double BS_tickvalue = MarketInfo(OrderSymbols,MODE_TICKVALUE);
     double BS_ticksize = MarketInfo(OrderSymbols,MODE_TICKSIZE);
 double BS_spread_price = MarketInfo(OrderSymbols,MODE_MARGINREQUIRED)*BS_spread;
        BS_spread_price = (1/MarketInfo(OrderSymbols,MODE_POINT))*(BS_spread*(MarketInfo(OrderSymbols,MODE_TICKVALUE)*MarketInfo(OrderSymbols,MODE_TICKSIZE)));
        
   double BS_spread_one = (BS_spread_price / BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    //Alert(Order_Profit);
    
    
    if ( BS_spread_one == 0 ) {//Alert("BS_spread_one Hatasi:",OrderSymbols);
    return sonuc;}
         
         //Print("OrderSymbols",OrderSymbols,"Fiyat",fiyat,"BS_spread_one",BS_spread_one,"BS_spread_price",BS_spread_price);
         
         int Order_Pips = fiyat/BS_spread_one;   


if ( fiyat != 0 ) {
//Alert(fiyat," $ kac piptir ?",BS_spread_one,"/",IntegerToString(Order_Pips,0)," pip");
sonuc =  Order_Pips;
}

////////////////////////

if ( pips != 0 ) {
//Alert(pips," pip kac $ kazandirir ?",DoubleToString(Order_Profit,2),"$");
sonuc =  DoubleToString(Order_Profit,2);
}




return sonuc;


}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Sinyal Sistemi
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


void AvarageSystem(int mgc) {

if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 ) {


///////////////////////////////////////////////////////////////////////////////////////////////
// Lot Gösterici
///////////////////////////////////////////////////////////////////////////////////////////////
if ( OrdersTotal() > 0 ) {

double margin_buylot=0;
double margin_selllot=0;
double margin_buyprofit=0;
double margin_sellprofit=0;
double avarage = 0;
double avarage_total = 0;
double islem_sayisi = 0;
double islem_sayisi_buy = 0;
double islem_sayisi_sell = 0;


double avarage_total_buy = 0;
double avarage_total_sell = 0;

double avarage_buy = 0;
double avarage_sell = 0;


       for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {
           if (OrderSymbol()==Symbol() //&& OrderMagicNumber() == mgc
            ) {
           
           //Alert("OrderTicket:",OrderTicket());
           
           //Print(OrderTicket(),"/",OrderMagicNumber());
           
           
           
           
        //if ( OrderType() == OP_BUY || OrderType() == OP_BUYSTOP ) {
        if ( OrderType() == OP_BUY  ) {
        
           margin_buylot = margin_buylot + OrderLots();
           
           islem_sayisi=islem_sayisi+(OrderLots()*100);
           avarage_total=avarage_total+(OrderOpenPrice()*(OrderLots()*100));           
           
           islem_sayisi_buy=islem_sayisi_buy+(OrderLots()*100);
           avarage_total_buy=avarage_total_buy+(OrderOpenPrice()*(OrderLots()*100));           
        }
        
        //if ( OrderType() == OP_SELL || OrderType() == OP_SELLSTOP ) {
        if ( OrderType() == OP_SELL  ) {
        
           margin_selllot = margin_selllot + OrderLots();
           
           islem_sayisi=islem_sayisi+(OrderLots()*100);
           avarage_total=avarage_total+(OrderOpenPrice()*(OrderLots()*100));
           
           islem_sayisi_sell=islem_sayisi_sell+(OrderLots()*100);
           avarage_total_sell=avarage_total_sell+(OrderOpenPrice()*(OrderLots()*100));           
        }
        
        
       if ( OrderType() == OP_BUY && OrderProfit() < 0 ) {
        
        margin_buyprofit = margin_buyprofit +  OrderProfit(); 
        
        } 
        
       if ( OrderType() == OP_SELL && OrderProfit() < 0 ) {
        
        margin_sellprofit = margin_sellprofit +  OrderProfit(); 
        
        } 
        
        



}
}
}

if ( avarage_total == 0 ) return;


//////////////////////////////////////////////////////////////////////////////////////////////
// AVARAGE SİSTEMİ
//////////////////////////////////////////////////////////////////////////////////////////////        
        avarage=DivZero(avarage_total,islem_sayisi);
        
        avarage_buy=DivZero(avarage_total_buy,islem_sayisi_buy);
        avarage_sell=DivZero(avarage_total_sell,islem_sayisi_sell);
        
        //Comment("avarage_buy:",avarage_buy,"\n avarage_sell:",avarage_sell);
        
        double avarage_fark=avarage_buy-avarage_sell;
        

double avarage_buy_profit_price=avarage_buy+avarage_fark;
double avarage_sell_profit_price=avarage_sell-avarage_fark;

        
if ( last_avarage_buy_profit_price != avarage_buy_profit_price ) {        
if ( ObjectFind(ChartID(),"AvarageBuyp") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuyp",OBJ_HLINE,0,0,avarage_buy_profit_price);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_COLOR,clrLimeGreen);        
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuyp",OBJPROP_STYLE,STYLE_DOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuyp",OBJPROP_PRICE,avarage_buy_profit_price);
last_avarage_buy_profit_price=avarage_buy_profit_price;
}  
}

if ( last_avarage_sell_profit_price != avarage_sell_profit_price ) {        
if ( ObjectFind(ChartID(),"AvarageSellp") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSellp",OBJ_HLINE,0,0,avarage_sell_profit_price);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_COLOR,clrLimeGreen);        
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSellp",OBJPROP_STYLE,STYLE_DOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSellp",OBJPROP_PRICE,avarage_sell_profit_price);
last_avarage_sell_profit_price=avarage_sell_profit_price;
}  
}



        
        
        
        ///Print("avarage",avarage,"/",islem_sayisi,"/",avarage_total);

if ( mgc == active_magic_buy ) {

if ( last_avarage_buy != avarage_buy ) {        
if ( ObjectFind(ChartID(),"AvarageBuy") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuy",OBJ_HLINE,0,0,avarage_buy);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_COLOR,clrSandyBrown);        
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuy",OBJPROP_PRICE,avarage_buy);
last_avarage_buy=avarage_buy;
}   

if ( ObjectFind(ChartID(),"AvarageBuy") != -1 && islem_sayisi_buy == 0 ) ObjectDelete(ChartID(),"AvarageBuy");

}


if ( last_avarage_sell != avarage_sell ) {        
if ( ObjectFind(ChartID(),"AvarageSell") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSell",OBJ_HLINE,0,0,avarage_sell);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_COLOR,clrCrimson);        
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSell",OBJPROP_PRICE,avarage_sell);
last_avarage_sell=avarage_sell;
}   

if ( ObjectFind(ChartID(),"AvarageSell") != -1 && islem_sayisi_sell == 0 ) ObjectDelete(ChartID(),"AvarageSell");

}








}

///////////////////////////////////////////////////////////////////////////////////////////////////////     
if ( mgc == active_magic_sell ) {

if ( last_avarage_sell != avarage ) {        
if ( ObjectFind(ChartID(),"AvarageSell") == -1 ) {        
ObjectCreate(ChartID(),"AvarageSell",OBJ_HLINE,0,0,avarage_sell);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_COLOR,clrCrimson);        
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageSell",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageSell",OBJPROP_PRICE,avarage_sell);
last_avarage_sell=avarage_sell;
}   

if ( ObjectFind(ChartID(),"AvarageSell") != -1 && islem_sayisi_sell == 0 ) ObjectDelete(ChartID(),"AvarageSell");

}


if ( last_avarage_buy != avarage_buy ) {        
if ( ObjectFind(ChartID(),"AvarageBuy") == -1 ) {        
ObjectCreate(ChartID(),"AvarageBuy",OBJ_HLINE,0,0,avarage_buy);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_COLOR,clrSandyBrown);        
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_WIDTH,1);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_SELECTABLE,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_BACK,true);
ObjectSetInteger(ChartID(),"AvarageBuy",OBJPROP_STYLE,STYLE_DASHDOT);
} else {
ObjectSetDouble(ChartID(),"AvarageBuy",OBJPROP_PRICE,avarage_buy);
last_avarage_buy=avarage_buy;
}   

if ( ObjectFind(ChartID(),"AvarageBuy") != -1 && islem_sayisi_buy == 0 ) ObjectDelete(ChartID(),"AvarageBuy");

}







}

///////////////////////////////////////////////////////////////////////////////////////////////////////     
  
  
    
  
  
  
  
  
  
}
}


}


void Bilinc() {


//price=obj_prc1;
OrderCommetssTypeMulti(sym);


double mrg=(MarketInfo(sym,MODE_MARGINREQUIRED)/1);




double buy_pen_mrg=buy_pen_lot*mrg;
double sell_pen_mrg=sell_pen_lot*mrg;

double buy_mrg=buy_lot*mrg;
double sell_mrg=sell_lot*mrg;

//double MarginLevel=StringConcatenate("MarginLevel=",DoubleToStr(AccountEquity()/AccountMargin()*100,2),"% ");
//double Buy_MarginLevel=StringConcatenate("MarginLevel=",DoubleToStr((AccountBalance()-buy_total_profit_loss)/buy_mrg*100,2),"% ");

if ( buy_lot > 0 ) {
double Buy_MarginLevel=((AccountBalance()-buy_total_profit_loss)/(buy_mrg*1))*100;
}
if ( buy_pen_lot > 0 ) {
double Buy_PenMarginLevel=((AccountBalance()-(buy_pen_total_profit_loss))/(buy_pen_mrg*1))*100;
}
double Buy_TotalMarginLevel;
if ( buy_lot > 0 || buy_pen_lot > 0 ) {
Buy_TotalMarginLevel=((AccountBalance()-(buy_pen_total_profit_loss+buy_total_profit_loss))/(buy_pen_mrg+buy_mrg*1))*100;
}


if ( sell_lot > 0 ) {
double Sell_MarginLevel=((AccountBalance()-sell_total_profit_loss)/(sell_mrg*1))*100;
}
if ( sell_pen_lot > 0 ) {
double Sell_PenMarginLevel=((AccountBalance()-(sell_pen_total_profit_loss))/(sell_pen_mrg*1))*100;
}

double Sell_TotalMarginLevel;
if ( sell_lot > 0 || sell_pen_lot > 0 ) {
Sell_TotalMarginLevel=((AccountBalance()-(sell_pen_total_profit_loss+sell_total_profit_loss))/(sell_pen_mrg+sell_mrg*1))*100;
}

Comment("Object_Name:",last_select_object,"\n Price:",price
,"\n sell_profit_total_lose:",sell_total_profit_loss,"\n buy_profit_total_lose:",buy_total_profit_loss
,"\n sell_profit_total:",sell_total_profit,"\n buy_profit_total:",buy_total_profit

,"\n\n sell_pen_profit_total_lose:",sell_pen_total_profit_loss,"\n buy_pen_profit_total_lose:",buy_pen_total_profit_loss
,"\n sell_pen_profit_total:",sell_pen_total_profit,"\n buy_pen_profit_total:",buy_pen_total_profit


,"\n\n Total_sell_lose:",sell_pen_total_profit_loss+sell_total_profit_loss,"\n Total_buy_lose:",buy_pen_total_profit_loss+buy_total_profit_loss
,"\n Total_sell_profit:",sell_pen_total_profit+sell_total_profit,"\n Total_buy_profit:",buy_pen_total_profit+buy_total_profit
/*
,"\n mrg:",mrg
,"\n buy_mrg:",buy_mrg
,"\n buy_lot:",buy_lot
,"\n buy_margin_level:",Buy_MarginLevel*/
/*
,"\n buy_mrg:",buy_pen_mrg
,"\n buy_lot:",buy_pen_lot
,"\n buy_margin_level:",Buy_PenMarginLevel*/

,"\n buy_mrg:",buy_pen_mrg+buy_mrg
,"\n buy_lot:",buy_pen_lot+buy_lot
,"\n buy_margin_level:",Buy_TotalMarginLevel

,"\n sell_mrg:",sell_pen_mrg+sell_mrg
,"\n sell_lot:",sell_pen_lot+sell_lot
,"\n sell_margin_level:",Sell_TotalMarginLevel





);

AvarageSystem(0);

}


