//+------------------------------------------------------------------+
//|                                                   SmartHedge.mq4 |
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

// O Otomatik Close Profit
// H Hedge Mode
// B Buy
// S Sell
// C Control
// A Open
// X Object Delete
// P Profit Close
// Q Quick Trade


int fmgc=-1;
bool free_mode=true;
double Lot=0.10;

int order_type=-1;

double wpm=WindowPriceMax();
double wpl=WindowPriceMin();


int ticket;

double distance_pip;


double carpan=3;


int buy_level=-1;
int sell_level=-1;

double buy_tps=0;
double sell_tps=0;

int Orders=OrdersTotal();
int Orderh=OrdersHistoryTotal();


bool profit_close=false;
bool hedge_engine=false;

bool auto_profit_close=false;

bool quick_trade=false;
int quick_trade_yuzde=70;

input int active_magic_buys=-1;
input int active_magic_sells=-1;


int active_magic_buy=-1;
int active_magic_sell=-1;


bool order_hedge_close=false;

bool hedge_engine_turbo=false;

double last_avarage_buy=0; 
double last_avarage_sell=0; 

double last_avarage_buy_profit_price=0;
double last_avarage_sell_profit_price=0;

extern double Lots=0.10;
extern bool auto_lot_config=true;

bool vol75 = false;
int pips=100;
int digit=2;

bool auto_hedge=false;

int level1_expand=0;
int level2_expand=0;
int level3_expand=0;
int level4_expand=0;
int level5_expand=0;

bool level_expand=true;

double levels_expand[6];

bool takeprofit_mode=true;
bool takeprofit_expand_mode=false;


bool extra_pip_mode=false;
int extra_pips=50;
int extra_pip=0;



int OnInit()
  {
  
  /*
  if ( IsDemo() == true ) {} else {
  ExpertRemove();  
  }
  
  if ( int(TimeMonth(TimeCurrent())) == 11 ) {} else {
  ExpertRemove();  
  }*/
  
  
///////////////////////////////////////////////////////
// Level Genişleme Sistemi // Belir birşeyden sonra genişlesin ben onu daraltırım.
///////////////////////////////////////////////////////
if ( level_expand == true ) {

level1_expand=0;
level2_expand=0;
level3_expand=50;
level4_expand=100;
level5_expand=150;

levels_expand[1]=0;
levels_expand[2]=0;
levels_expand[3]=level3_expand*Point();
levels_expand[4]=level4_expand*Point();
levels_expand[5]=level5_expand*Point(); 
 
}  else {

level1_expand=0;
level2_expand=0;
level3_expand=0;
level4_expand=0;
level5_expand=0;

levels_expand[1]=0;
levels_expand[2]=0;
levels_expand[3]=0;
levels_expand[4]=0;
levels_expand[5]=0;  

}  
//////////////////////////////////////////////////////// 
 
 
  
  
    ObjectsDeleteAll(ChartID(),WindowOnDropped(),OBJ_ARROW);
    EventHour();
    
  
  
//---
//###################################################
bool ac_find=false;

//string AccountCompanys=AccountInfoString(ACCOUNT_COMPANY);
string AccountCompanys=AccountCompany();
//Alert("Bilgi:",AccountCompanys,"/",StringFind(AccountCompany(),"Bit",0));
if ( StringFind(AccountCompanys,"Traders Global",0) != -1 ) {
Lot=0.02;
ac_find=true;
if ( StringFind(Symbol(),"XAU",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 ) {
Lot=0.01;
}
}

if ( StringFind(AccountCompanys,"XM",0) != -1 ) {
Lot=0.10;
ac_find=true;
}

if ( ac_find==false || auto_lot_config == false) {
Lot=Lots;
}
//###################################################

////////////////////////////////////////////////////////////////////////
// Deriv Entegrasyonu
///////////////////////////////////////////////////////////////////////
if ( SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN) == 0.001 ) {Lot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
vol75=true;
pips=1000000;
digit=3;
}
///////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////
// Btc Entegrasyonu
///////////////////////////////////////////////////////////////////////
//if ( SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN) == 0.001 ) {Lot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
//if ( StringFind(AccountCompanys,"ByBit",0) != -1 ) {
if ( AccountCompanys=="Bybit Global LLC") {
Lot=SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_MIN);
Lot=0.10;
vol75=true;
if ( Symbol() == "BTCUSDT" ) pips=1000000;
if ( Symbol() == "ETHUSDT" ) pips=100000;
digit=2;
//Alert("Deneme",pips);
}
///////////////////////////////////////////////////////////////////////









if (!IsTradeAllowed()) Alert("EA İzni Kapalı");


double wpm=WindowPriceMax();
double wpl=WindowPriceMin();

ChartSetInteger(ChartID(),CHART_COLOR_BID,clrBlack);
  
  
        string LabelChart="PeriodBilgisis";
        ObjectDelete(ChartID(),LabelChart);
     
        LabelChart="PeriodBilgisi";
        ObjectDelete(ChartID(),LabelChart);
        
        //if ( Period() != PERIOD_M15 ) {
        
        string PeriodBilgisi=TFtoStr(Period());
     if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrDarkRed);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 35);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, 0);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 30);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 33);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30); 
     
         
     } else {     
     LabelChart="PeriodBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     } 
     //}  

     LabelChart="Bilgi";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgiler");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);  

     LabelChart="Bilgiss";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgiler3");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 415);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);  // 95     

     LabelChart="Bilgisss";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgiler4");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 830);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);  // 95     
     
     LabelChart="Bilgissss";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgiler5");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 10);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 1245);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 30);  // 95    
     
          


     LabelChart="Bilgis";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgiler2");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 7);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 45);  


     LabelChart="BilgiBuy";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgiler Buy");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 60);  


     LabelChart="BilgiSell";
     ObjectDelete(ChartID(),LabelChart);
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Bilgiler Sell");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER );
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrWhite);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 8);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 75);  
     

//////////////////////////////////////////////////////////////////////////////////////////     
// ROBOT Baştan başlarsa ekran objesi okur hline stop
/////////////////////////////////////////////////////////////////////////////////////////
FindLineMagicNumber(); 
FindLineTp();    
//////////////////////////////////////////////////////////////////////////////////////////     
// ROBOT Baştan başlarsa ekran okur
/////////////////////////////////////////////////////////////////////////////////////////
if ( active_magic_buy == -1 ) {

int sell_limit_levels=OrderCommetlive("LONG-",Symbol(),OP_SELLLIMIT,-1);

if ( sell_limit_levels == 1 ) {
active_magic_buy=FindMgclive("LONG-",Symbol(),OP_SELLLIMIT);
}

}

if ( active_magic_sell == -1 ) {

int buy_limit_levels=OrderCommetlive("SHORT-",Symbol(),OP_BUYLIMIT,-1);

if ( buy_limit_levels == 1 ) {
active_magic_sell=FindMgclive("SHORT-",Symbol(),OP_BUYLIMIT);
}

}
///////////////////////////////////////////////////////////////////////////////////////
// Limit Emir silindiyse input ile girilebilir
////////////////////////////////////////////////////////////////////////////////////////
if ( active_magic_buys != -1 ) {
active_magic_buy=active_magic_buys;
}

if ( active_magic_sells != -1 ) {
active_magic_sell=active_magic_sells;
}




Comment("Mgc: Sell:"+active_magic_sell+"/ Buy:"+active_magic_buy);

ObjectSetString(ChartID(),"Bilgis",OBJPROP_TEXT,"Mgc: Sell:"+active_magic_sell+"/ Buy:"+active_magic_buy);

   
//---

/////////////////////////////////////////////////////////////////////
// Ekran Okuma
/////////////////////////////////////////////////////////////////////
     if ( hedge_engine_turbo == false ) {
     
     if ( ObjectFind(ChartID(),"hedge_engine_turbo") != -1 ) {
     
     hedge_engine_turbo=true;
     Alert("Ekran Okuma hedge_engine_turbo:",hedge_engine_turbo);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     

     if ( order_hedge_close == false ) {
     
     if ( ObjectFind(ChartID(),"order_hedge_close") != -1 ) {
     
     order_hedge_close=true;
     Alert("order_hedge_close:",order_hedge_close);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     
          
     if ( quick_trade == false ) {
     
     if ( ObjectFind(ChartID(),"quick_trade") != -1 ) {
     
     quick_trade=true;
     Alert("quick_trade:",quick_trade);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     
      
///////////////////////////////////////////////////////////////////////     
          
     if ( auto_profit_close == false ) {
     
     if ( ObjectFind(ChartID(),"auto_profit_close") != -1 ) {
     
     auto_profit_close=true;
     Alert("auto_profit_close:",auto_profit_close);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     

///////////////////////////////////////////////////////////////////////     
          
     if ( hedge_engine == false ) {
     
     if ( ObjectFind(ChartID(),"hedge_engine") != -1 ) {
     
     hedge_engine=true;
     Alert("hedge_engine:",hedge_engine);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     
      
   
///////////////////////////////////////////////////////////////////////     
          
     if ( profit_close == false ) {
     
     if ( ObjectFind(ChartID(),"profit_close") != -1 ) {
     
     profit_close=true;
     Alert("profit_close:",profit_close);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     
      
///////////////////////////////////////////////////////////////////////     
          
     if ( takeprofit_mode == false ) {
     
     if ( ObjectFind(ChartID(),"takeprofit_mode") != -1 ) {
     
     takeprofit_mode=true;
     Alert("takeprofit_mode:",takeprofit_mode);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     
   
///////////////////////////////////////////////////////////////////////     
          
     if ( level_expand == false ) {
     
     if ( ObjectFind(ChartID(),"level_expand") != -1 ) {
     
     level_expand=true;
     Alert("level_expand:",level_expand);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     
   
///////////////////////////////////////////////////////////////////////     
          
     if ( auto_hedge == false ) {
     
     if ( ObjectFind(ChartID(),"auto_hedge") != -1 ) {
     
     auto_hedge=true;
     Alert("auto_hedge:",auto_hedge);
     
     }     
     
     }
///////////////////////////////////////////////////////////////////////     
           
        
                    
      
      
            
           





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
   
 HedgeEngine();
 
 
 if ( auto_profit_close == true ) {
 ProfitMgc();
 }
 
 /*
      string LabelChart="Bilgi";     
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(H)edge Mode:"+hedge_engine+" (O)tomatik Kapama:"+auto_profit_close+" (Q)ucik Trade:"+quick_trade);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(H)edge Mode:"+hedge_engine+" (T)urbo:"+hedge_engine_turbo+" (O)tomatik:"+auto_profit_close+" (Q)ucik Trade:"+quick_trade);*/

      string LabelChart="Bilgi";          
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(H)edge Mode:"+hedge_engine+" (O)tomatik Kapama:"+auto_profit_close+" (Q)ucik Trade:"+quick_trade);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(H)edge Mode:"+hedge_engine+" (T)urbo:"+hedge_engine_turbo+" (O)tomatik Kapama:"+auto_profit_close+" (Q)ucik Trade:"+quick_trade);
     
     LabelChart="Bilgiss";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"Hedge (T)urbo Mode:"+hedge_engine_turbo+" (F)on Close:"+order_hedge_close+" (P)rofit Close:"+profit_close);
     

     /*LabelChart="Bilgisss";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(E) Auto Hedge Mode:"+auto_hedge+" (L)evel Expand:"+level_expand+" (K) TP Mode:"+takeprofit_mode);*/
     
     LabelChart="Bilgisss";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(E) Auto Hedge:"+auto_hedge+" (L)evel Expand:"+level_expand+" (K) TP Expand:"+takeprofit_expand_mode+"("+carpan+")");     
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(E) Auto Hedge:"+auto_hedge+" (L)evel Ex:"+level_expand+" (K) TP Ex:"+takeprofit_expand_mode+"("+carpan+") (v)Ex Pip:"+extra_pip);     

     LabelChart="Bilgissss";
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(E) Auto Hedge:"+auto_hedge+" (L)evel Expand:"+level_expand+" (K) TP Expand:"+takeprofit_expand_mode+"("+carpan+") (v)Ex Pip:"+extra_pip);     
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"(v)Extra Pip:"+extra_pip);     
     
     
     
     if ( quick_trade == true ) QTEngine(); // Quick Trade Quicktrade

///////////////////////////////////////////////////////////////////////////////     
// Ekran Okuma Sistemi
//////////////////////////////////////////////////////////////////////////////     
     if ( hedge_engine_turbo == true ) {
     
     if ( ObjectFind(ChartID(),"hedge_engine_turbo") == -1 ) {
     
     ObjectCreate(ChartID(),"hedge_engine_turbo",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( hedge_engine_turbo == false ) {
     
     if ( ObjectFind(ChartID(),"hedge_engine_turbo") != -1 ) {
     
     ObjectDelete(ChartID(),"hedge_engine_turbo");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
       
//////////////////////////////////////////////////////////////////////////////     
     if ( order_hedge_close == true ) {
     
     if ( ObjectFind(ChartID(),"order_hedge_close") == -1 ) {
     
     ObjectCreate(ChartID(),"order_hedge_close",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( order_hedge_close == false ) {
     
     if ( ObjectFind(ChartID(),"order_hedge_close") != -1 ) {
     
     ObjectDelete(ChartID(),"order_hedge_close");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
     
     
/////////////////////////////////////////////////////////////////////////////////     
       
//////////////////////////////////////////////////////////////////////////////     
     if ( quick_trade == true ) {
     
     if ( ObjectFind(ChartID(),"quick_trade") == -1 ) {
     
     ObjectCreate(ChartID(),"quick_trade",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( quick_trade == false ) {
     
     if ( ObjectFind(ChartID(),"quick_trade") != -1 ) {
     
     ObjectDelete(ChartID(),"quick_trade");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
   
//////////////////////////////////////////////////////////////////////////////     
     if ( auto_profit_close == true ) {
     
     if ( ObjectFind(ChartID(),"auto_profit_close") == -1 ) {
     
     ObjectCreate(ChartID(),"auto_profit_close",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( auto_profit_close == false ) {
     
     if ( ObjectFind(ChartID(),"auto_profit_close") != -1 ) {
     
     ObjectDelete(ChartID(),"auto_profit_close");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
   
//////////////////////////////////////////////////////////////////////////////     
     if ( hedge_engine == true ) {
     
     if ( ObjectFind(ChartID(),"hedge_engine") == -1 ) {
     
     ObjectCreate(ChartID(),"hedge_engine",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( hedge_engine == false ) {
     
     if ( ObjectFind(ChartID(),"hedge_engine") != -1 ) {
     
     ObjectDelete(ChartID(),"hedge_engine");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
   
   
//////////////////////////////////////////////////////////////////////////////     
     if ( profit_close == true ) {
     
     if ( ObjectFind(ChartID(),"profit_close") == -1 ) {
     
     ObjectCreate(ChartID(),"profit_close",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( profit_close == false ) {
     
     if ( ObjectFind(ChartID(),"profit_close") != -1 ) {
     
     ObjectDelete(ChartID(),"profit_close");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
   
   
//////////////////////////////////////////////////////////////////////////////     
     if ( takeprofit_mode == true ) {
     
     if ( ObjectFind(ChartID(),"takeprofit_mode") == -1 ) {
     
     ObjectCreate(ChartID(),"takeprofit_mode",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( takeprofit_mode == false ) {
     
     if ( ObjectFind(ChartID(),"takeprofit_mode") != -1 ) {
     
     ObjectDelete(ChartID(),"takeprofit_mode");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
   
   
//////////////////////////////////////////////////////////////////////////////     
     if ( level_expand == true ) {
     
     if ( ObjectFind(ChartID(),"level_expand") == -1 ) {
     
     ObjectCreate(ChartID(),"level_expand",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( level_expand == false ) {
     
     if ( ObjectFind(ChartID(),"level_expand") != -1 ) {
     
     ObjectDelete(ChartID(),"level_expand");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
   
//////////////////////////////////////////////////////////////////////////////     
     if ( auto_hedge == true ) {
     
     if ( ObjectFind(ChartID(),"auto_hedge") == -1 ) {
     
     ObjectCreate(ChartID(),"auto_hedge",OBJ_ARROW,0,Time[300],Ask);
     
     }     
     
     }

     if ( auto_hedge == false ) {
     
     if ( ObjectFind(ChartID(),"auto_hedge") != -1 ) {
     
     ObjectDelete(ChartID(),"auto_hedge");
     
     }     
     
     }
     
          
/////////////////////////////////////////////////////////////////////////////////     
   
      
   
      
      
         
      
        
     
     
     

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if ( active_magic_buy != -1  ) {

double buy_profit = 0;
double sell_profit = 0;
double buy_lot = 0;
double sell_lot = 0;
double buy_islem=0;
double sell_islem=0;

        for(int ix=0; ix<OrdersTotal(); ix++) {
        if (OrderSelect(ix, SELECT_BY_POS, MODE_TRADES)) {

    //if (  ( OrderMagicNumber() == active_magic_sell || OrderMagicNumber() == active_magic_buy )  && OrderSymbol() == Symbol()    ) {    //xx   
    if (  ( OrderMagicNumber() == active_magic_buy )  && OrderSymbol() == Symbol()    ) {    //xx   

    if ( OrderType() == OP_BUY ) buy_profit=buy_profit+OrderProfit();
    if ( OrderType() == OP_SELL ) sell_profit=sell_profit+OrderProfit();
    
    if ( OrderType() == OP_BUY ) buy_lot=buy_lot+OrderLots();
    if ( OrderType() == OP_SELL ) sell_lot=sell_lot+OrderLots();
    
    if ( OrderType() == OP_BUY ) buy_islem=buy_islem+1;
    if ( OrderType() == OP_SELL ) sell_islem=sell_islem+1;    
    
    
    }

  
              
   }
   
   
   
   
}

double genel_profit = buy_profit+sell_profit;

string bilgi="Buy :"+DoubleToString(buy_lot,2)+ "/ Profit:"+DoubleToString(buy_profit,2)+"$ / Sell :"+DoubleToString(sell_lot,2)+" / Profit:"+DoubleToString(sell_profit,2)+"$ = "+DoubleToString(genel_profit,2)+"$";

ObjectSetString(ChartID(),"BilgiBuy",OBJPROP_TEXT,bilgi);

//if ( buy_lot >= 2 || sell_lot >= 2  )  AvarageSystem(active_magic_buy);

//if ( (buy_islem >=1 && sell_islem >= 2) || (buy_islem >=2 && sell_islem >= 1) ) AvarageSystem(active_magic_buy);

if ( buy_lot != sell_lot && buy_islem >= 1 && sell_islem >= 1 ) AvarageSystem(active_magic_buy);



}


//if ( active_magic_buy != -1 || active_magic_sell != -1 ) {
if ( active_magic_sell != -1 ) {


double buy_profit = 0;
double sell_profit = 0;
double buy_lot = 0;
double sell_lot = 0;
double buy_islem=0;
double sell_islem=0;

        for(int ix=0; ix<OrdersTotal(); ix++) {
        if (OrderSelect(ix, SELECT_BY_POS, MODE_TRADES)) {

    if (  ( OrderMagicNumber() == active_magic_sell  )  && OrderSymbol() == Symbol()    ) {    //xx   

    if ( OrderType() == OP_BUY ) buy_profit=buy_profit+OrderProfit();
    if ( OrderType() == OP_SELL ) sell_profit=sell_profit+OrderProfit();
    
    if ( OrderType() == OP_BUY ) buy_lot=buy_lot+OrderLots();
    if ( OrderType() == OP_SELL ) sell_lot=sell_lot+OrderLots();
    
    if ( OrderType() == OP_BUY ) buy_islem=buy_islem+1;
    if ( OrderType() == OP_SELL ) sell_islem=sell_islem+1;   
        
    
    
    }

  
              
   }
   
}

double genel_profit = DoubleToString(buy_profit+sell_profit,2);

string bilgi="Buy :"+DoubleToString(buy_lot,2)+ "/ Profit:"+DoubleToString(buy_profit,2)+"$ / Sell :"+DoubleToString(sell_lot,2)+" / Profit:"+DoubleToString(sell_profit,2)+"$ = "+DoubleToString(genel_profit,2)+"$";

ObjectSetString(ChartID(),"BilgiSell",OBJPROP_TEXT,bilgi);

//if ( buy_lot >= 2 || sell_lot >= 2  ) AvarageSystem(active_magic_sell);     

//if ( (buy_islem >=1 && sell_islem >= 2) || (buy_islem >=2 && sell_islem >= 1) ) AvarageSystem(active_magic_sell);

if ( buy_lot != sell_lot && buy_islem >= 1 && sell_islem >= 1 ) AvarageSystem(active_magic_sell);



}



bool sym_profit = true;

if ( sym_profit == true ) {


double buy_profit = 0;
double sell_profit = 0;
double buy_lot = 0;
double sell_lot = 0;

        for(int ix=0; ix<OrdersTotal(); ix++) {
        if (OrderSelect(ix, SELECT_BY_POS, MODE_TRADES)) {

    if (  OrderSymbol() == Symbol() ) {    //xx   

    if ( OrderType() == OP_BUY ) buy_profit=buy_profit+OrderProfit();
    if ( OrderType() == OP_SELL ) sell_profit=sell_profit+OrderProfit();
    
    if ( OrderType() == OP_BUY ) buy_lot=buy_lot+OrderLots();
    if ( OrderType() == OP_SELL ) sell_lot=sell_lot+OrderLots();
    
    
    }

  
              
   }
   
}

double genel_profit = DoubleToString(buy_profit+sell_profit,2);

string bilgi="Buy :"+DoubleToString(buy_lot,2)+ "/ "+DoubleToString(buy_profit,2)+"$ / Sell :"+DoubleToString(sell_lot,2)+" / "+DoubleToString(sell_profit,2)+"$ = "+DoubleToString(genel_profit,2)+"$";

ObjectSetString(ChartID(),"Bilgis",OBJPROP_TEXT,"Mgc S:"+active_magic_sell+"/ B:"+active_magic_buy+" "+bilgi);

if ( genel_profit > 0 ) ObjectSetInteger(ChartID(),"Bilgis",OBJPROP_COLOR,clrLimeGreen);
if ( genel_profit <= 0 ) ObjectSetInteger(ChartID(),"Bilgis",OBJPROP_COLOR,clrWhite);

}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

     
     
//if ( active_magic_buy != -1 ) AvarageSystem(active_magic_buy);
//if ( active_magic_sell != -1 ) AvarageSystem(active_magic_sell);     
   
  }

//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
  
  
  if ( auto_hedge == true ) { AutoHedgeEngine(); }
  
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

/*
if ( sparam == 37 ) {

if ( takeprofit_mode == true ) { takeprofit_mode = false; } else { takeprofit_mode=true;}

Comment("TP Mode:",takeprofit_mode);


}*/

if ( sparam == 47 ) { //V

if ( extra_pip_mode == true ) { extra_pip_mode=false;extra_pip=0;} else {extra_pip_mode=true;extra_pip=extra_pips;}

Comment("Extra Pip Mode:",extra_pip_mode," | Pip:",extra_pip);

}


if ( sparam == 37 ) {

if ( takeprofit_expand_mode == true ) { takeprofit_expand_mode = false; carpan=3;} else { takeprofit_expand_mode=true;carpan=30;}

Comment("TP Expand Mode:",takeprofit_expand_mode);


}









if ( sparam == 38 ) {  // L 


if ( level_expand == true ) {

level1_expand=0;
level2_expand=0;
level3_expand=0;
level4_expand=0;
level5_expand=0;

levels_expand[1]=0;
levels_expand[2]=0;
levels_expand[3]=0;
levels_expand[4]=0;
levels_expand[5]=0;  

level_expand=false;

}  else {

level1_expand=0;
level2_expand=0;
level3_expand=50;
level4_expand=100;
level5_expand=150;

levels_expand[1]=0;
levels_expand[2]=0;
levels_expand[3]=level3_expand*Point();
levels_expand[4]=level4_expand*Point();
levels_expand[5]=level5_expand*Point();  

level_expand=true;

}  
 
Comment("Level Expand:",level_expand); 

}


if ( sparam == 18 ) { // E

if ( auto_hedge == true ) { auto_hedge = false;EventKillTimer(); } else {

    int cevap=MessageBox("Auto Hedge Mode Açılsın mı?","İslem Açmak",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
auto_hedge=true;EventSetTimer(1);order=false;
}

}

Comment("AutoHedge:",auto_hedge);

last_time=Time[0];



}



if ( sparam == 33 ) { // F

if ( order_hedge_close == false ) { order_hedge_close=true;} else { order_hedge_close=false;}

Comment("Fon Mode High Low Close:",order_hedge_close);

}




  if ( sparam == 19 ) { // r
  if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS) == true ) { 
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,false);
  } else { 
  ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,true);
  }
  
  }   
  
  

if ( sparam == 16 ) {

Print("Quick Trade");

if ( quick_trade  == true ) { quick_trade = false; } else { quick_trade = true; }


Comment("Quick Trade",quick_trade);


}




if ( sparam == 24 ) {

Print("Otomatik Close");

if ( auto_profit_close  == true ) { auto_profit_close = false; } else { auto_profit_close = true; }


Comment("Otomatik Profit Close",auto_profit_close);


}

if ( sparam == 20 ) {

if ( hedge_engine_turbo == false ) { 


     int cevap=MessageBox("Turbo Mode Açılsın mı?","İslem Açmak",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
hedge_engine_turbo=true;
}



} else { hedge_engine_turbo=false;}

Comment("Hedge Engine Turbo:",hedge_engine_turbo);

}



if ( sparam == 35 ) {

if ( hedge_engine == false ) { hedge_engine=true;} else { hedge_engine=false;}

Comment("Hedge Engine:",hedge_engine);

}

Print("Sparam",sparam);


if ( sparam == 30 ) AlertOrder();



if ( sparam == 45 ) {

ObjectsDeleteAll(ChartID(),-1,OBJ_TREND);
ObjectsDeleteAll(ChartID(),-1,OBJ_RECTANGLE);
ObjectsDeleteAll(ChartID(),-1,OBJ_HLINE);
ObjectsDeleteAll(ChartID(),-1,OBJ_ARROW_BUY);
ObjectsDeleteAll(ChartID(),-1,OBJ_ARROW_SELL);
ObjectsDeleteAll(ChartID(),WindowOnDropped(),OBJ_ARROW);


     int cevap=MessageBox("İşlemleri Kapatalım Mı ?","İslem Açmak",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {
     OrderCloseAll(active_magic_buy);
     OrderCloseAll(active_magic_sell);
     active_magic_buy=-1;
     active_magic_sell=-1;
     
////////////////////////////////////////////////
quick_trade=false;
hedge_engine=false;
hedge_engine_turbo=false;
profit_close=false;
auto_profit_close=false;
///////////////////////////////////////////////    

 
     } 
     



}


if ( sparam == 25 ) { //p

//Alert("ProfitClose");


ProfitMgc();


}





if ( sparam == 17 ) { // w

FindLineMagicNumber();

}






if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_HLINE //&& StringFind(sparam,"Hedge",0) == -1 

) {

string last_select_object=sparam;
//last_object=sparam;


          ENUM_OBJECT obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_object,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_BACK);
          int obj_style = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_STYLE);
          string obj_text = ObjectGetString(ChartID(),last_select_object,OBJPROP_TEXT);
          string obj_tool = ObjectGetString(ChartID(),last_select_object,OBJPROP_TOOLTIP);

if ( obj_tool != "" ) {

ticket=StringToInteger(obj_tool);

Comment("Ticket:",ticket);

}



if ( obj_text != "" ) {

fmgc=StringToInteger(obj_text);

//Comment("Ticket:",ticket,"/ Mgc:",obj_text);

if ( StringFind(last_select_object,"BUYSTOP",0) != -1 ) active_magic_buy=fmgc;
if ( StringFind(last_select_object,"SELLSTOP",0) != -1 ) active_magic_sell=fmgc;

Comment("Ticket:",ticket,"/ Mgc:",obj_text,"/active_magic_buy:",active_magic_buy,"/active_magic_sell:",active_magic_sell);

}


}




if ( StringToInteger(sparam) >= 2 && StringToInteger(sparam) <= 10 ) {

carpan=StringToInteger(sparam)-1;

Comment("Çarpan:",carpan);


}





   
if ( sparam == 48 ) {


//////////////////////////////////////////////////////////////////////////////////////
/// SELL LIMIT = BUY
//////////////////////////////////////////////////////////////////////////////////////
int sell_limit_levels=OrderCommetlive("LONG-"+active_magic_buy,Symbol(),OP_SELLLIMIT,active_magic_buy);

if ( sell_limit_levels > 0 ) return;
//////////////////////////////////////////////////////////////////////////////////////////


order_type=OP_BUY;

wpm=WindowPriceMax();
wpl=WindowPriceMin();

fmgc=FreeMgc();
//ticket=OrderSend(Symbol(),OP_BUYSTOP,MarketInfo(Symbol(),MODE_MAXLOT),wpm,0,wpm-100*Point,0,"LONG-"+fmgc,fmgc,0,clrNONE);
ticket=OrderSend(Symbol(),OP_SELLLIMIT,MarketInfo(Symbol(),MODE_MAXLOT),wpm,0,0,wpm-pips*Point,"LONG-"+fmgc,fmgc,0,clrNONE);
ObjectCreate(ChartID(),"BUYSTOP"+ticket,OBJ_HLINE,0,Time[0],wpm);
ObjectSetString(ChartID(),"BUYSTOP"+ticket,OBJPROP_TOOLTIP,ticket);
ObjectSetInteger(ChartID(),"BUYSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"BUYSTOP"+ticket,OBJPROP_COLOR,clrChartreuse);
ObjectSetString(ChartID(),"BUYSTOP"+ticket,OBJPROP_TEXT,fmgc);

active_magic_buy=fmgc;
/*
fmgc=FreeMgc();
//Alert("Buy"+fmgc);
OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,fmgc,fmgc,0,clrNONE);
fmgc=FreeMgc();
OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,fmgc,fmgc,0,clrNONE);
*/

}
   
   
if ( sparam == 31 ) {

//////////////////////////////////////////////////////////////////////////////////////
/// BUY LIMIT = SELL
////////////////////////////////////////////////////////////////////////////////////////
int buy_limit_levels=OrderCommetlive("SHORT-"+active_magic_sell,Symbol(),OP_BUYLIMIT,active_magic_sell);

if ( buy_limit_levels > 0 ) return;
////////////////////////////////////////////////////////////////////////////////////////


order_type=OP_SELL;

wpm=WindowPriceMax();
wpl=WindowPriceMin();

fmgc=FreeMgc();
//ticket=OrderSend(Symbol(),OP_SELLSTOP,MarketInfo(Symbol(),MODE_MAXLOT),wpl,0,wpl+100*Point,0,"SHORT"+fmgc,fmgc,0,clrNONE);
ticket=OrderSend(Symbol(),OP_BUYLIMIT,MarketInfo(Symbol(),MODE_MAXLOT),wpl,0,0,wpl+pips*Point,"SHORT-"+fmgc,fmgc,0,clrNONE);
ObjectCreate(ChartID(),"SELLSTOP"+ticket,OBJ_HLINE,0,Time[0],wpl);
ObjectSetString(ChartID(),"SELLSTOP"+ticket,OBJPROP_TOOLTIP,ticket);
ObjectSetInteger(ChartID(),"SELLSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"SELLSTOP"+ticket,OBJPROP_COLOR,clrChartreuse);
ObjectSetString(ChartID(),"SELLSTOP"+ticket,OBJPROP_TEXT,fmgc);

active_magic_sell=fmgc;
/*
fmgc=FreeMgc();
//Alert("Sell"+fmgc);
OrderSend(Symbol(),OP_SELL,Lot,Ask,0,0,0,fmgc,fmgc,0,clrNONE);
fmgc=FreeMgc();
OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,fmgc,fmgc,0,clrNONE);
*/
}
   
   

if ( sparam == 46 ) {
    Controls();
}   
   
   

   
   
  }
//+------------------------------------------------------------------+

int pips_max_limit=100;
int pips_max_limit_gold=150;
int pips_max_limit_standart=100;
int pips_max_limit_gbpusd=125;
int pips_max_limit_btcusd=10000;

void Controls() {

//Alert(Digits);


if ( StringFind(Symbol(),"XAUUSD",0) != -1 || StringFind(Symbol(),"GOLD",0) != -1 ) {
pips_max_limit=pips_max_limit_gold;
if ( Digits == 3 ) pips_max_limit = pips_max_limit*10;
} else {
pips_max_limit=pips_max_limit_standart;
}

if ( StringFind(Symbol(),"GBPUSD",0) != -1  ) {
pips_max_limit=pips_max_limit_gbpusd;
}

if ( StringFind(Symbol(),"BTCUSD",0) != -1  ) {
pips_max_limit=pips_max_limit_btcusd;
}



if( extra_pip_mode == true ) {
pips_max_limit=pips_max_limit+extra_pip;
}


//Alert("Control");


string order_mode="";
//if ( order_type == OP_BUY ) order_mode="BUY"; 
//if ( order_type == OP_SELL ) order_mode="SELL";   

double buy_tp;
double sell_tp;
double buy_price;
double sell_price;


 if(OrderSelect(ticket, SELECT_BY_TICKET)==true)
    {
    
    
    
   /*double ask=SymbolInfoDouble(OrderSymbol(),SYMBOL_ASK);
   double bid=SymbolInfoDouble(OrderSymbol(),SYMBOL_BID);
   double points=SymbolInfoDouble(OrderSymbol(),SYMBOL_POINT);
   double digits=SymbolInfoInteger(OrderSymbol(),SYMBOL_DIGITS);
   double spread=NormalizeDouble((ask-bid)*points,digits);
    
    Comment("Spread",spread);*/
    
    
    
    if ( OrderType() == OP_SELLLIMIT ) {
    distance_pip=OrderOpenPrice()-OrderTakeProfit();
    

    if ( distance_pip/Point > pips_max_limit ) {
    Comment("Mesafe "+pips_max_limit+" den büyük olamaz");
    Sleep(200);
    OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()-pips_max_limit*Point,0,clrNONE);  
    distance_pip=pips_max_limit*Point;
    }
        
    
    
    order_mode="BUY";   
    fmgc=OrderMagicNumber(); 
    
    
   
   buy_price=Ask;
   buy_tp=buy_price+((distance_pip)*carpan);
   //sell_price=op-((tp-op)/carpan);
   sell_price=buy_price-distance_pip;
   sell_tp=sell_price-((distance_pip)*carpan);   
   
   ObjectDelete(ChartID(),ticket+"Hedge");
   ObjectCreate(ChartID(),ticket+"Hedge",OBJ_RECTANGLE,0,Time[50],buy_price,Time[1],sell_price);
   ObjectSetInteger(ChartID(),ticket+"Hedge",OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),ticket+"Hedge",OBJPROP_TEXT,Lot);
   
   ObjectDelete(ChartID(),ticket+"Hedges");
   ObjectCreate(ChartID(),ticket+"Hedges",OBJ_RECTANGLE,0,Time[50],buy_price,Time[1],buy_price+(buy_price-sell_price));
   ObjectSetInteger(ChartID(),ticket+"Hedges",OBJPROP_COLOR,clrCrimson);
   ObjectSetInteger(ChartID(),ticket+"Hedges",OBJPROP_FILL,clrNONE);
   ObjectSetInteger(ChartID(),ticket+"Hedges",OBJPROP_BACK,false);   
      
   
//////////////////////////////////////////////////////////////////////
// QUICK TRADE LEVEL BUY PROFIT
//////////////////////////////////////////////////////////////////////
    double yuzde=distance_pip/100;
    double profit_price=buy_price+(yuzde*quick_trade_yuzde);

    
    string name=OrderTicket()+"QuickTrade";
    ObjectDelete(ChartID(),name);
    //if ( ObjectFind(name) == -1 ) {
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[30],profit_price,Time[30]+500*PeriodSeconds(),profit_price);
    ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGreen);
    //}  
//////////////////////////////////////////////////////////////////////    
           

//////////////////////////////////////////////////////////////////////
// QUICK TRADE LEVEL SELL PROFIT
//////////////////////////////////////////////////////////////////////
    //double yuzde=distance_pip/100;
    double profit_pricep=buy_price-(yuzde*quick_trade_yuzde);

    
    name=OrderTicket()+"QuickTradep";
    ObjectDelete(ChartID(),name);
    //if ( ObjectFind(name) == -1 ) {
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[30],profit_pricep,Time[30]+500*PeriodSeconds(),profit_pricep);
    ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrCrimson);
    //}  
//////////////////////////////////////////////////////////////////////    
      
      
          
    
    
    
    }
    
    if ( OrderType() == OP_BUYLIMIT ) {
    
    
    distance_pip=OrderTakeProfit()-OrderOpenPrice();
    
    
    if ( distance_pip/Point > pips_max_limit ) {
    Comment("Mesafe "+pips_max_limit+" den büyük olamaz");
    Sleep(200);
    OrderModify(OrderTicket(),OrderOpenPrice(),OrderStopLoss(),OrderOpenPrice()+pips_max_limit*Point,0,clrNONE);  
    distance_pip=pips_max_limit*Point;
    }
    
    
    
    
    
    order_mode="SELL";   
    fmgc=OrderMagicNumber();
    

   sell_price=Bid;
   sell_tp=sell_price-((distance_pip)*carpan);
   
   buy_price=sell_price+distance_pip;
   buy_tp=buy_price+((distance_pip)*carpan);
   
   ObjectDelete(ChartID(),ticket+"Hedge");
   ObjectCreate(ChartID(),ticket+"Hedge",OBJ_RECTANGLE,0,Time[50],sell_price,Time[1],buy_price);
   ObjectSetInteger(ChartID(),ticket+"Hedge",OBJPROP_COLOR,clrCrimson);
   
   ObjectDelete(ChartID(),ticket+"Hedges");
   ObjectCreate(ChartID(),ticket+"Hedges",OBJ_RECTANGLE,0,Time[50],sell_price,Time[1],sell_price-(buy_price-sell_price));
   ObjectSetInteger(ChartID(),ticket+"Hedges",OBJPROP_COLOR,clrBlue);
   ObjectSetInteger(ChartID(),ticket+"Hedges",OBJPROP_FILL,clrNONE);
   ObjectSetInteger(ChartID(),ticket+"Hedges",OBJPROP_BACK,false);



//////////////////////////////////////////////////////////////////////
// QUICK TRADE LEVEL SELL PROFIT
//////////////////////////////////////////////////////////////////////    
    double yuzde=distance_pip/100;
    double profit_price=sell_price-(yuzde*quick_trade_yuzde);

    
    string name=OrderTicket()+"QuickTrade";
    ObjectDelete(ChartID(),name);
    //if ( ObjectFind(name) == -1 ) {
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[30],profit_price,Time[30]+500*PeriodSeconds(),profit_price);
    ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGreen);
    //}  
//////////////////////////////////////////////////////////////////////       
       
//////////////////////////////////////////////////////////////////////
// QUICK TRADE LEVEL BUY PROFIT
//////////////////////////////////////////////////////////////////////    
    //double yuzde=distance_pip/100;
    double profit_pricep=sell_price+(yuzde*quick_trade_yuzde);
    
    name=OrderTicket()+"QuickTradep";
    ObjectDelete(ChartID(),name);
    //if ( ObjectFind(name) == -1 ) {
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[30],profit_pricep,Time[30]+500*PeriodSeconds(),profit_pricep);
    ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrLightGreen);
    //}  
//////////////////////////////////////////////////////////////////////       
      
      
         
       
    
    }
    

string name=ticket+"BUY-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[50],buy_tp,Time[1],buy_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);

name=ticket+"SELL-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[50],sell_tp,Time[1],sell_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
    


//Alert("Control",order_mode,"/",fmgc,"/ Distance Pip:",distance_pip/Point);
    
    
    }

}


void AlertOrder()
{

if ( active_magic_buy != -1 && active_magic_sell != -1 ) {
Alert("İşlem Operasyonu Önceden Yapılmış");
return;
}


     int cevap=MessageBox("Badluck Hazır Mısın ?","İslem Açmak",4); //  / Spread:"+Spread_Yuzde+"%"
     if ( cevap == 6 ) {} else {
     return;
     }
     
     




string order_mode="";
//if ( order_type == OP_BUY ) order_mode="BUY"; 
//if ( order_type == OP_SELL ) order_mode="SELL";   

double buy_tp;
double sell_tp;
double buy_price;
double sell_price;


 if(OrderSelect(ticket, SELECT_BY_TICKET)==true)
    {
    
    if ( OrderType() == OP_SELLLIMIT ) {
    distance_pip=OrderOpenPrice()-OrderTakeProfit();
    order_mode="BUY";   
    fmgc=OrderMagicNumber(); 
       
ObjectCreate(ChartID(),"BUYTPSTOP"+ticket,OBJ_HLINE,0,Time[0],OrderTakeProfit());
ObjectSetString(ChartID(),"BUYTPSTOP"+ticket,OBJPROP_TOOLTIP,fmgc);
ObjectSetInteger(ChartID(),"BUYTPSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"BUYSTPTOP"+ticket,OBJPROP_COLOR,clrDarkGreen);
ObjectSetString(ChartID(),"BUYTPSTOP"+ticket,OBJPROP_TEXT,OrderTakeProfit());//distance_pip
ObjectSetInteger(ChartID(),"BUYSTPTOP"+ticket,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),"BUYSTPTOP"+ticket,OBJPROP_BACK,true);
    
    
   
   buy_price=Ask;
   buy_tp=buy_price+((distance_pip)*carpan);
   //sell_price=op-((tp-op)/carpan);
   sell_price=buy_price-distance_pip;
   sell_tp=sell_price-((distance_pip)*carpan);   
   
   ObjectDelete(ChartID(),ticket+"Hedge");
   ObjectCreate(ChartID(),ticket+"Hedge",OBJ_RECTANGLE,0,Time[50],buy_price,Time[1],sell_price);
   ObjectSetInteger(ChartID(),ticket+"Hedge",OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),ticket+"Hedge",OBJPROP_TEXT,Lot);
   
   if ( takeprofit_mode == false ) {sell_tp=0;buy_tp=0;}
   
    
    OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,buy_tp,fmgc+"BUY-0",fmgc,0,clrNONE);
if ( hedge_engine_turbo == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*2,sell_price,0,0,sell_tp,fmgc+"SELL-0",fmgc,0,clrNONE);
if ( hedge_engine_turbo == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*3,sell_price,0,0,sell_tp,fmgc+"SELL-0",fmgc,0,clrNONE);
    
    
string name=ticket+"BUY-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[50],buy_tp,Time[1],buy_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);

name=ticket+"SELL-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[50],sell_tp,Time[1],sell_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
    

    
//////////////////////////////////////////////////////////////////////////////////////////////////
      
wpm=WindowPriceMax();
wpl=WindowPriceMin();

ObjectDelete(ChartID(),ticket+"Hedges");

fmgc=FreeMgc();
//ticket=OrderSend(Symbol(),OP_SELLSTOP,MarketInfo(Symbol(),MODE_MAXLOT),wpl,0,wpl+100*Point,0,"SHORT"+fmgc,fmgc,0,clrNONE);
ticket=OrderSend(Symbol(),OP_BUYLIMIT,MarketInfo(Symbol(),MODE_MAXLOT),wpl,0,0,wpl+distance_pip,"SHORT-"+fmgc,fmgc,0,clrNONE);
ObjectCreate(ChartID(),"SELLSTOP"+ticket,OBJ_HLINE,0,Time[0],wpl);
ObjectSetString(ChartID(),"SELLSTOP"+ticket,OBJPROP_TOOLTIP,ticket);
ObjectSetInteger(ChartID(),"SELLSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"SELLSTOP"+ticket,OBJPROP_COLOR,clrChartreuse);
ObjectSetString(ChartID(),"SELLSTOP"+ticket,OBJPROP_TEXT,fmgc);


ObjectCreate(ChartID(),"SELLTPSTOP"+ticket,OBJ_HLINE,0,Time[0],wpl+distance_pip);
ObjectSetString(ChartID(),"SELLTPSTOP"+ticket,OBJPROP_TOOLTIP,fmgc);
ObjectSetInteger(ChartID(),"SELLTPSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"SELLSTPTOP"+ticket,OBJPROP_COLOR,clrDarkRed);
ObjectSetString(ChartID(),"SELLTPSTOP"+ticket,OBJPROP_TEXT,wpl+distance_pip);//distance_pip
ObjectSetInteger(ChartID(),"SELLSTPTOP"+ticket,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),"SELLSTPTOP"+ticket,OBJPROP_BACK,true);



//Alert("Selam");


active_magic_sell=fmgc;

sell_price=Bid;
sell_tp=sell_price-((distance_pip)*carpan); 
buy_price=sell_price+distance_pip;
buy_tp=buy_price+((distance_pip)*carpan); 

if ( takeprofit_mode == false ) {sell_tp=0;buy_tp=0;}
  
   OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,sell_tp,fmgc+"SELLP-0",fmgc,0,clrNONE);
if ( hedge_engine_turbo == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*2,buy_price,0,0,buy_tp,fmgc+"BUYP-0",fmgc,0,clrNONE);
if ( hedge_engine_turbo == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*3,buy_price,0,0,buy_tp,fmgc+"BUYP-0",fmgc,0,clrNONE);

   ObjectDelete(ChartID(),ticket+"Hedges");
   ObjectCreate(ChartID(),ticket+"Hedges",OBJ_RECTANGLE,0,Time[50],sell_price,Time[1],buy_price);
   ObjectSetInteger(ChartID(),ticket+"Hedges",OBJPROP_COLOR,clrCrimson);

name=ticket+"BUY-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[20],buy_tp,Time[1],buy_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);

name=ticket+"SELL-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[20],sell_tp,Time[1],sell_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);

   
   
//////////////////////////////////////////////////////////////////////////////////////////////////    
    }
    
    if ( OrderType() == OP_BUYLIMIT ) {
    distance_pip=OrderTakeProfit()-OrderOpenPrice();
    order_mode="SELL";   
    fmgc=OrderMagicNumber();
    

ObjectCreate(ChartID(),"SELLTPSTOP"+ticket,OBJ_HLINE,0,Time[0],OrderTakeProfit());
ObjectSetString(ChartID(),"SELLTPSTOP"+ticket,OBJPROP_TOOLTIP,fmgc);
ObjectSetInteger(ChartID(),"SELLTPSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"SELLSTPTOP"+ticket,OBJPROP_COLOR,clrDarkRed);
ObjectSetString(ChartID(),"SELLTPSTOP"+ticket,OBJPROP_TEXT,OrderTakeProfit());//distance_pip
ObjectSetInteger(ChartID(),"SELLSTPTOP"+ticket,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),"SELLSTPTOP"+ticket,OBJPROP_BACK,true);
    
    

   sell_price=Bid;
   sell_tp=sell_price-((distance_pip)*carpan);
   
   buy_price=sell_price+distance_pip;
   buy_tp=buy_price+((distance_pip)*carpan);
   
   ObjectDelete(ChartID(),ticket+"Hedge");
   ObjectCreate(ChartID(),ticket+"Hedge",OBJ_RECTANGLE,0,Time[50],sell_price,Time[1],buy_price);
   ObjectSetInteger(ChartID(),ticket+"Hedge",OBJPROP_COLOR,clrCrimson);
   
   if ( takeprofit_mode == false ) {sell_tp=0;buy_tp=0;}
   
   
    OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,sell_tp,"SELL",fmgc,0,clrNONE);
if ( hedge_engine_turbo == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*2,buy_price,0,0,buy_tp,"BUY",fmgc,0,clrNONE);
if ( hedge_engine_turbo == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*3,buy_price,0,0,buy_tp,"BUY",fmgc,0,clrNONE);

    
string name=ticket+"BUY-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[50],buy_tp,Time[1],buy_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);

name=ticket+"SELL-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[50],sell_tp,Time[1],sell_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);
    
    
    
////////////////////////////////////////////////////////////////////////////////////////////////    
    
wpm=WindowPriceMax();
wpl=WindowPriceMin();

ObjectDelete(ChartID(),ticket+"Hedges");

fmgc=FreeMgc();
//ticket=OrderSend(Symbol(),OP_BUYSTOP,MarketInfo(Symbol(),MODE_MAXLOT),wpm,0,wpm-100*Point,0,"LONG-"+fmgc,fmgc,0,clrNONE);
ticket=OrderSend(Symbol(),OP_SELLLIMIT,MarketInfo(Symbol(),MODE_MAXLOT),wpm,0,0,wpm-distance_pip,"LONG-"+fmgc,fmgc,0,clrNONE);
ObjectCreate(ChartID(),"BUYSTOP"+ticket,OBJ_HLINE,0,Time[0],wpm);
ObjectSetString(ChartID(),"BUYSTOP"+ticket,OBJPROP_TOOLTIP,ticket);
ObjectSetInteger(ChartID(),"BUYSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"BUYSTOP"+ticket,OBJPROP_COLOR,clrChartreuse);
ObjectSetString(ChartID(),"BUYSTOP"+ticket,OBJPROP_TEXT,fmgc);

ObjectCreate(ChartID(),"BUYTPSTOP"+ticket,OBJ_HLINE,0,Time[0],wpm-distance_pip);
ObjectSetString(ChartID(),"BUYTPSTOP"+ticket,OBJPROP_TOOLTIP,fmgc);
ObjectSetInteger(ChartID(),"BUYTPSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"BUYSTPTOP"+ticket,OBJPROP_COLOR,clrDarkGreen);
ObjectSetString(ChartID(),"BUYTPSTOP"+ticket,OBJPROP_TEXT,wpm-distance_pip);//distance_pip
ObjectSetInteger(ChartID(),"BUYSTPTOP"+ticket,OBJPROP_SELECTABLE,false);
ObjectSetInteger(ChartID(),"BUYSTPTOP"+ticket,OBJPROP_BACK,true);
    
    


active_magic_buy=fmgc;

buy_price=Ask;
buy_tp=buy_price+((distance_pip)*carpan);  

   sell_price=buy_price-distance_pip;
   sell_tp=sell_price-((distance_pip)*carpan);

if ( takeprofit_mode == false ) {sell_tp=0;buy_tp=0;}

 
ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,buy_tp,fmgc+"BUYP-0",fmgc,0,clrNONE);

  
if ( hedge_engine_turbo == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*2,sell_price,0,0,sell_tp,fmgc+"SELLP-0",fmgc,0,clrNONE);
if ( hedge_engine_turbo == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*3,sell_price,0,0,sell_tp,fmgc+"SELLP-0",fmgc,0,clrNONE);       

   ObjectDelete(ChartID(),ticket+"Hedges");
   ObjectCreate(ChartID(),ticket+"Hedges",OBJ_RECTANGLE,0,Time[50],buy_price,Time[1],sell_price);
   ObjectSetInteger(ChartID(),ticket+"Hedges",OBJPROP_COLOR,clrBlue);
   ObjectSetString(ChartID(),ticket+"Hedges",OBJPROP_TEXT,Lot);
   

name=ticket+"BUY-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[20],buy_tp,Time[1],buy_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);

name=ticket+"SELL-TP";
ObjectDelete(ChartID(),name);
ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[20],sell_tp,Time[1],sell_tp);
ObjectSetInteger(ChartID(),name,OBJPROP_COLOR,clrChartreuse);

   
///////////////////////////////////////////////////////////////////////////////////////////////    
    }
    



//Alert("Control",order_mode,"/",fmgc,"/ Distance Pip:",distance_pip/Point);


///////////////////////////
// QuickTrade Enable
quick_trade=true;
//////////////////////////

}


}




 //////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
int OrderCommetlive(string cmt,string sym,int typ,int mgc){

int coms = 0;


if ( free_mode == true ) cmt="";



  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    
    //Print(OrderTicket());

   //if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt || ( free_mode==true && cmt=="") ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 )  ) {
   if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt || ( free_mode==true && cmt=="") ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 && OrderMagicNumber() != 0 )  ) {
   
   coms = coms +1;

 }
 }
 
 //Print("Live:",coms);
 
return coms;
};
////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////  
// New Mgc Number  
/////////////////////////////////////////////////////////////////////// 
int FreeMgc()
{

int mgc_num=0;
int toplam_order=0;
bool find=false;
//if ( Orders < OrdersTotal() ) {

for ( int m=1;m<100;m++) {

find=false;

   string txt;
   double OCP;

          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS)) {

    if ( OrderMagicNumber() == m && OrderMagicNumber() != 0 && find == false) {      
    mgc_num=m;
    find=true;
    }

                
   }
   
}

}

mgc_num=mgc_num+1;


return mgc_num;

}
///////////////////////////////////////////////////////////////////////  
// Toplam Order Sayısı  
/////////////////////////////////////////////////////////////////////// 
int OrderTotalSym(string sym,int mgc)
{

int com=0;

//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   int ii=OrdersTotal()-1;
          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {


    if ( OrderSymbol() == sym && OrderMagicNumber() == mgc) {      
    com=com+1;
    }

  
              
   }
   
}

return com;

}



///////////////////////////////////////////////////////////////////////  
// Order Price 
/////////////////////////////////////////////////////////////////////// 
double OrderTotalPrice(int typ,string sym,int mgc,string bilgi)
{

double result=0;

datetime last_time=TimeCurrent();

//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   int ii=OrdersTotal()-1;
          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {

    if ( OrderType() == typ && OrderSymbol() == sym && OrderMagicNumber() == mgc && OrderOpenTime() < last_time ) {      
    if ( bilgi=="OP" ) result=OrderOpenPrice();
    if ( bilgi=="TP" ) result=OrderTakeProfit();
    if ( bilgi=="SL" ) result=OrderStopLoss();
    last_time=OrderOpenTime();
    }

  
              
   }
   
}

return result;

}

/*
///////////////////////////////////////////////////////////////////////  
// Order Price 
/////////////////////////////////////////////////////////////////////// 
double OrderTotalPrice(int typ,string sym,int mgc,string bilgi)
{

double result=0;


//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   int ii=OrdersTotal()-1;
          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {


    if ( OrderType() == typ && OrderSymbol() == sym && OrderMagicNumber() == mgc) {      
    if ( bilgi=="OP" ) result=OrderOpenPrice();
    if ( bilgi=="TP" ) result=OrderTakeProfit();
    if ( bilgi=="SL" ) result=OrderStopLoss();
    return result;
    }

  
              
   }
   
}

return result;

}

*/


///////////////////////////////////////////////////////////////////////  
// PROFIT TYPE 
/////////////////////////////////////////////////////////////////////// 
double OrderTotalProfit(int typ,string sym,int mgc)
{

double profits=0;

//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   int ii=OrdersTotal()-1;
          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES)) {


    if ( OrderType() == typ && OrderSymbol() == sym && OrderMagicNumber() == mgc) {      
    profits=profits+OrderProfit();
    }

  
              
   }
   
}

return profits;

}


///////////////////////////////////////////////////////////////////////  
// PROFIT  
/////////////////////////////////////////////////////////////////////// 
bool ProfitMgc()
{

profit_close = true;

int mgc_num=0;
int toplam_order=0;
double profit=0;

//if ( Orders < OrdersTotal() ) {

for ( int m=1;m<100;m++) {


//////////////////////////////////////////////////////////////////////
if ( m == active_magic_buy || m == active_magic_sell ) {
// Ekranda Seçili Olanlar
} else {
continue;
}
//////////////////////////////////////////////////////////////////////



profit=0;

   string txt;
   double OCP;

          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS)) {

    if ( OrderSymbol() == Symbol() && OrderMagicNumber() == m && OrderMagicNumber() != 0 ) {      //xx
    mgc_num=m;
    profit=profit+OrderProfit();
    
    //if ( profit > 0 ) OrderCloseAll(OrderMagicNumber());
    
    
  /*  if ( profit > 0 ) {
    OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
          for(int ii=0; ii<OrdersTotal(); ii++) {
        if (OrderSelect(ii, SELECT_BY_POS)) {
        if ( OrderMagicNumber() == mgc_num  ) {
        if ( OrderType() < 2 ) OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
        if ( OrderType() >= 2 ) OrderDelete(OrderTicket(),clrNONE);
        }        
        }
        }
    }*/

    
    }

                
   }
   
}

if ( profit > 0 ) {OrderCloseAll(mgc_num);
//////////////////////////////////////////////////////
quick_trade=false;
hedge_engine=true;
auto_profit_close=true;
/////////////////////////////////////////////////////
}


///////////////////////////////////////////////////////
/*if ( profit >= 0 ) {

          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS)) {
        if ( OrderMagicNumber() == mgc_num  ) {
        if ( OrderType() < 2 && OrderProfit() > 0) OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
        if ( OrderType() >= 2 ) OrderDelete(OrderTicket(),clrNONE);
        }        
        }
        }


}*/
//////////////////////////////////////////////////////
}


profit_close=false;


return true;

}


int OrderCloseAll(int mgc){

//////////////////////////////////////////////
// Order Hedge Close
//////////////////////////////////////////////
if ( order_hedge_close == true ) {
int totals = OrdersTotal();
  for(int is=totals-1;is>=0;is--)
  {
OrderHedgeClose(mgc);
}
}
//////////////////////////////////////////////





int coms = 0;


  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    
    //Print(OrderTicket());

   //if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 )  ) {
   if ( OrderSymbol() == Symbol() && OrderMagicNumber() == mgc //&& Symbol() == OrderSymbol() //xx
    ) {
   

///////////////////////////////////////////////////////////////////////////////////   
// Grafik Temizleme
///////////////////////////////////////////////////////////////////////////////////   
   if ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) {
   
string name=OrderTicket()+"BUY-TP";
ObjectDelete(ChartID(),name);
name=OrderTicket()+"SELL-TP";
ObjectDelete(ChartID(),name);
ObjectDelete(ChartID(),OrderTicket()+"Hedge");   
   
   }   
///////////////////////////////////////////////////////////////////////////////////   
   
   
   if ( OrderType() < 2 ) OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
   if ( OrderType() >= 2 ) OrderDelete(OrderTicket(),clrNONE);
   

   
   coms = coms +1;

 }
 }
 
 //Print("Live:",coms);
 //////////////////////////////////////////////////////////
 if ( active_magic_buy == mgc ) active_magic_buy=-1;
 if ( active_magic_sell == mgc ) active_magic_sell=-1;
 if ( active_magic_buy == mgc ) ObjectSetString(ChartID(),"BilgiBuy",OBJPROP_TEXT,"Bilgiler Buy");
 if ( active_magic_sell == mgc ) ObjectSetString(ChartID(),"BilgiSell",OBJPROP_TEXT,"Bilgiler Sell");
 //////////////////////////////////////////////////////////
return coms;
};
/////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////
void HedgeEngine() {
/*
if ( hedge_engine_turbo == true ) {
HedgeEngineTurbo();
return;}*/


if ( OrdersTotal() == 0 ) return;


if ( hedge_engine == false ) return;

//Print(Symbol()+"Hedge Engine");
//Print(Symbol()+"Hedge Engine Ananı Sikiyim");



int mgc=0;
int toplam_order=0;
bool find=false;
//if ( Orders < OrdersTotal() ) {

for ( int m=1;m<100;m++) {

//////////////////////////////////////////////////////////////////////
if ( m == active_magic_buy || m == active_magic_sell ) {
// Ekranda Seçili Olanlar
} else {
continue;
}
//////////////////////////////////////////////////////////////////////

//int sell_limit_levels=OrderCommetlive("LONG-",Symbol(),OP_SELLLIMIT,m);
//int buy_limit_levels=OrderCommetlive("SHORT-",Symbol(),OP_BUYLIMIT,m);




/*
find=false;

   string txt;
   double OCP;

          for(int i=0; i<OrdersTotal(); i++) {
        if (OrderSelect(i, SELECT_BY_POS)) {

    if ( OrderSymbol() == Symbol() && OrderMagicNumber() == m && OrderMagicNumber() != 0 && find == false && ( OrderType() == OP_BUYLIMIT || OrderType() == OP_SELLLIMIT ) ) {    
    
    //Print(OrderTicket());
      

mgc=OrderMagicNumber();*/


mgc=m;



///////////////////////////////////////////////
// BUY MODE
//////////////////////////////////////////////
//if ( OrderType() == OP_SELLLIMIT ) {
if ( m == active_magic_buy ) {
///if ( m == active_magic_buy && sell_limit_levels == 1 ) {


int buy_live_levels=OrderCommetlive("",Symbol(),OP_BUY,m);

if ( buy_live_levels == 0 ) {
Print(Symbol()+" Buy Hedge Başlangıç İşlemi Yok");
return;}

int sell_live_levels=OrderCommetlive("",Symbol(),OP_SELL,m);

int sell_stop_levels=OrderCommetlive("",Symbol(),OP_SELLSTOP,m);
int buy_stop_levels=OrderCommetlive("",Symbol(),OP_BUYSTOP,m);


//Comment("BUY MODE: buy_live_levels",buy_live_levels,"/ sell_live_levels",sell_live_levels,"/sell_stop_levels",sell_stop_levels,"/buy_stop_levels",buy_stop_levels);


double buy_price;
double sell_price;


buy_price=OrderTotalPrice(OP_BUY,Symbol(),m,"OP");
sell_price=OrderTotalPrice(OP_SELL,Symbol(),m,"OP");
buy_tps=OrderTotalPrice(OP_BUY,Symbol(),m,"TP");
sell_tps=OrderTotalPrice(OP_SELL,Symbol(),m,"TP");

if ( sell_price == 0 ) {
sell_price=OrderTotalPrice(OP_SELLSTOP,Symbol(),m,"OP");
sell_tps=OrderTotalPrice(OP_SELLSTOP,Symbol(),m,"TP");
}

if ( sell_price == 0 && takeprofit_mode == true ) {

sell_price = buy_price-(buy_tps-buy_price)/carpan;
sell_tps = buy_price-(buy_tps-buy_price)*(carpan+1);

}

if ( sell_price == 0 && takeprofit_mode == false ) {
sell_price=buy_price-distance_pip;
}



//Comment("Buy Price:",buy_price,"/ Sell Price:",sell_price,"/ Buy Tp:",buy_tps," / Sell Tp:",sell_tps);

Comment("BUY MODE: buy_live_levels",buy_live_levels,"/ sell_live_levels",sell_live_levels,"/sell_stop_levels",sell_stop_levels,"/buy_stop_levels",buy_stop_levels,"\n Buy Price:",buy_price,"/ Sell Price:",sell_price,"/ Buy Tp:",buy_tps," / Sell Tp:",sell_tps);

/////////////////////////////////////////
if ( buy_live_levels == 0 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 0  )  {
buy_level=1;
double lot_carpan=1;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 1-0
/////////////////////////////////////////
if ( buy_live_levels == 1 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 0  )  {
sell_level=1;
double lot_carpan=2;
if ( hedge_engine_turbo ) lot_carpan=3;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 1-1
//////////////////////////////////////////
if ( buy_live_levels == 1 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 1  )  {
buy_level=2;
double lot_carpan=4;
if ( hedge_engine_turbo ) lot_carpan=9;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 2-1
/////////////////////////////////////////
if ( buy_live_levels == 2 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 1  )  {
sell_level=2;
double lot_carpan=8;
if ( hedge_engine_turbo ) lot_carpan=27;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 2-2
/////////////////////////////////////////
if ( buy_live_levels == 2 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 2  )  {
buy_level=3;
double lot_carpan=16;
if ( hedge_engine_turbo ) lot_carpan=81;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 3-2
/////////////////////////////////////////
if ( buy_live_levels == 3 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 2  )  {
sell_level=3;
double lot_carpan=32;
if ( hedge_engine_turbo ) lot_carpan=243;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}


// 3-3
/////////////////////////////////////////
if ( buy_live_levels == 3 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 3  )  {
buy_level=4;
double lot_carpan=64;
if ( hedge_engine_turbo ) lot_carpan=729;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 4-3
/////////////////////////////////////////
if ( buy_live_levels == 4 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 3  )  {
sell_level=4;
double lot_carpan=128;
if ( hedge_engine_turbo ) lot_carpan=3;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}


// 4-4
/////////////////////////////////////////
if ( buy_live_levels == 4 && buy_stop_levels == 0 && sell_stop_levels == 0 && sell_live_levels == 4  )  {
buy_level=5;
double lot_carpan=256;
if ( hedge_engine_turbo ) lot_carpan=6561;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}




}
///////////////////////////////////////////////
// SELL MODE
//////////////////////////////////////////////
//if ( OrderType() == OP_BUYLIMIT ) {
if ( m == active_magic_sell ) {
//if ( m == active_magic_sell && buy_limit_levels == 1 ) {

int sell_live_levels=OrderCommetlive("",Symbol(),OP_SELL,m);

if ( sell_live_levels == 0 ) {
Print(Symbol()+" Sell Hedge Başlangıç İşlemi Yok");
return;}


int buy_live_levels=OrderCommetlive("",Symbol(),OP_BUY,m);

int sell_stop_levels=OrderCommetlive("",Symbol(),OP_SELLSTOP,m);
int buy_stop_levels=OrderCommetlive("",Symbol(),OP_BUYSTOP,m);



Print("Sell Mode");

//Comment("SELL MODE: buy_live_levels",buy_live_levels,"/ sell_live_levels",sell_live_levels,"/sell_stop_levels",sell_stop_levels,"/buy_stop_levels",buy_stop_levels);




double buy_price;
double sell_price;

buy_price=OrderTotalPrice(OP_BUY,Symbol(),m,"OP");
sell_price=OrderTotalPrice(OP_SELL,Symbol(),m,"OP");
buy_tps=OrderTotalPrice(OP_BUY,Symbol(),m,"TP");
sell_tps=OrderTotalPrice(OP_SELL,Symbol(),m,"TP");

if ( buy_price == 0 ) {
buy_price=OrderTotalPrice(OP_BUYSTOP,Symbol(),m,"OP");
buy_tps=OrderTotalPrice(OP_BUYSTOP,Symbol(),m,"TP");
}

if ( buy_price == 0 && takeprofit_mode == true ) {
buy_price = sell_price+(sell_price-sell_tps)/carpan;
buy_tps = sell_price+(sell_price-sell_tps)*(carpan+1);
}

if ( buy_price == 0 && takeprofit_mode == false ) {
buy_price=sell_price+distance_pip;
}




//Comment("Buy Price:",buy_price,"/ Sell Price:",sell_price,"/ Buy Tp:",buy_tps," / Sell Tp:",sell_tps);

Comment("Sell MODE: buy_live_levels",buy_live_levels,"/ sell_live_levels",sell_live_levels,"/sell_stop_levels",sell_stop_levels,"/buy_stop_levels",buy_stop_levels,"\n Buy Price:",buy_price,"/ Sell Price:",sell_price,"/ Buy Tp:",buy_tps," / Sell Tp:",sell_tps);



// 0-0
/////////////////////////////////////////
if ( sell_live_levels == 0 && sell_stop_levels == 0 && buy_stop_levels == 0 && buy_live_levels == 0  )  {
sell_level=1;
double lot_carpan=1;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 1-0
/////////////////////////////////////////
if ( sell_live_levels == 1 && sell_stop_levels == 0 && buy_stop_levels == 0 && buy_live_levels == 0  )  {
buy_level=1;
double lot_carpan=2;
if ( hedge_engine_turbo ) lot_carpan=3;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 1-1
//////////////////////////////////////////
if ( sell_live_levels == 1 && sell_stop_levels == 0 && buy_stop_levels == 0 && buy_live_levels == 1  )  {
sell_level=2;
double lot_carpan=4;
if ( hedge_engine_turbo ) lot_carpan=9;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 2-1
/////////////////////////////////////////
if ( sell_live_levels == 2 && sell_stop_levels == 0 && buy_live_levels == 1  && buy_stop_levels == 0 )  {
buy_level=2;
double lot_carpan=8;
if ( hedge_engine_turbo ) lot_carpan=27;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 2-2
/////////////////////////////////////////
if ( sell_live_levels == 2 && sell_stop_levels == 0 && buy_stop_levels == 0 && buy_live_levels == 2  )  {
sell_level=3;
double lot_carpan=16;
if ( hedge_engine_turbo ) lot_carpan=81;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);

}

// 3-2
/////////////////////////////////////////
if ( sell_live_levels == 3 && sell_stop_levels == 0 && buy_live_levels == 2 && buy_stop_levels == 0 )  {
buy_level=3;
double lot_carpan=32;
if ( hedge_engine_turbo ) lot_carpan=243;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 3-3
/////////////////////////////////////////
if ( sell_live_levels == 3 && sell_stop_levels == 0 && buy_stop_levels == 0 && buy_live_levels == 3  )  {
sell_level=4;
int lot_carpan=64;
if ( hedge_engine_turbo ) lot_carpan=729;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);

}

// 4-3
/////////////////////////////////////////
if ( sell_live_levels == 4 && sell_stop_levels == 0 && buy_live_levels == 3 && buy_stop_levels == 0 )  {
buy_level=4;
double lot_carpan=128;
if ( hedge_engine_turbo ) lot_carpan=2187;
string hcmt="BUY-"+buy_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,buy_tps+levels_expand[buy_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_BUYSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_BUYSTOP,Lot*lot_carpan,NormalizeDouble(buy_price+levels_expand[buy_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}

// 4-4
/////////////////////////////////////////
if ( sell_live_levels == 4 && sell_stop_levels == 0 && buy_stop_levels == 0 && buy_live_levels == 4  )  {
sell_level=5;
int lot_carpan=256;
if ( hedge_engine_turbo ) lot_carpan=6561;
string hcmt="SELL-"+sell_level;
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == true ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,sell_tps-levels_expand[sell_level],hcmt,mgc,0,clrNONE);
if ( OrderCommetlive(hcmt,Symbol(),OP_SELLSTOP,mgc) == 0 && takeprofit_mode == false ) OrderSend(Symbol(),OP_SELLSTOP,Lot*lot_carpan,NormalizeDouble(sell_price-levels_expand[sell_level],MarketInfo(Symbol(),MODE_DIGITS)),0,0,0,hcmt,mgc,0,clrNONE);
}



}
//////////////////////////////////////////////







   // }

                
   //}
   
//}

}


}


/*
///////////////////////////////////////////////////////////////////////
/// QUICK TRADE ENGINE
///////////////////////////////////////////////////////////////////////

void QuickTrade() {

int buy_mgc=FindMgclive("BUY-0",Symbol(),OP_BUY);
int sell_mgc=FindMgclive("SELL-0",Symbol(),OP_SELL);

int sellp_mgc=FindMgclive("SELLP-0",Symbol(),OP_SELL);
int buyp_mgc=FindMgclive("BUYP-0",Symbol(),OP_BUY);



}
*/



 //////////////////////////////////////////////
// Bekleyen Emirlerden Olusan String Olusturur
///////////////////////////////////////////////
int FindMgclive(string cmt,string sym,int typ){

int coms = -1;


//if ( free_mode == true ) cmt="";


  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS);
           int type = OrderType();
    string comments = OrderComment();
    
    //Print(OrderTicket());|| ( free_mode==true && cmt=="")

   //if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt  ) && OrderSymbol() == sym && type == typ  ) {   
   if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt  ) && OrderSymbol() == sym && type == typ && OrderMagicNumber() != 0 ) {   
   coms=OrderMagicNumber();
 }
 }
 
  
 //Print("Live:",coms);
 
return coms;
};



//////////////////////////////////////////////
// Quick Trade Engine void quicktr
///////////////////////////////////////////////
void QTEngine(){

//Print("QTEngine");

//double mgc_profit=0;//OrderMgcTotalProfit(OrderSymbol(),OrderMagicNumber());




for ( int m=1;m<100;m++) {

//////////////////////////////////////////////////////////////////////
if ( m == active_magic_buy || m == active_magic_sell ) {
// Ekranda Seçili Olanlar
} else {
continue;
}
//////////////////////////////////////////////////////////////////////


//Print("QTEngine",m);

string sym="";
double mgc_profit=0;
int magic_number=0;

int buy_total=0;
int sell_total=0;

int buystop_total=0;
int sellstop_total=0;

double buystop_open_price=0;
double sellstop_open_price=0;


//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   
          for(int ix=0; ix<OrdersTotal(); ix++) {
        if (OrderSelect(ix, SELECT_BY_POS, MODE_TRADES)) {

//OrderSymbol() == sym &&
    if (  OrderMagicNumber() == m  && OrderSymbol() == Symbol()    ) {    //xx   
    mgc_profit=mgc_profit+OrderProfit();
    magic_number=m;
    sym=OrderSymbol();
    
    if ( OrderType() == OP_BUY ) buy_total=buy_total+1;
    if ( OrderType() == OP_SELL ) sell_total=sell_total+1;
    
    if ( OrderType() == OP_BUYSTOP ) {buystop_total=buystop_total+1;buystop_open_price=OrderOpenPrice();}
    if ( OrderType() == OP_SELLSTOP ) {sellstop_total=sellstop_total+1;sellstop_open_price=OrderOpenPrice();}
    
    
    }

  
              
   }
   
}


if ( (buy_total == 1 && sell_total==0) || (sell_total == 1 && buy_total == 0) ) {} else { continue;}


if ( mgc_profit < 0 ) continue;




/*
if ( (buy_total == 1 && (sell_total == 0 || sell_total == 1)) || (sell_total == 1 && (buy_total == 0 || buy_total == 1))  ) {} else {
continue;
}*/


int coms = 0;

string cmt="-0";

//if ( free_mode == true ) cmt="";


  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
           int type = OrderType();
    string comments = OrderComment();
    
    
    if ( OrderMagicNumber() != magic_number ) continue;
    if ( sym != OrderSymbol() ) continue;
    
    //double mgc_profit=0;//OrderMgcTotalProfit(OrderSymbol(),OrderMagicNumber());
    
    //Comment(OrderTicket(),"/",OrdersTotal(),"/",OrderProfit());
    
    
    //Comment(OrderMagicNumber(),"/",mgc_profit,"$");
    
/*
   bool spreadfloat=SymbolInfoInteger(Symbol(),SYMBOL_SPREAD_FLOAT);
   string comm=StringFormat("Spread %s = %I64d points\r\n",
                            spreadfloat?"floating":"fixed",
                            SymbolInfoInteger(Symbol(),SYMBOL_SPREAD));
//--- now let's calculate the spread by ourselves
   double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   double spread=ask-bid;
   int spread_points=(int)MathRound(spread/SymbolInfoDouble(Symbol(),SYMBOL_POINT));
   comm=comm+"Calculated spread = "+(string)spread_points+" points";
   Comment(comm);*/
   
   

    //StringFind(comments,cmt,0) != -1 &&&&  OrderMagicNumber() > 0&& mgc_profit > 0OrderStopLoss() == 0.0 && OrderTakeProfit() != 0.0 
    
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TakeProfit Mode
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
if ( takeprofit_mode == false ) {   
 
    if ( OrderStopLoss() == 0 && OrderTakeProfit() == 0  && OrderProfit() > 0 && StringFind(comments,cmt,0) != -1 && OrderMagicNumber() == magic_number ) {
        
        
        
        
        int shift = iBarShift(Symbol(),Period(),OrderOpenTime());
        
    /*if ( mgc_profit > 0 ) {
    Comment(OrderMagicNumber(),"/",mgc_profit,"$",OrderTicket());
    }  */     

    
    if ( OrderType() == OP_BUY ) {
    
    

    double hesap=(OrderOpenPrice()-sellstop_open_price);
    double yuzde=hesap/100;
    double profit_price=OrderOpenPrice()+(yuzde*quick_trade_yuzde);
    
    Comment("Buy",OrderMagicNumber(),"/",mgc_profit,"$ Pip :",int((profit_price-Bid)/Point)+" profit_price:"+DoubleToString(profit_price,Digits),"/ Profit:",OrderProfit(),"$");
    
    string name=OrderTicket()+"QuickTradeBuyProfitPrice";
    //if ( ObjectFind(name) == -1 ) {
    ObjectDelete(ChartID(),name);
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift],profit_price,Time[shift]+500*PeriodSeconds(),profit_price);  
    //}  
    
    
    if ( OrderClosePrice() - OrderOpenPrice() >= (yuzde*quick_trade_yuzde) ) {    
    OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
    OrderCloseAll(OrderMagicNumber());
    ////////////////////////////////////////
    auto_profit_close=true;
    hedge_engine=true;
    quick_trade=false;
    ////////////////////////////////////////
    }    
    
    }
    

    if ( OrderType() == OP_SELL ) {

    double hesap=(buystop_open_price-OrderOpenPrice());
    double yuzde=hesap/100;
    double profit_price=OrderOpenPrice()-(yuzde*quick_trade_yuzde);

    Comment("SELL",OrderMagicNumber(),"/",mgc_profit,"$ Pip:",int((Ask-profit_price)/Point)+"  profit_price:"+DoubleToString(profit_price,Digits),"/ Profit:",OrderProfit(),"$");
    /*string name=OrderTicket()+"QuickTrade";
    if ( ObjectFind(name) == -1 ) {
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift],profit_price,Time[shift]+500*PeriodSeconds(),profit_price);
    }   */
       
    string name=OrderTicket()+"QuickTradeSellProfitPrice";
    //if ( ObjectFind(name) == -1 ) {
    ObjectDelete(ChartID(),name);
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift],profit_price,Time[shift]+500*PeriodSeconds(),profit_price);  
    //}    
           
       
    
    if ( OrderOpenPrice()-OrderClosePrice() >= (yuzde*quick_trade_yuzde) ) {    
    OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
    OrderCloseAll(OrderMagicNumber());
    ////////////////////////////////////////
    auto_profit_close=true;
    hedge_engine=true;
    quick_trade=false;
    ////////////////////////////////////////    
    }    
    
    }
       
       
       
           
        
    
    }
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// TakeProfit Mode
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    
if ( takeprofit_mode == true ) {   
 
    if ( OrderStopLoss() == 0 && OrderTakeProfit() != 0  && OrderProfit() > 0 && StringFind(comments,cmt,0) != -1 && OrderMagicNumber() == magic_number ) {
        
        
        
        
        int shift = iBarShift(Symbol(),Period(),OrderOpenTime());
        
    /*if ( mgc_profit > 0 ) {
    Comment(OrderMagicNumber(),"/",mgc_profit,"$",OrderTicket());
    }  */     

    
    if ( OrderType() == OP_BUY ) {
    
    

    double hesap=(OrderTakeProfit()-OrderOpenPrice())/carpan;
    double yuzde=hesap/100;
    double profit_price=OrderOpenPrice()+(yuzde*quick_trade_yuzde);
    
    Comment("Buy",OrderMagicNumber(),"/",mgc_profit,"$ Pip :",int((profit_price-Bid)/Point)+" profit_price:"+DoubleToString(profit_price,Digits),"/ Profit:",OrderProfit(),"$");
    
    string name=OrderTicket()+"QuickTradeBuyProfitPrice";
    //if ( ObjectFind(name) == -1 ) {
    ObjectDelete(ChartID(),name);
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift],profit_price,Time[shift]+500*PeriodSeconds(),profit_price);  
    //}  
    
    
    if ( OrderClosePrice() - OrderOpenPrice() >= (yuzde*quick_trade_yuzde) ) {    
    OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
    OrderCloseAll(OrderMagicNumber());
    ////////////////////////////////////////
    auto_profit_close=true;
    hedge_engine=true;
    quick_trade=false;
    ////////////////////////////////////////
    }    
    
    }
    

    if ( OrderType() == OP_SELL ) {
    
    
    
    double hesap=(OrderOpenPrice()-OrderTakeProfit())/carpan;
    double yuzde=hesap/100;
    double profit_price=OrderOpenPrice()-(yuzde*quick_trade_yuzde);

    Comment("SELL",OrderMagicNumber(),"/",mgc_profit,"$ Pip:",int((Ask-profit_price)/Point)+"  profit_price:"+DoubleToString(profit_price,Digits),"/ Profit:",OrderProfit(),"$");
    /*string name=OrderTicket()+"QuickTrade";
    if ( ObjectFind(name) == -1 ) {
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift],profit_price,Time[shift]+500*PeriodSeconds(),profit_price);
    }   */
       
    string name=OrderTicket()+"QuickTradeSellProfitPrice";
    //if ( ObjectFind(name) == -1 ) {
    ObjectDelete(ChartID(),name);
    ObjectCreate(ChartID(),name,OBJ_TREND,0,Time[shift],profit_price,Time[shift]+500*PeriodSeconds(),profit_price);  
    //}    
           
       
    
    if ( OrderOpenPrice()-OrderClosePrice() >= (yuzde*quick_trade_yuzde) ) {    
    OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
    OrderCloseAll(OrderMagicNumber());
    ////////////////////////////////////////
    auto_profit_close=true;
    hedge_engine=true;
    quick_trade=false;
    ////////////////////////////////////////    
    }    
    
    }
       
       
       
           
        
    
    }
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    
    //Print(OrderTicket());|| ( free_mode==true && cmt=="")

   /*if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt  ) && OrderSymbol() == sym && type == typ  ) {   
   coms=OrderMagicNumber();
 }*/
 }
 
  
 //Print("Live:",coms);
 
 
 
 }

};

/*
///////////////////////////////////////////////////////////////////////  
// SYMBOL PROFIT MGC
/////////////////////////////////////////////////////////////////////// 
double OrderMgcTotalProfit(string sym,int mgc)
{

double profits=0;

//if ( Orders < OrdersTotal() ) {

   string txt;
   double OCP;
   //int TYP;
   
          for(int ix=0; ix<OrdersTotal(); ix++) {
        if (OrderSelect(ix, SELECT_BY_POS, MODE_TRADES)) {


    if ( OrderSymbol() == sym && OrderMagicNumber() == mgc) {      
    profits=profits+OrderProfit();
    }

  
              
   }
   
}

return profits;

}
*/

string TFtoStr(int period) {

string demo="";

if (IsDemo()) demo="DEMO ";


 switch(period) {
  case 1     : return(demo+"M1");  break;
  case 5     : return(demo+"M5");  break;
  case 15    : return(demo+"M15"); break;
  case 30    : return(demo+"M30"); break;
  case 60    : return(demo+"H1");  break;
  case 240   : return(demo+"H4");  break;
  case 1440  : return(demo+"D1");  break;
  case 10080 : return(demo+"W1");  break;
  case 43200 : return(demo+"MN1"); break;
  default    : return(DoubleToStr(period,0));
 }
 
 
 return("UNKNOWN");
}

void FindLineMagicNumber() {
//Alert("w");
string obj_text;
string obj_tool;


  int obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     //Print(i," object - ",name);
     
          obj_text = ObjectGetString(ChartID(),name,OBJPROP_TEXT);
          obj_tool = ObjectGetString(ChartID(),name,OBJPROP_TOOLTIP);  
          
if ( ObjectType(name) == OBJ_HLINE ) {


if ( obj_text != "" ) {

int omgc=StringToInteger(obj_text);
             
if ( StringFind(name,"BUYSTOP",0) != -1 ) active_magic_buy=omgc;
if ( StringFind(name,"SELLSTOP",0) != -1 ) active_magic_sell=omgc;

}
               
               }
     
     
     
     
    }
    
    Comment("active_magic_buy:",active_magic_buy,"/active_magic_sell:",active_magic_sell);

}

void FindLineTp() {

if ( takeprofit_mode == false ) {
active_magic_buy_tp=0;
active_magic_sell_tp=0;
return;
}

//Alert("w");
string obj_text;
string obj_tool;


  int obj_total=ObjectsTotal();
  string name;
  for(int i=0;i<obj_total;i++)
    {
     name = ObjectName(i);
     //Print(i," object - ",name);
     
          obj_text = ObjectGetString(ChartID(),name,OBJPROP_TEXT);
          obj_tool = ObjectGetString(ChartID(),name,OBJPROP_TOOLTIP);  
          
if ( ObjectType(name) == OBJ_HLINE ) {


if ( obj_text != "" ) {

double otp=StringToDouble(obj_text);
int omgc=StringToDouble(obj_tool);
             
if ( StringFind(name,"BUYTPSTOP",0) != -1 && active_magic_buy == omgc )  active_magic_buy_tp=otp;
if ( StringFind(name,"SELLTPSTOP",0) != -1 && active_magic_sell == omgc ) active_magic_sell_tp=otp;

}
               
               }
     
     
     
     
    }
    
    
    Comment("active_magic_buy_tp:",active_magic_buy_tp,"/active_magic_sell_tp:",active_magic_sell_tp);
    if ( active_magic_buy_tp != 0.0 || active_magic_sell_tp != 0.0 )  Alert("active_magic_buy_tp:",active_magic_buy_tp,"/active_magic_sell_tp:",active_magic_sell_tp);

}

double active_magic_buy_tp;
double active_magic_sell_tp;


//////////////////////////////////////////////////////////////////////////
// Hedge Close
///////////////////////////////////////////////////////////////////////////
int OrderHedgeClose(int mgc){


int total = OrdersTotal();

string order_list="";

double last_high_profit_order=-1;
double last_low_profit_order=-1;
int last_high_ticket_order;
int last_low_ticket_order;
int coms = -1;

  
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
           int type = OrderType();
    string comments = OrderComment();
    
    //Print(OrderTicket());

   //if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 )  ) {
   if ( OrderSymbol() == Symbol() && OrderMagicNumber() == mgc //&& Symbol() == OrderSymbol() //xx
    ) {
   

///////////////////////////////////////////////////////////////////////////////////   
// Grafik Temizleme
///////////////////////////////////////////////////////////////////////////////////   
   if ( OrderType() == OP_BUY || OrderType() == OP_SELL ) {
   
   //if ( OrderType() == OP_BUY )order_list=order_list+"\n"+OrderTicket()+" BUY Lot:+"+OrderLots()+" Profit:"+OrderProfit();
   //if ( OrderType() == OP_SELL )order_list=order_list+"\n"+OrderTicket()+" SELL Lot:+"+OrderLots()+" Profit:"+OrderProfit();
   coms = coms +1;
   
   if ( last_high_profit_order==-1 && last_low_profit_order == -1 ) {
   last_high_profit_order=OrderProfit();
   last_high_ticket_order=OrderTicket();   
   last_low_profit_order=OrderProfit();
   last_low_ticket_order=OrderTicket();   
   }
   
   if ( OrderProfit() > last_high_profit_order ) {
   last_high_profit_order=OrderProfit();
   last_high_ticket_order=OrderTicket();
   }

   if ( OrderProfit() < last_low_profit_order ) {
   last_low_profit_order=OrderProfit();
   last_low_ticket_order=OrderTicket();
   }
   


   }   
///////////////////////////////////////////////////////////////////////////////////   
   


   
   

 } 
 }
 
 
 
 //order_list=order_list+"\n -------------------------------------------------------";
 order_list=order_list+"\n Last High Order:"+last_high_profit_order+"$ Ticket:"+last_high_ticket_order;
 order_list=order_list+"\n -------------------------------------------------------";

 //order_list=order_list+"\n -------------------------------------------------------";
 order_list=order_list+"\n Last Low Order:"+last_low_profit_order+"$ Ticket:"+last_low_ticket_order;
 
 
 OrderCloseTickets(last_high_ticket_order);
 Sleep(100);
 OrderCloseTickets(last_low_ticket_order);
 
 
 Print(coms+"OrderList:",order_list);
 
 
 
 
 return 0;
 
 
 }
//////////////////////////////////////////////////////////////////////////////////////////// 
// Close Ticket
//////////////////////////////////////////////////////////////////////////////////////////// 
int OrderCloseTickets(int tickets){

int coms = 0;


  int total = OrdersTotal();
  for(int i=total-1;i>=0;i--)
  {
    OrderSelect(i, SELECT_BY_POS,MODE_TRADES);
           int type = OrderType();
    string comments = OrderComment();
    
    //Print(OrderTicket());

   //if ( ( StringFind(comments,cmt,0) != -1 ||  comments == cmt ) && OrderSymbol() == sym && type == typ && (OrderMagicNumber() == mgc || mgc == -1 )  ) {
   if ( OrderSymbol() == Symbol() && OrderTicket() == tickets //&& Symbol() == OrderSymbol() //xx
    ) {
    
    if ( OrderType() < 2 ) OrderClose(OrderTicket(),OrderLots(),OrderClosePrice(),0,clrNONE);
   


   
   coms = coms +1;

 }
 }
 

return coms;
};
///////////////////////////////////////////////////////////////////////////////////////// 

/////////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////

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
        avarage=avarage_total/islem_sayisi;
        
        avarage_buy=avarage_total_buy/islem_sayisi_buy;
        avarage_sell=avarage_total_sell/islem_sayisi_sell;
        
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////
// AUTO HEDGE ENGINE
//////////////////////////////////////////////////////////////////////////////////////////////////////////
bool low_mode=false;
bool high_mode=false;
datetime last_time=Time[0];
bool order=false;
void AutoHedgeEngine() {


if ( auto_hedge == false ) return;

int ttc = Time[0] + Period()*60 - TimeCurrent();
Comment("Auto Hedge Zaman:"+Time[0]+"\nKalan Süre:"+ttc);

if ( last_time != Time[0] ) {
last_time=Time[0];
} else {
return;
}



wpm=WindowPriceMax();
wpl=WindowPriceMin();

int wpm_pips=(wpm-Bid)/Point;
int wpl_pips=(Bid-wpl)/Point;

if ( wpm-Bid < Bid-wpl ) {high_mode=true;low_mode=false;} else {high_mode=false;low_mode=true;}

ObjectCreate(ChartID(),"WPC",OBJ_HLINE,0,Time[0],wpl+((wpm-wpl)/2));
ObjectSetInteger(ChartID(),"WPC",OBJPROP_COLOR,clrDarkGray);  

bool yuzde_false=false;
bool yuzde_true=true;
bool spread_false=false;
bool spread_true=true;

double price_sl=CandleSpikePrice(1,25,yuzde_true,spread_true);

   ObjectDelete(ChartID(),"HLINEPSL");
   ObjectCreate(ChartID(),"HLINEPSL",OBJ_HLINE,0,Time[1],price_sl);
   ObjectSetInteger(ChartID(),"HLINEPSL",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartID(),"HLINEPSL",OBJPROP_COLOR,clrWhite);   
   ObjectSetInteger(ChartID(),"HLINEPSL",OBJPROP_STYLE,STYLE_DOT);   



if ( order == false && low_mode == true ) {




//if ( OrderCommetlive("",Symbol(),OP_BUY,0) == 0 ) OrderSend(Symbol(),OP_BUY,0.01,Ask,0,Bid-pips*Point,0,NULL,0,0,clrNONE);
//if ( OrderCommetlive("",Symbol(),OP_BUY,0) == 0 && SpikeCheck(1,"LOW") == true ) {
if ( SpikeCheck(1,"LOW") == true ) {

//if ( low_mode == true ) {
pips=(Bid-price_sl)/Point;
//}

//////////////////////////////////////////////////////////////////////////////////////
/// SELL LIMIT = BUY
//////////////////////////////////////////////////////////////////////////////////////
int sell_limit_levels=OrderCommetlive("LONG-"+active_magic_buy,Symbol(),OP_SELLLIMIT,active_magic_buy);

if ( sell_limit_levels > 0 ) return;
//////////////////////////////////////////////////////////////////////////////////////////


order_type=OP_BUY;

wpm=WindowPriceMax();
wpl=WindowPriceMin();

fmgc=FreeMgc();
//ticket=OrderSend(Symbol(),OP_BUYSTOP,MarketInfo(Symbol(),MODE_MAXLOT),wpm,0,wpm-100*Point,0,"LONG-"+fmgc,fmgc,0,clrNONE);
ticket=OrderSend(Symbol(),OP_SELLLIMIT,MarketInfo(Symbol(),MODE_MAXLOT),wpm,0,0,wpm-pips*Point,"LONG-"+fmgc,fmgc,0,clrNONE);
ObjectCreate(ChartID(),"BUYSTOP"+ticket,OBJ_HLINE,0,Time[0],wpm);
ObjectSetString(ChartID(),"BUYSTOP"+ticket,OBJPROP_TOOLTIP,ticket);
ObjectSetInteger(ChartID(),"BUYSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"BUYSTOP"+ticket,OBJPROP_COLOR,clrChartreuse);
ObjectSetString(ChartID(),"BUYSTOP"+ticket,OBJPROP_TEXT,fmgc);

active_magic_buy=fmgc;

order=true;

AlertOrder();

auto_hedge=false;

//OrderSend(Symbol(),OP_BUY,0.01,Ask,0,price_sl,Ask+(pips*rr)*Point,NULL,0,0,clrNONE);

/*
ObjectDelete(ChartID(),"TPBUY");
ObjectCreate(ChartID(),"TPBUY",OBJ_RECTANGLE,0,Time[50],Ask,Time[0],Ask+(pips*rr)*Point);
ObjectSetInteger(ChartID(),"TPBUY",OBJPROP_COLOR,clrBlue);  */ 

}
}

if ( order == false && high_mode == true ) {



//if ( OrderCommetlive("",Symbol(),OP_SELL,0) == 0 ) OrderSend(Symbol(),OP_SELL,0.01,Bid,0,Ask+pips*Point,0,NULL,0,0,clrNONE);
//if ( OrderCommetlive("",Symbol(),OP_SELL,0) == 0 && SpikeCheck(1,"HIGH") == true ) {
if ( SpikeCheck(1,"HIGH") == true ) {

//if ( high_mode == true ) {
pips=(price_sl-Ask)/Point;
//}


int buy_limit_levels=OrderCommetlive("SHORT-"+active_magic_sell,Symbol(),OP_BUYLIMIT,active_magic_sell);

if ( buy_limit_levels > 0 ) return;
////////////////////////////////////////////////////////////////////////////////////////


order_type=OP_SELL;

wpm=WindowPriceMax();
wpl=WindowPriceMin();

fmgc=FreeMgc();
//ticket=OrderSend(Symbol(),OP_SELLSTOP,MarketInfo(Symbol(),MODE_MAXLOT),wpl,0,wpl+100*Point,0,"SHORT"+fmgc,fmgc,0,clrNONE);
ticket=OrderSend(Symbol(),OP_BUYLIMIT,MarketInfo(Symbol(),MODE_MAXLOT),wpl,0,0,wpl+pips*Point,"SHORT-"+fmgc,fmgc,0,clrNONE);
ObjectCreate(ChartID(),"SELLSTOP"+ticket,OBJ_HLINE,0,Time[0],wpl);
ObjectSetString(ChartID(),"SELLSTOP"+ticket,OBJPROP_TOOLTIP,ticket);
ObjectSetInteger(ChartID(),"SELLSTOP"+ticket,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),"SELLSTOP"+ticket,OBJPROP_COLOR,clrChartreuse);
ObjectSetString(ChartID(),"SELLSTOP"+ticket,OBJPROP_TEXT,fmgc);

active_magic_sell=fmgc;

order=true;

AlertOrder();

auto_hedge=false;


///OrderSend(Symbol(),OP_SELL,0.01,Bid,0,price_sl,Bid-(pips*rr)*Point,NULL,0,0,clrNONE);

/*
ObjectDelete(ChartID(),"TPSELL");
ObjectCreate(ChartID(),"TPSELL",OBJ_RECTANGLE,0,Time[50],Ask,Time[0],Bid-(pips*rr)*Point);
ObjectSetInteger(ChartID(),"TPSELL",OBJPROP_COLOR,clrRed);*/   

}
}




}



double CandleSpikePrice(int sb,int yuz,bool sw,bool yz) {

int pipss=0;
int pipsl=0;
int pipspread=0;
int pipslw=0;
int pipyuzde=0;

double price=0;

double sl_price=0;
double sl_price_yuzde=0;
double sl_price_spread=0;
double sl_price_yuzde_spread=0;




   ObjectDelete(ChartID(),"VLINE");
   ObjectCreate(ChartID(),"VLINE",OBJ_VLINE,0,Time[sb],Ask);
   ObjectSetInteger(ChartID(),"VLINE",OBJPROP_BACK,true);

/*
   int sb=33;
   //sb=266;
   //sb=221;
   //sb=206;
   //sb=97;
   //sb=223;
   //sb=164;
   sb=1;*/


if ( high_mode == true ) {

   //////////////////////////////////////////////////////////////////////
   if ( Open[sb] > Close[sb] ) {

   ObjectDelete(ChartID(),"HLINES");
   ObjectCreate(ChartID(),"HLINES",OBJ_HLINE,0,Time[sb],Open[sb]);
   ObjectSetInteger(ChartID(),"HLINES",OBJPROP_BACK,true);
   
   ObjectDelete(ChartID(),"HLINEF");
   ObjectCreate(ChartID(),"HLINEF",OBJ_HLINE,0,Time[sb],High[sb]);
   ObjectSetInteger(ChartID(),"HLINEF",OBJPROP_BACK,true);
   
   sl_price=High[sb];
   pipss=(High[sb]-Open[sb])/Point;
   
   
   
   //double yuzde=(pipss)/100;   
   double yuzde=DivZero(pipss,100);
   
   double sl_pip=yuzde*yuz;
   double sl_price_yuzde=High[sb]+(sl_pip*Point);
   
   pipyuzde=(sl_price_yuzde-Open[sb])/Point;
   
   ObjectDelete(ChartID(),"HLINESLY");
   ObjectCreate(ChartID(),"HLINESLY",OBJ_HLINE,0,Time[sb],sl_price_yuzde);
   ObjectSetInteger(ChartID(),"HLINESLY",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartID(),"HLINESLY",OBJPROP_COLOR,clrWhite);    
   
   double spread=MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID);
   int spread_pip=spread/Point;
   
   pipspread=pipss+spread_pip;
   
   sl_price_spread=High[sb]+(spread_pip*Point);

   ObjectDelete(ChartID(),"HLINESLW");
   ObjectCreate(ChartID(),"HLINESLW",OBJ_HLINE,0,Time[sb],sl_price_spread);
   ObjectSetInteger(ChartID(),"HLINESLW",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartID(),"HLINESLW",OBJPROP_COLOR,clrBlue);     

   
   sl_price_yuzde_spread=sl_price_yuzde+(spread_pip*Point);
   
   pipslw=(sl_price_yuzde_spread-Open[sb])/Point;
   
   ObjectDelete(ChartID(),"HLINESLYW");
   ObjectCreate(ChartID(),"HLINESLYW",OBJ_HLINE,0,Time[sb],sl_price_yuzde_spread);
   ObjectSetInteger(ChartID(),"HLINESLYW",OBJPROP_BACK,true);
      
 
   //Comment("Pips:",pips,"/",spread_pip);
   
   Print("Pipss: ",pipss," pipsl: ",pipsl," pipslw: ",pipslw," pipspread:",pipspread);
   Print("Sl Price: ",price," Yuzde: ",sl_price_yuzde," Spread: ",sl_price_spread," Spread Yuzde:",sl_price_yuzde_spread);   
   }
   

   if ( Close[sb] > Open[sb]) {

   ObjectDelete(ChartID(),"HLINES");
   ObjectCreate(ChartID(),"HLINES",OBJ_HLINE,0,Time[sb],Close[sb]);
   ObjectSetInteger(ChartID(),"HLINES",OBJPROP_BACK,true);
   
   ObjectDelete(ChartID(),"HLINEF");
   ObjectCreate(ChartID(),"HLINEF",OBJ_HLINE,0,Time[sb],High[sb]);
   ObjectSetInteger(ChartID(),"HLINEF",OBJPROP_BACK,true);

   sl_price=High[sb];
   pipss=(High[sb]-Close[sb])/Point;
   
   //double yuzde=(pipss)/100;
   double yuzde=DivZero(pipss,100);
   double sl_pip=yuzde*yuz;
   sl_price_yuzde=High[sb]+(sl_pip*Point);
   
   pipyuzde=(sl_price_yuzde-Close[sb])/Point;
   
   ObjectDelete(ChartID(),"HLINESLY");
   ObjectCreate(ChartID(),"HLINESLY",OBJ_HLINE,0,Time[sb],sl_price_yuzde);
   ObjectSetInteger(ChartID(),"HLINESLY",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartID(),"HLINESLY",OBJPROP_COLOR,clrWhite);    
   
   double spread=MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID);
   int spread_pip=spread/Point;
   
   pipspread=pipss+spread_pip;
   
   sl_price_spread=High[sb]+(spread_pip*Point);

   ObjectDelete(ChartID(),"HLINESLW");
   ObjectCreate(ChartID(),"HLINESLW",OBJ_HLINE,0,Time[sb],sl_price_spread);
   ObjectSetInteger(ChartID(),"HLINESLW",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartID(),"HLINESLW",OBJPROP_COLOR,clrBlue);     
      
         
   sl_price_yuzde_spread=sl_price_yuzde+(spread_pip*Point);   
   
   pipslw=(sl_price_yuzde_spread-Close[sb])/Point;
   
   ObjectDelete(ChartID(),"HLINESLYW");
   ObjectCreate(ChartID(),"HLINESLYW",OBJ_HLINE,0,Time[sb],sl_price_yuzde_spread);
   ObjectSetInteger(ChartID(),"HLINESLYW",OBJPROP_BACK,true);
      
   
 
   
   //Comment("Pips:",pips);
   
   Print("Pipss: ",pipss," pipsl: ",pipsl," pipslw: ",pipslw," pipspread:",pipspread);
   Print("Sl Price: ",sl_price," Yuzde: ",sl_price_yuzde," Spread: ",sl_price_spread," Spread Yuzde:",sl_price_yuzde_spread);
      
   }
   ////////////////////////////////////////////////////////////////////////
   
   
   }
   
   
   
   if ( low_mode == true ) {
   //////////////////////////////////////////////////////////////////////
   if ( Open[sb] > Close[sb] ) {

   ObjectDelete(ChartID(),"HLINES");
   ObjectCreate(ChartID(),"HLINES",OBJ_HLINE,0,Time[sb],Close[sb]);
   ObjectSetInteger(ChartID(),"HLINES",OBJPROP_BACK,true);
   
   ObjectDelete(ChartID(),"HLINEF");
   ObjectCreate(ChartID(),"HLINEF",OBJ_HLINE,0,Time[sb],Low[sb]);
   ObjectSetInteger(ChartID(),"HLINEF",OBJPROP_BACK,true);

   sl_price=Low[sb];
   pipss=(Close[sb]-Low[sb])/Point;
   
   //double yuzde=(pipss)/100;
   double yuzde=DivZero(pipss,100);
   double sl_pip=yuzde*yuz;
   sl_price_yuzde=Low[sb]-(sl_pip*Point);
   
   pipyuzde=(Close[sb]-sl_price_yuzde)/Point;
   
   ObjectDelete(ChartID(),"HLINESLY");
   ObjectCreate(ChartID(),"HLINESLY",OBJ_HLINE,0,Time[sb],sl_price_yuzde);
   ObjectSetInteger(ChartID(),"HLINESLY",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartID(),"HLINESLY",OBJPROP_COLOR,clrWhite); 
   
      
   double spread=MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID);
   int spread_pip=spread/Point;
   
   sl_price_spread=Low[sb]-(spread_pip*Point);

   ObjectDelete(ChartID(),"HLINESLW");
   ObjectCreate(ChartID(),"HLINESLW",OBJ_HLINE,0,Time[sb],sl_price_spread);
   ObjectSetInteger(ChartID(),"HLINESLW",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartID(),"HLINESLW",OBJPROP_COLOR,clrBlue);  

   pipspread=pipss+spread_pip;
      
   sl_price_yuzde_spread=sl_price_yuzde-(spread_pip*Point);
   
   pipslw=(Close[sb]-sl_price_yuzde_spread)/Point;
    
   ObjectDelete(ChartID(),"HLINESLYW"); 
   ObjectCreate(ChartID(),"HLINESLYW",OBJ_HLINE,0,Time[sb],sl_price_yuzde_spread);
   ObjectSetInteger(ChartID(),"HLINESLYW",OBJPROP_BACK,true);
      
   

 
   Print("Pipss: ",pipss," pipsl: ",pipsl," pipslw: ",pipslw," pipspread:",pipspread);
   Print("Sl Price: ",sl_price," Yuzde: ",sl_price_yuzde," Spread: ",sl_price_spread," Spread Yuzde:",sl_price_yuzde_spread);   
   }
   

   if ( Close[sb] > Open[sb]) {

   ObjectDelete(ChartID(),"HLINES");
   ObjectCreate(ChartID(),"HLINES",OBJ_HLINE,0,Time[sb],Open[sb]);
   ObjectSetInteger(ChartID(),"HLINES",OBJPROP_BACK,true);
   
   ObjectDelete(ChartID(),"HLINEF");
   ObjectCreate(ChartID(),"HLINEF",OBJ_HLINE,0,Time[sb],Low[sb]);
   ObjectSetInteger(ChartID(),"HLINEF",OBJPROP_BACK,true);

   sl_price=Low[sb];
   pipss=(Open[sb]-Low[sb])/Point;
   
   //double yuzde=(pipss)/100;
   double yuzde=DivZero(pipss,100);
   double sl_pip=yuzde*yuz;
   
   sl_price_yuzde=Low[sb]-(sl_pip*Point);
   
   pipyuzde=(Close[sb]-sl_price_yuzde)/Point;
   
   ObjectDelete(ChartID(),"HLINESLY");
   ObjectCreate(ChartID(),"HLINESLY",OBJ_HLINE,0,Time[sb],sl_price_yuzde);
   ObjectSetInteger(ChartID(),"HLINESLY",OBJPROP_BACK,true);    
   ObjectSetInteger(ChartID(),"HLINESLY",OBJPROP_COLOR,clrWhite); 


   double spread=MarketInfo(Symbol(),MODE_ASK)-MarketInfo(Symbol(),MODE_BID);
   int spread_pip=spread/Point;
   
   sl_price_spread=Low[sb]-(spread_pip*Point);

   ObjectDelete(ChartID(),"HLINESLW");
   ObjectCreate(ChartID(),"HLINESLW",OBJ_HLINE,0,Time[sb],sl_price_spread);
   ObjectSetInteger(ChartID(),"HLINESLW",OBJPROP_BACK,true); 
   ObjectSetInteger(ChartID(),"HLINESLW",OBJPROP_COLOR,clrBlue);  
         
   pipspread=pipss+spread_pip;
   
   sl_price_yuzde_spread=sl_price_yuzde-(spread_pip*Point);
   
   pipslw=(Close[sb]-sl_price_yuzde_spread)/Point;
   
   ObjectDelete(ChartID(),"HLINESLYW");
   ObjectCreate(ChartID(),"HLINESLYW",OBJ_HLINE,0,Time[sb],sl_price_yuzde_spread);
   ObjectSetInteger(ChartID(),"HLINESLYW",OBJPROP_BACK,true);

   //Comment("Pips:",pips);
   
   Print("Pipss: ",pipss," pipsl: ",pipsl," pipslw: ",pipslw," pipspread:",pipspread);
   
   Print("Sl Price: ",sl_price," Yuzde: ",sl_price_yuzde," Spread: ",sl_price_spread," Spread Yuzde:",sl_price_yuzde_spread);
      
   }
   ////////////////////////////////////////////////////////////////////////
   }
   
   if ( yz == false && sw == false ) price=sl_price;
   if ( yz == true && sw == true ) price=sl_price_yuzde_spread; // Spread ve Yuzde
   if ( yz == false && sw == true ) price=sl_price_spread; // Sadece Spread
   if ( yz == true && sw == false ) price=sl_price_yuzde; // Sadece Yuzde
   
   /*//if ( yz == false && sw == false ) pipss=pipss;
   if ( yz == true && sw == true ) pipss=pipslw; // Spread ve Yuzde
   if ( yz == false && sw == true ) pipss=pipspread; // Sadece Spread
   if ( yz == true && sw == false ) pipss=pipsl; // Sadece Yuzde*/

return price;

}

bool SpikeCheck(int shift,string side) {

bool sonuc=false;
int t=shift;


wpm=WindowPriceMax();
wpl=WindowPriceMin();

//int wpm_pips=(wpm-Bid)/Point;
//int wpl_pips=(Bid-wpl)/Point;

//if ( wpm-Bid < Bid-wpl ) {high_mode=true;low_mode=false;} else {high_mode=false;low_mode=true;}
    

double eq_price=wpl+(wpm-wpl)/2;  




   int bar_toplam = WindowFirstVisibleBar();
   double bar_pip = 0;
   double bar_ortalama=0;
   
   for (int t=1;t<=bar_toplam;t++) {
   
   bar_pip = bar_pip + MathAbs(Close[t]-Open[t]);
   
   }

   bar_ortalama = bar_pip / bar_toplam;
   
   double c=1.3;

if ( Close[t] >= eq_price && side == "HIGH"

 ) {

   if ( (Open[t] > Close[t] && High[t]-Open[t] > bar_ortalama*c) || (Open[t] < Close[t] && High[t]-Close[t] > bar_ortalama*c)// ||
   
   //(Open[t] > Close[t] && Close[t]-Low[t] > bar_ortalama*c) || (Open[t] < Close[t] && Open[t]-Low[t] > bar_ortalama*c)
   
   ) {
   
   
   bool find=false;
   for ( int b=t+1;b<t+50;b++) {

   //Print("B:",b);
   
   if ( High[b] > High[t] ) {
   find=true;
   sonuc=false;
   }
   
   }  
    
   if ( find == false ) {    
   
      ObjectCreate(ChartID(),"VLINE"+Time[t],OBJ_TRENDBYANGLE,0,Time[t],High[t],Time[t],High[t]-MathAbs(Open[t]-Close[t]));   
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_BACK,true);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_RAY,false);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_SELECTABLE,false);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_COLOR,clrBlue);
   
   
   
   sonuc=true;
   
   }
   
   
   }  else {
   
   sonuc=false;
   
   } 
   

}


if ( Close[t] <= eq_price && side == "LOW" ) {

   if ( //(Open[t] > Close[t] && High[t]-Open[t] > bar_ortalama*c) || (Open[t] < Close[t] && High[t]-Close[t] > bar_ortalama*c) ||
   
   (Open[t] > Close[t] && Close[t]-Low[t] > bar_ortalama*c) || (Open[t] < Close[t] && Open[t]-Low[t] > bar_ortalama*c)
   
   ) {


   bool find=false;
   for ( int b=t+1;b<t+50;b++) {

   //Print("B:",b);
   
   if ( Low[b] < Low[t] ) {
   find=true;
   sonuc=false;
   }
   
   }
  
  
   if ( find == false ) {   
   
      ObjectCreate(ChartID(),"VLINE"+Time[t],OBJ_TRENDBYANGLE,0,Time[t],Low[t],Time[t],Low[t]+MathAbs(Open[t]-Close[t]));   
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_BACK,true);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_RAY,false);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_WIDTH,3);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_SELECTABLE,false);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_SELECTED,false);
      ObjectSetInteger(ChartID(),"VLINE"+Time[t],OBJPROP_COLOR,clrRed);
         
     sonuc=true;

}      
   
   
   
   }  else {
   
   sonuc=false;
   
   } 
   
   
   }
   

return sonuc;

}
/////////////////////////////////////////////////////////////////////////////////////////
// Divide Zero Hatası için formül.
/////////////////////////////////////////////////////////////////////////////////////////
double DivZero(double n, double d)
{
if (d==0) return(0);  else return(n/d);
} 
//////////////////////////////////////////////////////////////////////} 
//Td[t1][0]=DivZero(CurrStrength[t1],CurrCount[t1]); 
//bid_ratio=DivZero(curr_bid-day_low,day_high-day_low);


void EventHour() {


int fark=0;


  ///// Sidney Borsasi  
  
   string yenitarih= Year()+"."+Month()+"."+IntegerToString(int(TimeDay(TimeCurrent()))-fark)+" "+23+":"+00;
 datetime some_time = StringToTime(yenitarih);
 long cid=ChartID();
 
 int shift_fark=(some_time-TimeCurrent())/PeriodSeconds();
 
  int shift=iBarShift(Symbol(),Period(),some_time);
  
  //Alert(some_time,"/",shift,"/",shift_fark);

  //ObjectCreate(cid,"Event4",OBJ_VLINE,0,Time[0]+shift_fark*PeriodSeconds(),Ask);
  ObjectCreate(cid,"Event4",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event4",OBJPROP_TEXT,"Sidney Open");
  ObjectSetInteger(cid,"Event4",OBJPROP_COLOR,clrOrange); 
  /*ObjectSetInteger(cid,"Event4",OBJPROP_ZORDER,0); 
  ObjectSetInteger(cid,"Event4",OBJPROP_BACK,false);
  ObjectSetInteger(cid,"Event4",OBJPROP_SELECTABLE,true);
  ObjectSetInteger(cid,"Event4",OBJPROP_SELECTED,true);
  ObjectSetInteger(cid,"Event4",OBJPROP_HIDDEN,false);*/
  ObjectSetInteger(cid,"Event4",OBJPROP_COLOR,clrNONE); 
  

   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+13+":"+00;
 some_time = StringToTime(yenitarih);
  
  ObjectCreate(cid,"Event31",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event31",OBJPROP_TEXT,"Hedge Finish");
  ObjectSetInteger(cid,"Event31",OBJPROP_COLOR,clrBrown);   
  ObjectSetInteger(cid,"Event31",OBJPROP_BACK,true); 
  ObjectSetInteger(cid,"Event31",OBJPROP_WIDTH,1); 
  ObjectSetInteger(cid,"Event31",OBJPROP_STYLE,STYLE_DOT); 
  
  
   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+08+":"+00;
 some_time = StringToTime(yenitarih);
  
  ObjectCreate(cid,"Event5",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event5",OBJPROP_TEXT,"Sidney Close");
  ObjectSetInteger(cid,"Event5",OBJPROP_COLOR,clrOrange);   
  ObjectSetInteger(cid,"Event5",OBJPROP_COLOR,clrNONE); 
  
///// Tokyo Borsasi 

   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+03+":"+00;
 some_time = StringToTime(yenitarih);
 
  ObjectCreate(cid,"Event6",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event6",OBJPROP_TEXT,"Tokyo Open");
  ObjectSetInteger(cid,"Event6",OBJPROP_COLOR,clrMagenta); 
  //ObjectSetInteger(cid,"Event6",OBJPROP_COLOR,clrNONE); 
  
   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+12+":"+00;
 some_time = StringToTime(yenitarih);
  
  ObjectCreate(cid,"Event7",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event7",OBJPROP_TEXT,"Tokyo Close");
  ObjectSetInteger(cid,"Event7",OBJPROP_COLOR,clrMagenta);   
  //ObjectSetInteger(cid,"Event7",OBJPROP_COLOR,clrNONE); 
  
///// Frankfurt Borsasi 

   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+09+":"+00;
 some_time = StringToTime(yenitarih);
 
  ObjectCreate(cid,"Event8",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event8",OBJPROP_TEXT,"Frankfurt Open");
  ObjectSetInteger(cid,"Event8",OBJPROP_COLOR,clrGray); 
  ObjectSetInteger(cid,"Event8",OBJPROP_COLOR,clrNONE); 
  
   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+18+":"+00;
 some_time = StringToTime(yenitarih);
  
  ObjectCreate(cid,"Event9",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event9",OBJPROP_TEXT,"Frankfurt Close");
  ObjectSetInteger(cid,"Event9",OBJPROP_COLOR,clrGray);  
  ObjectSetInteger(cid,"Event9",OBJPROP_COLOR,clrNONE); 
  
  
///// Londra Borsasi 

   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+10+":"+00;
 some_time = StringToTime(yenitarih);
 
  ObjectCreate(cid,"Event10",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event10",OBJPROP_TEXT,"Londra Open");
  ObjectSetInteger(cid,"Event10",OBJPROP_COLOR,clrGreen); 
  
  
   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+19+":"+00;
 some_time = StringToTime(yenitarih);
  
  ObjectCreate(cid,"Event11",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event11",OBJPROP_TEXT,"Londra Close");
  ObjectSetInteger(cid,"Event11",OBJPROP_COLOR,clrGreen);   
  //ObjectSetInteger(cid,"Event11",OBJPROP_COLOR,clrNONE); 
       
///// New York 

   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+15+":"+00; // TR 16 MT4 16-1=15
 some_time = StringToTime(yenitarih);
 
  ObjectCreate(cid,"Event12",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event12",OBJPROP_TEXT,"New York Open");
  ObjectSetInteger(cid,"Event12",OBJPROP_COLOR,clrBlue); 
  
   yenitarih= Year()+"."+Month()+"."+IntegerToString(TimeDay(TimeCurrent())+1)+" "+01+":"+00;
 some_time = StringToTime(yenitarih);
  
  ObjectCreate(cid,"Event13",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event13",OBJPROP_TEXT,"New York Close");
  ObjectSetInteger(cid,"Event13",OBJPROP_COLOR,clrBlue);   
  

   yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+16+":"+25;
 some_time = StringToTime(yenitarih);
  
  ObjectCreate(cid,"Event16",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event16",OBJPROP_TEXT,"Trade Time");
  ObjectSetInteger(cid,"Event16",OBJPROP_COLOR,clrCrimson);   
  ObjectSetInteger(cid,"Event16",OBJPROP_BACK,true); 
  ObjectSetInteger(cid,"Event16",OBJPROP_WIDTH,2); 
  ObjectSetInteger(cid,"Event16",OBJPROP_STYLE,STYLE_DOT); 
    
  yenitarih= Year()+"."+Month()+"."+TimeDay(TimeCurrent())+" "+16+":"+26;
 some_time = StringToTime(yenitarih);
  
  ObjectCreate(cid,"Event16s",OBJ_VLINE,0,some_time,0);
  ObjectSetString(cid,"Event16s",OBJPROP_TEXT,"Trade Time");
  ObjectSetInteger(cid,"Event16s",OBJPROP_COLOR,clrBlue);   
  ObjectSetInteger(cid,"Event16s",OBJPROP_BACK,true); 
  ObjectSetInteger(cid,"Event16s",OBJPROP_WIDTH,2); 
  ObjectSetInteger(cid,"Event16s",OBJPROP_STYLE,STYLE_DOT); 
    
  
  }