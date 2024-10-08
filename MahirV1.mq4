//+------------------------------------------------------------------+
//|                                                      MahirV1.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
extern double KarUSD=1;
double ilkIslemProfit=0;
double ToplamProfit=0;
double ask;
double bid;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---

//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---

  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   ask=SymbolInfoDouble(NULL,SYMBOL_ASK);
   bid=SymbolInfoDouble(NULL,SYMBOL_BID);

   FindProfitLevel();

  }
//+------------------------------------------------------------------+



//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void FindProfitLevel()
  {

   ilkIslemProfit=0;
   int IlkTicket=0;
   int IlkType=0;
   double IlkLot=0;

   for(int a =0; a<OrdersTotal(); a++)
     {
      if(OrderSelect(a,SELECT_BY_POS,MODE_TRADES))
        {


         if(OrderSymbol()==Symbol())
           {

            ilkIslemProfit=OrderProfit();
            IlkTicket=OrderTicket();
            IlkType=OrderType();
            IlkLot=OrderLots();
            break;

           }



        }

     }


   ToplamProfit=0;
   double profit=0;

   for(int aa =0; aa<OrdersTotal(); aa++)
     {
      if(OrderSelect(aa,SELECT_BY_POS,MODE_TRADES))
        {

         profit=OrderProfit();

         if(OrderSymbol()==Symbol())
           {


            if(profit>0)
               ToplamProfit=ToplamProfit+profit;


           }



        }

     }


   double ClosePrice;

   if(IlkType==ORDER_TYPE_BUY)
      ClosePrice=SymbolInfoDouble(NULL,SYMBOL_BID);

   else
      ClosePrice=SymbolInfoDouble(NULL,SYMBOL_ASK);



   double RestIslem;


   if(ilkIslemProfit>0)
      RestIslem= ToplamProfit-ilkIslemProfit;

   else

      RestIslem=ToplamProfit;


   Comment("IlkIslem Profit : ",NormalizeDouble(ilkIslemProfit,2), " Diger Islemer profit :",RestIslem);






   if((RestIslem+ilkIslemProfit)>KarUSD)
     {


      if(OrderClose(IlkTicket,IlkLot,ClosePrice,50,clrNONE))
        {

         Print("Islem Kapatıldı. Kapanan Islem Zararı : ",ilkIslemProfit," Diğer Islemler Karı  :  ", RestIslem);


         int aaa =OrdersTotal()-1;

         for(aaa; aaa>=0; aaa--)
           {
            if(OrderSelect(aaa,SELECT_BY_POS,MODE_TRADES))
              {

               profit=OrderProfit();

               if(OrderSymbol()==Symbol())
                  if(profit>0)
                    {


                     if(OrderType()==ORDER_TYPE_BUY)
                       {
                        OrderClose(OrderTicket(),OrderLots(),bid,50,clrNONE);

                       }


                     if(OrderType()==ORDER_TYPE_SELL)
                       {
                        OrderClose(OrderTicket(),OrderLots(),ask,50,clrNONE);

                       }



                    }
              }
           }
        }
     }





// Comment(ilkIslemProfit);

  }
//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+

//+------------------------------------------------------------------+
