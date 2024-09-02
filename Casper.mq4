//+------------------------------------------------------------------+
//|                                                       Casper.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

extern double Lot=0.01;
extern int magic=0;


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
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---

Print("Sparam",sparam);


   if ( sparam == 34 ) {
   
   int ticket_buy=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"CasperBuy",magic,0,clrNONE);
   string cmt="CasperSell"+ticket_buy;
   int ticket_sell=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,cmt,magic,0,clrNONE);
   
   
   }
   
   

if ( sparam == 46 ) {

Print("Kapat");

string cmt="CasperSell";
string ordcmt="";

   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( StringFind(OrderComment(),cmt,0) != -1  &&   OrderType() == OP_SELL && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )
         {
         ordcmt=OrderComment();
         int replace=StringReplace(ordcmt,cmt,"");
         
         
            Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    

int ordticket=StringToInteger(ordcmt);    
    
   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS))
      {
         if( OrderTicket() == ordticket &&  OrderType() == OP_BUY && OrderSymbol() == Symbol() && OrderMagicNumber() == magic
         )
         {
         //string ordcmt=OrderComment();
         //int replace=StringReplace(ordcmt,cmt,"");
         
         
         Print(OrderComment(),"=",ordcmt);
            RefreshRates();
            bool success = OrderClose(OrderTicket(), OrderLots(), OrderClosePrice(), 0, Blue);

            
         }
      }
    }
    
        
    
    
    
    
    
    
    


}   
   
   
  }
//+------------------------------------------------------------------+
