//+------------------------------------------------------------------+
//|                                                       Walter.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

double last_sell_up_price=-1;
double last_sell_down_price=-1;
double offset_point=50;
int magic=0;
double Lot=0.01;
double order_profit=0;
double order_list[11,4];
datetime last_sell_up_time=-1;
bool spread_filter=false;
int max_spead=50;

int active_magic_buy=0;
int active_magic_sell=-1;


double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//--- create timer
   //EventSetTimer(60);
   
  last_sell_up_time=Time[1];
  active_magic_buy=magic;
  active_magic_sell=magic;   
   
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

Comment(OrdersTotal()+"\n Order Profit:"+order_profit+"\n AccountProfit:"+AccountProfit(),"\n Total:"+(AccountProfit()+order_profit));


if ( Close[4] > Open[4] && Close[3] > Open[3] && Close[2] > Open[2] && Open[1] > Close[1] && Close[2] > Close[3] && Close[3] > Close[4] //&& Close[4] > Close[5] 
) {

double range=(Close[2]-Open[4]);

ObjectDelete(ChartID(),"SELL"+Time[2]);
ObjectCreate(ChartID(),"SELL"+Time[2],OBJ_TREND,0,Time[2],High[2],Time[4],Low[4]);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_RAY,False);
ObjectSetString(ChartID(),"SELL"+Time[2],OBJPROP_TOOLTIP,range/Point+" "+offset_point);



}







//AvarageSystem(magic);

////////////////////////////////////////////////////////////////////////
// Spread Filter 
////////////////////////////////////////////////////////////////////////
   double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   double spread=(ask-bid)/Point;
   //Print("spread",spread,"/",max_spead);
   bool spread_onay=true;
   if ( spread_filter == true ) {
   if ( spread > max_spead && max_spead > 0 ) {
   spread_onay=false;
   //return;
   }
   }
//////////////////////////////////////////////////////////////////////////
  
  
  if ( spread_onay == false ) return;
  
  

double range=(Close[2]-Open[4]);

if ( DivZero(range,Point) >= offset_point &&
spread_onay == true && 
last_sell_up_price == -1 
&& Close[4] > Open[4] && Close[3] > Open[3] && Close[2] > Open[2] && Open[1] > Close[1] && Close[2] > Close[3] && Close[3] > Close[4] 
&& Time[4] > last_sell_up_time
) {
int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
last_sell_up_price=Bid;
last_sell_down_price=Bid;
last_sell_up_time=Time[1];

Print("Range:",range/Point);

}

  

if ( last_sell_up_price != -1 && OrdersTotal() < 11 ) {

double carpan=1;
if ( OrdersTotal() > 6 ) carpan=3;

//double range=(Close[2]-Open[5]);
double range=(Close[2]-Open[4]);

if ( DivZero(range,Point) >= offset_point && 
spread_onay == true && (Bid-last_sell_up_price)/Point > offset_point && Time[4] > last_sell_up_time //&& Close[5] > Open[5]  

&& Close[4] > Open[4] && Close[3] > Open[3] && Close[2] > Open[2] && Open[1] > Close[1] && Close[2] > Close[3] && Close[3] > Close[4] //&& Close[4] > Close[5]

 ) {
//if ( DistanceOrders(Bid,OP_SELL) == true ) 
int ticket=OrderSend(Symbol(),OP_SELL,Lot*carpan,Bid,0,0,0,"",magic,0,clrNONE);
last_sell_up_price=Bid;
last_sell_up_time=Time[1];

Print("Range:",range/Point);

}

}
/*
if ( last_sell_down_price != -1 && OrdersTotal() < 6  ) {
if ( (last_sell_down_price-Bid)/Point > offset_point  ) {
//if ( DistanceOrders(Bid,OP_SELL) == true ) 
int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
last_sell_down_price=Bid;

}
}
*/




if ( OrdersTotal() == 11 && spread_onay == true ) {
//order_profit=0;


   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
         
         order_list[m,0]=OrderTicket();
         order_list[m,1]=OrderOpenPrice();
         order_list[m,2]=OrderLots();
         order_list[m,3]=OrderProfit()+OrderCommission()+OrderSwap();
         
         }
         
         }
         
         }

ArraySort(order_list,WHOLE_ARRAY,0,MODE_ASCEND);

   for(int i=0; i<11; i++)
     {
     
     Print(i,"/",order_list[i,0],"/",order_list[i,1]);
          
     
     }

OrderClose(order_list[5,0],order_list[5,2],Ask,0,clrNONE);
order_profit=order_profit+order_list[5,3];

}



if ( spread_onay == true && AccountProfit()+order_profit > 2 ) {
CloseAllSellOrders();
last_sell_up_price=-1;
order_profit=0;

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
   
  }
//+------------------------------------------------------------------+

bool DistanceOrders(double ord_prc,int ord_typ)
{

bool sonuc=true;

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if(OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {

         if ( ord_typ == OP_SELL && OrderType() == OP_SELL ) {
         if ( MarketInfo(Symbol(),MODE_BID) > OrderOpenPrice() && (MarketInfo(Symbol(),MODE_BID)-OrderOpenPrice())/Point < offset_point ) sonuc=false;
         if ( MarketInfo(Symbol(),MODE_BID) < OrderOpenPrice() && (OrderOpenPrice()-MarketInfo(Symbol(),MODE_BID))/Point < offset_point ) sonuc=false;     
         
         if ( MarketInfo(Symbol(),MODE_BID) > OrderOpenPrice() ) Print(OrderTicket(),"/",OrdersTotal(),"/",OrderOpenPrice(),"/",Bid,"/",sonuc,"/",(Bid-OrderOpenPrice())/Point);
         if ( MarketInfo(Symbol(),MODE_BID) < OrderOpenPrice() ) Print(OrderTicket(),"/",OrdersTotal(),"/",OrderOpenPrice(),"/",Bid,"/",sonuc,"/",(OrderOpenPrice()-Bid)/Point);
             
         }
                  


         }
      }
    }
    
    
    
    
  return sonuc;
    
}
void CloseAllSellOrders()
{
   for (int h=OrdersTotal();h>=0;h--)
   {
      if ( OrderSelect(h,SELECT_BY_POS) )
      {
         if(OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic )
         {
            RefreshRates();
            bool success =OrderClose(OrderTicket(), OrderLots(), Ask, 0, Red);
         }
      }
   }
   

}

void AvarageSystem(int mgc) {

if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == 1 || IsTesting() == True ) {


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
           if (OrderSymbol()==Symbol() && OrderMagicNumber() == mgc ) {
           
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
        
        Comment("avarage_buy:",avarage_buy,"\n avarage_sell:",avarage_sell);
        
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
   
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
   