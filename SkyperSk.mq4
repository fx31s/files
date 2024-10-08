//+------------------------------------------------------------------+
//|                                                     SkyperSk.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict



bool skyper=true;
bool mode=false;

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
   
   

bool oto_system=false;

double mode_number=0;

   
   
   
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

double gericekilme=21;
double gericekilme1=21;
double gericekilme2=13;
double gericekilme3=50;

bool auto_mode=false;


int mode_off_shift=-1;
int mode_hl_shift=-1;







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

double price=0;

double sell_total_profit_loss=0;
double buy_total_profit_loss=0;

double sell_total_profit=0;
double buy_total_profit=0;

double sell_pen_total_profit_loss=0;
double buy_pen_total_profit_loss=0;

double sell_pen_total_profit=0;
double buy_pen_total_profit=0;


double last_buy_lot;
double last_sell_lot;

double buy_orders[150,4];
double sell_orders[150,4];

int magic=0;
double Lot=0; // Lot


 bool order_mode=false;
 bool order_mode_buy=false;
 bool order_mode_sell=false;
 bool order_mode_one=false;
 bool order_mode_two=false;
 bool order_mode_three=false;
 bool order_mode_four=false;
 bool order_mode_five=false;
 bool order_mode_six=false; 
 
 bool order_mode_aggressive=false;
 bool order_mode_standart=false;
 bool order_mode_defensive=false;
 
 bool order_mode_reserval=false;
 bool order_mode_trend=false; 
 bool order_mode_turbo=false; 
 
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  
  
  
  Print("OneLot:",Symbol(),"=",MarketInfo(Symbol(),MODE_MARGINREQUIRED),"$");
  
  //ObjectsDeleteAll();
  
//--- create timer
   EventSetTimer(1);
   
     /////////////////////////////////
  mnt=Time[0]+1000*PeriodSeconds();
  
  if ( Period() == PERIOD_MN1 ) {
  
  mnt=Time[0];
  
  }
  ////////////////////////////
  
  CreateSinyalButton();
  FiyatSeviyeleri();
  
  

  ///////////////////////////////////////////////////////////////////////////////
  // Us30 Modeli
  ///////////////////////////////////////////////////////////////////////////////
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  string yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+16+":"+"30";
  datetime some_time = StringToTime(yenitarih);
  
  
  if ( StringFind(Symbol(),"30",0) != -1 ) {
  ObjectDelete(ChartID(),"Us30Time");
  ObjectCreate(ChartID(),"Us30Time",OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"Us30Time",OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_COLOR,clrRed);
  
  
   for(int t=5;t<Bars-100;t++) {
   
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M5,t))) == 16 && int(TimeMinute(iTime(Symbol(),PERIOD_M5,t))) == 30 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_VLINE,0,iTime(Symbol(),PERIOD_M5,t),iHigh(Symbol(),PERIOD_M5,t));
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightGray);   
   
   }
   
   }
   
   
   
   
  
  }
  ///////////////////////////////////////////////////////////////////////////
    
  ///////////////////////////////////////////////////////////////////////////////
  // Currency Modeli
  ///////////////////////////////////////////////////////////////////////////////
  //string yenitarih= Year()"."+Month()+"."+Day()+" "+Hour()+":"+Minute();
  yenitarih= TimeYear(TimeCurrent())+"."+TimeMonth(TimeCurrent())+"."+TimeDay(TimeCurrent())+" "+15+":"+"30";
  some_time = StringToTime(yenitarih);
  
  
  if ( StringFind(Symbol(),"30",0) == -1 ) {
  ObjectDelete(ChartID(),"UsdTime");
  ObjectCreate(ChartID(),"UsdTime",OBJ_VLINE,0,some_time,Ask);
  ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_STYLE,STYLE_DOT);
  ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_COLOR,clrBlue);
  }
  

   for(int t=5;t<Bars-100;t++) {
   
   
   if ( int(TimeHour(iTime(Symbol(),PERIOD_M5,t))) == 15 && int(TimeMinute(iTime(Symbol(),PERIOD_M5,t))) == 30 ) {
   
   ObjectCreate(ChartID(),"REC"+t,OBJ_VLINE,0,iTime(Symbol(),PERIOD_M5,t),iHigh(Symbol(),PERIOD_M5,t));
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_BACK,True);
   ObjectSetInteger(ChartID(),"UsdTime",OBJPROP_STYLE,STYLE_DOT);
   ObjectSetInteger(ChartID(),"REC"+t,OBJPROP_COLOR,clrLightGray);   
   
   }
   
   }
   
     
  ///////////////////////////////////////////////////////////////////////////
    
    PeriodBilgisi();
  
   
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


SkyperOrder();



if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == False ) return;

double toplam_zarar=0;
double toplam_buy_lot=0;
double toplam_sell_lot=0;

if ( ChartGetInteger(ChartID(),CHART_BRING_TO_TOP) == False ) return;


   for (int m=OrdersTotal(); m>=0; m--)
   {
      if ( OrderSelect(m, SELECT_BY_POS,MODE_TRADES))
      {
         if(OrderType() < 2 && OrderSymbol() == sym && OrderMagicNumber() == magic )
         {
double zarar=PipPrice(Symbol(),0,1500,OrderLots());
//Print(OrderTicket(),"/",OrderLots(),"zarar:",zarar);

toplam_zarar=toplam_zarar+zarar;

if ( OrderType() == OP_BUY ) toplam_buy_lot=toplam_buy_lot+OrderLots();
if ( OrderType() == OP_SELL ) toplam_sell_lot=toplam_sell_lot+OrderLots();



         }
      }
    }
    


if ( OrdersTotal() > 0 ) {
bool sonuc=OrderCommetssTypeMulti(Symbol());
Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n Buy Profit:",buy_profit,"\n Sell Profit:",sell_profit,"\nProfit:",buy_profit+sell_profit,"\ngericekilme:",gericekilme,"\nmode_hl_shift:",mode_hl_shift,"\nNegativeBalance:",toplam_zarar,"$","\n OrderMode:",order_mode," Lot:",Lot,"\n Buy:",order_mode_buy,"\n Sell:",order_mode_sell);
} else {
Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\nmode_off_shift:",mode_off_shift,"\ngericekilme:",gericekilme,"\nmode_hl_shift:",mode_hl_shift,"\nNegativeBalance:",toplam_zarar,"$","\n OrderMode:",order_mode," Lot:",Lot,"\n Buy:",order_mode_buy,"\n Sell:",order_mode_sell);
}




string lot_bilgisi="";
if ( toplam_sell_lot > 0 ) lot_bilgisi="S:"+DoubleToString(toplam_sell_lot,2);
if ( toplam_buy_lot > 0 && lot_bilgisi == "" ) lot_bilgisi="B:"+DoubleToString(toplam_buy_lot,2);
if ( toplam_buy_lot > 0 && lot_bilgisi != "" ) lot_bilgisi=lot_bilgisi+" B:"+DoubleToString(toplam_buy_lot,2);


////////////////////////////////
if ( order_mode == true ) {
if ( buy_lot == 0 ) {
last_buy_price=-1;
}

if ( sell_lot == 0 ) {
last_sell_price=-1;
}
}
////////////////////////////////



     string LabelChart="SpreadBilgisi";
     //ObjectCreate(ChartID(),LabelChart, OBJ_RECTANGLE_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString(((Ask-Bid)/Point),0));
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,""+DoubleToString(toplam_zarar,2)+"$       "+DoubleToString(((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,lot_bilgisi+" "+DoubleToString(toplam_zarar,2)+"$       "+DoubleToString(((Ask-Bid)/Point),0));
     if ( lot_bilgisi == "" ) ObjectSetInteger(ChartID(),LabelChart,OBJPROP_XDISTANCE,200);
     if ( lot_bilgisi != "" ) ObjectSetInteger(ChartID(),LabelChart,OBJPROP_XDISTANCE,300);     
     ObjectSetInteger(ChartID(),LabelChart,OBJPROP_XDISTANCE,200);
     
	int min, sec;
	
   min = iTime(Symbol(),Period(),0) + Period()*60 - CurTime();
   sec = min%60;
   min =(min - min%60) / 60;
   //Comment("Balanced Time to next bar close: " + min + " min " + sec + " sec");
   
   
   

     LabelChart="SureBilgisi";
     //ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,min+":"+sec);



//////////////////////////////////////////////////////////////////////////
double max_lot=(DivZero(AccountBalance(),30))*MarketInfo(Symbol(),MODE_MINLOT);

if ( StringFind(AccountCompany(),"XM") != -1 ) max_lot=(DivZero(AccountBalance(),30));

double kalan_lot = max_lot-(buy_lot+sell_lot);
////////////////////////////////////////////////////

     LabelChart="LotBilgisi";
     //ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString(max_lot,2)+"T "+DoubleToString(buy_lot,2)+"+"+DoubleToString(sell_lot,2)+"="+DoubleToString(kalan_lot,2));
     if ( kalan_lot < 0 )  {
     ObjectSetInteger(ChartID(),LabelChart,OBJPROP_COLOR,clrRed);
     ObjectSetInteger(ChartID(),LabelChart,OBJPROP_FONTSIZE,20);
     }else {
     ObjectSetInteger(ChartID(),LabelChart,OBJPROP_COLOR,clrBlue);
     ObjectSetInteger(ChartID(),LabelChart,OBJPROP_FONTSIZE,12);
     }
     
     
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+

string text="";

bool wick=false;
bool price_level=true;

void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---


//Print(sparam);









if ( sparam == 16 ) { // Q

ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
wick=false;

}


if ( sparam == 25 ) {

if ( price_level == true ) { price_level=false;
ObjectsDeleteAlls(ChartID(),"Sweet",-1,-1);

} else{

price_level=true;

FiyatSeviyeleri();

}


Comment("price_level",price_level);



}

if ( sparam == 31 ) { 

    int HEIGHT=ChartGetInteger(0,CHART_HEIGHT_IN_PIXELS,0);
  int WIDTH=ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0);


            string name=Symbol()+""+int(Time[0])+".gif";
            //--- Show the name on the chart as a comment
            Print(name);
            //--- Save the chart screenshot in a file in the terminal_directory\MQL4\Files\
            ChartScreenShot(0,name,WIDTH,HEIGHT,ALIGN_RIGHT);
            
            
            


}

if ( sparam == 17 ) {

if ( wick == true ) {wick=false;}else{wick=true;}

Comment("Wick:",wick);

CreateSinyalButton();



}

   if(id==CHARTEVENT_CLICK && wick==true)
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
         

          
          
          if ( Open[shift1] >= Close[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Open[shift1],2);
          double eql=DivZero(Close[shift1]-Low[shift1],2);
          double eqc=DivZero(High[shift1]-Low[shift1],2);
          double eqb=DivZero(Open[shift1]-Close[shift1],2);
          

datetime levels=dt;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
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
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"c";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqc,mnt,High[shift1]-eqc);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"b";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Open[shift1]-eqb,mnt,Open[shift1]-eqb);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);


          
          
         
          }
          

          if ( Close[shift1] > Open[shift1] && price >= Low[shift1] && price && price <= High[shift1] ) {
          
          double eqh=DivZero(High[shift1]-Close[shift1],2);
          double eql=DivZero(Open[shift1]-Low[shift1],2);
          double eqc=DivZero(High[shift1]-Low[shift1],2);
          double eqb=DivZero(Close[shift1]-Open[shift1],2);

datetime levels=dt;//0;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Low[shift1]+eql,mnt,Low[shift1]+eql);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
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
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);          

levels=dt;
level=DoubleToString(levels,2)+"c";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],High[shift1]-eqc,mnt,High[shift1]-eqc);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrGreenYellow);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);

levels=dt;
level=DoubleToString(levels,2)+"b";
ObjectDelete(ChartID(),last_select_object+"ExpWick"+level);
ObjectCreate(ChartID(),last_select_object+"ExpWick"+level,OBJ_TREND,0,Time[shift1],Close[shift1]-eqb,mnt,Close[shift1]-eqb);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_COLOR,clrOrangeRed);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"ExpWick"+level,OBJPROP_WIDTH,1);



         
          }


         
         
         
         
         
         
        }
        
        }
        
        
        









//Print(sparam);

//text="";

if ( ObjectType(sparam) == OBJ_BUTTON ) {
text=ObjectGetString(ChartID(),sparam,OBJPROP_TEXT);

//Alert(text);
Sleep(100);
Comment(text);
ObjectSetInteger(ChartID(),sparam,OBJPROP_STATE,False);



///////////////////////////////////////


if ( text=="Trend" ) {
if ( order_mode_trend == true ) { order_mode_trend=false; } else {order_mode_trend=true;}
Comment("OrderMode-Trend:",order_mode_trend);
}

if ( text=="Reserval" ) {
if ( order_mode_reserval == true ) { order_mode_reserval=false; } else {order_mode_reserval=true;}
Comment("OrderMode-Reserval:",order_mode_reserval);
}

if ( text=="Turbo" ) {
if ( order_mode_turbo == true ) { order_mode_turbo=false; } else {order_mode_turbo=true;}
Comment("OrderMode-Turbo:",order_mode_turbo);
}






if ( text == "Aggressive" ) {

if ( order_mode_aggressive == true ) { order_mode_aggressive=false; } else { order_mode_aggressive=true; 

   order_mode_defensive=false;
   order_mode_standart=false;
}

Comment("OrderMode-Aggressive:",order_mode_aggressive);

}

if ( text == "Standart" ) {

if ( order_mode_standart == true ) { order_mode_standart=false; } else { order_mode_standart=true; 

   order_mode_defensive=false;
   order_mode_aggressive=false;

}

Comment("OrderMode-Standart:",order_mode_standart);

}


if ( text == "Defensive" ) {

if ( order_mode_defensive == true ) { order_mode_defensive=false; } else { order_mode_defensive=true; 


   order_mode_standart=false;
   order_mode_aggressive=false;

}

Comment("OrderMode-Defensive:",order_mode_defensive);

}






if ( text == "Order" ) {

if ( order_mode == true ) { order_mode=false; 

last_buy_price=-1;
last_sell_price=-1;


} else { order_mode=true; }

Comment("OrderMode:",order_mode);

}


if ( text == "Buy" || text == "Down" ) {

if ( order_mode_buy == true ) { order_mode_buy=false; 

last_buy_price=-1;

} else { order_mode_buy=true; }

Comment("OrderModeBuy:",order_mode_buy);

}

if ( text == "Sell" || text == "Up" ) {

if ( order_mode_sell == true ) { order_mode_sell=false;

    
    last_sell_price=-1;

 } else { order_mode_sell=true; }

Comment("OrderModeSell:",order_mode_sell);

}


if ( StringFind(text,"Lot "+MarketInfo(Symbol(),MODE_MINLOT),0) != -1 ) {

if ( order_mode_one == true ) { order_mode_one=false; } else { order_mode_one=true; }

Comment("OrderModeOne:",order_mode_one);

}


if ( StringFind(text,"Lot "+MarketInfo(Symbol(),MODE_MINLOT)*2,0) != -1 ) {

if ( order_mode_two == true ) { order_mode_two=false; } else { order_mode_two=true; }

Comment("OrderModeTwo:",order_mode_two);

}

if ( StringFind(text,"Lot "+MarketInfo(Symbol(),MODE_MINLOT)*3,0) != -1 ) {

if ( order_mode_three == true ) { order_mode_three=false; } else { order_mode_three=true; }

Comment("OrderModeThree:",order_mode_three);

}

if ( StringFind(text,"Lot "+MarketInfo(Symbol(),MODE_MINLOT)*4,0) != -1 ) {

if ( order_mode_four == true ) { order_mode_four=false; } else { order_mode_four=true; }

Comment("OrderModeFour:",order_mode_four);

}

if ( StringFind(text,"Lot "+MarketInfo(Symbol(),MODE_MINLOT)*5,0) != -1 ) {

if ( order_mode_five == true ) { order_mode_five=false; } else { order_mode_five=true; }

Comment("OrderModeFive:",order_mode_five);

}

if ( StringFind(text,"Lot "+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT)*10,2),0) != -1 ) {

if ( order_mode_six == true ) { order_mode_six=false; } else { order_mode_six=true; }

Comment("OrderModeSix:",order_mode_six);

}














if ( text == "Price" ) {

if ( price_level == true ) { price_level=false;
ObjectsDeleteAlls(ChartID(),"Sweet",-1,-1);

} else{

price_level=true;

FiyatSeviyeleri();

}


Comment("price_level",price_level);



}




if ( text=="Wick" ) {

if ( wick == true ) { wick=false; } else {wick=true;}

Comment("Wick:",wick);

   Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode,"\n",wick);
   //ObjectsDeleteAlls(ChartID(),"Wick",-1,-1);
   CreateSinyalButton();
}


if ( text=="Auto" ) {

if ( auto_mode == true ) { auto_mode=false; } else {auto_mode=true;}

Comment("AutoMode:",auto_mode);

   Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode);
   CreateSinyalButton();
}

if ( text=="Mode" ) {

if ( mode == true ) {mode=false;} else {mode=true;}

Comment("Mode:",mode);
   Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode);
   CreateSinyalButton();
   
}


if ( text=="Otomatik" ) {

if ( oto_system == true ) {oto_system=false;} else {oto_system=true;}

Comment("OtoSystem:",oto_system);
   Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode);
   CreateSinyalButton();
}

if ( sparam == 45 || text=="Reset") {
ObjectsDeleteAll();
mode_off_shift=-1;
last_select_object="";
mode=false;
oto_system=false;
CreateSinyalButton();
FiyatSeviyeleri(); 

}
///////////////////////


CreateSinyalButton();


}



if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_RECTANGLE) {

string last_select_objectr=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TYPE);
          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,0);
          datetime obj_time2 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,1);
          datetime obj_time3 = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_TIME,2);
          double obj_prc1 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,0);
          double obj_prc2 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,1);
          double obj_prc3 = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_PRICE,2);
          bool obj_fiil = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_FILL);
          double obj_scale = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_SCALE);
          double obj_angle = ObjectGetDouble(ChartID(),last_select_objectr,OBJPROP_ANGLE);
          bool obj_ray = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_RAY);
          color obj_color = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_COLOR);
          color obj_bgcolor = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BGCOLOR);
          int obj_width = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_WIDTH);
          int obj_back = ObjectGetInteger(ChartID(),last_select_objectr,OBJPROP_BACK);
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          
          
          if ( obj_prc1 > obj_prc2 ) {
          
        
ObjectDelete(ChartID(),last_select_objectr+"ExpC");
ObjectCreate(ChartID(),last_select_objectr+"ExpC",OBJ_TREND,0,Time[shift1],obj_prc1-((obj_prc1-obj_prc2)/2),Time[shift2],obj_prc1-((obj_prc1-obj_prc2)/2));
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_SELECTED,False); 
           
          }
          

          if ( obj_prc2 > obj_prc1 ) {

ObjectDelete(ChartID(),last_select_objectr+"ExpC");
ObjectCreate(ChartID(),last_select_objectr+"ExpC",OBJ_TREND,0,Time[shift1],obj_prc2-((obj_prc2-obj_prc1)/2),Time[shift2],obj_prc2-((obj_prc2-obj_prc1)/2));
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_WIDTH,2);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_COLOR,clrRed);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_objectr+"ExpC",OBJPROP_SELECTED,False); 
    

          
          }
              
              
              
              
                    
          
          
          
          }
          
          
          /*

if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_VLINE  && lock == false && skyper == true) {


RefreshRates();
ChartRedraw();
WindowRedraw();


//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


last_select_object=sparam;



          datetime obj_time1 = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME);
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          
          int yil=TimeYear(obj_time1);
          
          if ( yil != 1970 ) {
          Comment("Zaman:",shift1,"/",Bars,"/",TimeYear(obj_time1));
          
          double yuzde=DivZero(WindowPriceMax()-WindowPriceMin(),100);
          
          double level_prc=DivZero(Close[shift1]-WindowPriceMin(),yuzde);
          
          if ( level_prc > 70 ) {
          
          ObjectSetInteger(ChartID(),last_select_object,OBJPROP_COLOR,clrLimeGreen);
          
          double low_price=Low[shift1];
          bool find=false;
          int say=0;
          int lvl_shift=shift1;
          
          for (int i=shift1;i>0;i--) {
          
          if ( find==true)continue;
          
          if ( Low[i] < low_price ) {
          low_price=Low[i];
          say=0;
          lvl_shift=i;
          } else {
          say=say+1;
          if ( say >= 5 ) {//find=true;
          
       //  ObjectDelete(ChartID(),"LowLvl"+i);
       //  ObjectCreate(ChartID(),"LowLvl"+i,OBJ_VLINE,0,Time[lvl_shift],Ask);
 
          double prc_yuzde=DivZero(High[shift1]-low_price,100);
          
          if ( (High[shift1]-low_price)/Point < 1000 ) continue;
          

          
          double high_price=High[lvl_shift];
          bool finds=false;
          int says=0;
          int lvl_shifts=lvl_shift;
          
          for (int ii=lvl_shifts;ii>0;ii--) {
          
          
          double prc_level=DivZero(High[ii]-low_price,prc_yuzde);
          
          if ( finds==true )continue;
          if ( prc_level < 45 )continue;
          if ( prc_level > 61 )continue;
          
          if ( High[ii] > high_price ) {
          high_price=High[ii];
          says=0;
          lvl_shifts=ii;
          } else {
          says=says+1;
          if ( says >= 5 ) {
          
          bool new_low=false;
          
          for (int r=lvl_shift;r>lvl_shifts;r--) {
          
          if ( low_price > Low[r] ) new_low=true;
          
          
          }
          
          if ( new_low == true ) {
          say=0;
          says=0;
          find=false;
          continue;}
          
        find=true;
        finds=true;
          
        ObjectDelete(ChartID(),"HighLvl");
        ObjectCreate(ChartID(),"HighLvl",OBJ_HLINE,0,Time[lvl_shifts],high_price);
 
         ObjectDelete(ChartID(),"LowLvl"+i);
         ObjectCreate(ChartID(),"LowLvl"+i,OBJ_VLINE,0,Time[lvl_shift],Ask);
          
        ObjectDelete(ChartID(),"LowPrcLvl");
          ObjectCreate(ChartID(),"LowPrcLvl",OBJ_HLINE,0,Time[lvl_shift],low_price);    
          

        ObjectDelete(ChartID(),"HighLowLvl");
        ObjectCreate(ChartID(),"HighLowLvl",OBJ_TREND,0,Time[shift1],High[shift1],Time[lvl_shift],low_price);
        ObjectSetInteger(ChartID(),"HighLowLvl",OBJPROP_RAY,False);
        //oto_system=true;
        
                
          
          
          }
          }
          
          }
          
          
 
          
         
          }
          }
          
          }
          
          
          
          
          
          }
          
          if ( level_prc < 30 ) {
          
          ObjectSetInteger(ChartID(),last_select_object,OBJPROP_COLOR,clrCrimson);
          
          
          }
          
          
          
          
          }
          
         
          
          }
          

*/


if ( sparam == 19 ) {

if ( ChartGetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0) == True ) {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,False); } else {ChartSetInteger(ChartID(),CHART_SHOW_TRADE_LEVELS,0,True);}

}




if ( sparam == 30 ) {

if ( auto_mode == true ) { auto_mode=false; } else {auto_mode=true;}

Comment("AutoMode:",auto_mode);

   Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode);
   CreateSinyalButton();
}

if ( sparam == 50 || sparam == 33 ) {

if ( mode == true ) {mode=false;} else {mode=true;}

Comment("Mode:",mode);
   Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode);
   CreateSinyalButton();
}


if ( sparam == 24  ) {

if ( oto_system == true ) {oto_system=false;} else {oto_system=true;}

Comment("OtoSystem:",oto_system);
   Comment("AutoMode:",auto_mode,"\nOtomatik:",oto_system,"\nMode:",mode);
   CreateSinyalButton();
}

if ( sparam == 45 ) {
ObjectsDeleteAll();
mode_off_shift=-1;
mode_hl_shift=-1;
last_select_object="";
mode=false;
oto_system=false;
CreateSinyalButton();
PeriodBilgisi();

}







if ( ObjectGetInteger(ChartID(),sparam,OBJPROP_TYPE) == OBJ_TREND && StringFind(sparam,"MP",0) == -1 && StringFind(sparam,"HP",0) == -1 && StringFind(sparam,"LP",0) == -1 && StringFind(sparam,"CP",0) == -1 &&  StringFind(sparam,"Exp",0) == -1 && StringFind(sparam,"MAL",0) == -1 && lock == false && skyper == true) {

RefreshRates();
ChartRedraw();
WindowRedraw();



//if ( mode_off_shift != 0 && sparam != last_select_object ) mode=true;


last_select_object=sparam;


          int obj_typ = ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TYPE);
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
          
          
          int shift1=iBarShift(Symbol(),Period(),obj_time1);
          int shift2=iBarShift(Symbol(),Period(),obj_time2);
          
          shift_1=shift1;
          shift_2=shift2;
          
          price_1=obj_prc1;
          price_2=obj_prc2;
          

//oto_system=true;

//Alert("Selam",oto_system);



if ( oto_system == true ) {          
          
if ( obj_prc2 > obj_prc1 ) {

//Alert("Selam");



ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);

high_price=High[shift2];
low_price=Low[shift1];





for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}



//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


double yuzde=DivZero(high_price-low_price,100);



ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);


int last_gericekilme=gericekilme;
gericekilme=GeriCekilmeSistemi(last_gericekilme);


//if ( gericekilme == gericekilme1 ) { gericekilme=gericekilme2;} else {gericekilme=gericekilme1;}


double low_prices=low_price+yuzde*gericekilme;



double levels=gericekilme;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],low_price+levels*yuzde,mnt,low_price+levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

low_price=low_prices;
double high_prices=high_price;

double fibo=high_price;
yuzde=DivZero(high_price-low_price,100);



levels=66.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




double yyy=high_price-yuzde*levels;

double y=DivZero(High[shift2]-Low[shift1],100);
double yy=DivZero((high_price-(high_price-yuzde*levels)),y);



levels=yy;

level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+(1000*PeriodSeconds()),High[shift2]-y*yy,mnt,High[shift2]-y*yy);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


yyy=high_price-yuzde*levels;

y=DivZero(High[shift2]-Low[shift1],100);
yy=DivZero((high_price-(high_price-yuzde*levels)),y);



levels=yy;

level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+(1000*PeriodSeconds()),High[shift2]-y*yy,mnt,High[shift2]-y*yy);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);





levels=61.81;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],high_price-yuzde*66.70,mnt,high_price-yuzde*61.80);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrPink);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=61.82;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],high_price-yuzde*61.80,mnt,high_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=50.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=45.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);







}  else {






ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);

high_price=High[shift1];
low_price=Low[shift2];





for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}





ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);



double yuzde=DivZero(high_price-low_price,100);

int last_gericekilme=gericekilme;
gericekilme=GeriCekilmeSistemi(last_gericekilme);


//if ( gericekilme == gericekilme1 ) { gericekilme=gericekilme2;} else {gericekilme=gericekilme1;}


double high_prices=high_price-yuzde*gericekilme;






double levels=gericekilme;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift1],high_price-levels*yuzde,mnt,high_price-levels*yuzde);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


high_price=high_prices;
double low_prices=low_price;

double fibo=low_price;
yuzde=DivZero(high_price-low_price,100);





levels=66.7;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

double yyy=low_price+yuzde*levels;

double y=DivZero(High[shift1]-Low[shift2],100);
double yy=DivZero(((low_price+yuzde*levels)-low_price),y);



levels=yy;

level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+(1000*PeriodSeconds()),Low[shift2]+y*yy,mnt,Low[shift2]+y*yy);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);







levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


yyy=low_price+yuzde*levels;

y=DivZero(High[shift1]-Low[shift2],100);
yy=DivZero(((low_price+yuzde*levels)-low_price),y);



levels=yy;

level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2]+(1000*PeriodSeconds()),Low[shift2]+y*yy,mnt,Low[shift2]+y*yy);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);






levels=61.81;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],low_price+yuzde*66.70,mnt,low_price+yuzde*61.80);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrPink);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=61.82;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],low_price+yuzde*61.80,mnt,low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);





levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=50.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=45.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);






}
     
    return;    
}          
          
          
       
          
          
          

if ( mode == false ) {

if ( obj_prc1 > obj_prc2 ) {

//Alert("Selam",mode);


int last_gericekilme=gericekilme;
gericekilme=GeriCekilmeSistemi(last_gericekilme);


//if ( gericekilme == gericekilme1 ) { gericekilme=gericekilme2;} else {gericekilme=gericekilme1;}

ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);
ObjectSetString(ChartID(),last_select_object,OBJPROP_TOOLTIP,gericekilme);


high_price=High[shift1];
low_price=High[shift2];


for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


double fark=High[shift1]-High[shift2];

Comment("Fark:",fark/Point);

ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);

mode_off_shift=shift2;
mode_hl_shift=shift1;

double yuzde21=DivZero(fark,gericekilme);

double max_price=(High[shift1]-yuzde21*100);



int tm=WindowFirstVisibleBar()-WindowBarsPerChart();
if ( tm < 0 ) tm=0;


ObjectDelete(ChartID(),last_select_object+"MP");
ObjectCreate(ChartID(),last_select_object+"MP",OBJ_TREND,0,Time[shift2],max_price,Time[0],max_price);
ObjectSetInteger(ChartID(),last_select_object+"MP",OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"MP",OBJPROP_WIDTH,1);
ObjectSetString(ChartID(),last_select_object+"MP",OBJPROP_TOOLTIP,gericekilme);


ObjectDelete(ChartID(),last_select_object+"MPH");
ObjectCreate(ChartID(),last_select_object+"MPH",OBJ_TREND,0,Time[shift1],high_price,Time[tm],max_price);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_WIDTH,1);
ObjectSetString(ChartID(),last_select_object+"MPH",OBJPROP_TOOLTIP,gericekilme);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_SELECTED,False);


double max_price_new=max_price;


if ( gericekilme == 13 ) {yuzde21=DivZero(fark,21);} else {yuzde21=DivZero(fark,13);}

max_price=(High[shift1]-yuzde21*100);

ObjectDelete(ChartID(),last_select_object+"MP3");
ObjectCreate(ChartID(),last_select_object+"MP3",OBJ_TREND,0,Time[shift2],max_price,Time[0],max_price);
ObjectSetInteger(ChartID(),last_select_object+"MP3",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_object+"MP3",OBJPROP_WIDTH,1);
if ( gericekilme == 13 ) ObjectSetString(ChartID(),last_select_object+"MP3",OBJPROP_TOOLTIP,"21");
if ( gericekilme == 21 ) ObjectSetString(ChartID(),last_select_object+"MP3",OBJPROP_TOOLTIP,"13");


double max_price_down=0;;

if ( max_price_new > max_price ) {
max_price_down=max_price-(max_price_new-max_price);
} else {
max_price_down=max_price_new-(max_price-max_price_new);
}

ObjectDelete(ChartID(),last_select_object+"MPND");
ObjectCreate(ChartID(),last_select_object+"MPND",OBJ_TREND,0,Time[shift2],max_price_down,Time[0],max_price_down);
ObjectSetInteger(ChartID(),last_select_object+"MPND",OBJPROP_COLOR,clrMagenta);
ObjectSetInteger(ChartID(),last_select_object+"MPND",OBJPROP_WIDTH,1);








double high_prices=High[shift2];

//for (int i=shift1;i>shift2;i--) {
for (int i=shift2+1;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


fark=High[shift1]-low_price;


double yuzde=DivZero(high_price-low_price,100);


ObjectDelete(ChartID(),last_select_object+"LP");
ObjectCreate(ChartID(),last_select_object+"LP",OBJ_TREND,0,Time[shift2],low_price,Time[0],low_price);
ObjectSetInteger(ChartID(),last_select_object+"LP",OBJPROP_SELECTABLE,False);

ObjectDelete(ChartID(),last_select_object+"HP");
ObjectCreate(ChartID(),last_select_object+"HP",OBJ_TREND,0,ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0),high_price,Time[0],high_price);
ObjectSetInteger(ChartID(),last_select_object+"HP",OBJPROP_SELECTABLE,False);

ObjectDelete(ChartID(),last_select_object+"CP");
ObjectCreate(ChartID(),last_select_object+"CP",OBJ_TREND,0,ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1),ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1),Time[0],ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1));
ObjectSetInteger(ChartID(),last_select_object+"CP",OBJPROP_SELECTABLE,False);


double lower=low_price;


double levels=101;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices-(high_price-low_price),mnt,high_prices-(high_price-low_price));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

//double dip=High[2]-yuzde*100;
//double yuzde=DivZero(high_price-(lower-farks),100);

double fibo=high_prices-(high_price-low_price);


levels=100;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],fibo-yuzde*levels,mnt,fibo-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=80.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],fibo-yuzde*levels,mnt,fibo-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],fibo-yuzde*levels,mnt,fibo-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=78.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices-yuzde*levels,mnt,high_prices-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=61.81;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices-yuzde*levels,mnt,high_prices-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


} else {


//Alert("Selam",mode);


int ls=shift2;

//if ( gericekilme == gericekilme1 ) { gericekilme=gericekilme2;} else {gericekilme=gericekilme1;}

int last_gericekilme=gericekilme;
gericekilme=GeriCekilmeSistemi(last_gericekilme);


ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);
ObjectSetString(ChartID(),last_select_object,OBJPROP_TOOLTIP,gericekilme);

high_price=Low[shift1];
low_price=Low[shift2];





for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}


double fark=Low[shift2]-Low[shift1];

Comment("Fark:",fark/Point);

ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);

mode_hl_shift=shift1;

mode_off_shift=shift2;


double yuzde21=DivZero(fark,gericekilme);

double max_price=(Low[shift1]+yuzde21*100);

double max_price_new=max_price;

ObjectDelete(ChartID(),last_select_object+"MP");
ObjectCreate(ChartID(),last_select_object+"MP",OBJ_TREND,0,Time[shift2],max_price,Time[0],max_price);
ObjectSetInteger(ChartID(),last_select_object+"MP",OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),last_select_object+"MP",OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),last_select_object+"MP",OBJPROP_TOOLTIP,gericekilme);


int tm=WindowFirstVisibleBar()-WindowBarsPerChart();
if ( tm < 0 ) tm=0;


ObjectDelete(ChartID(),last_select_object+"MPH");
ObjectCreate(ChartID(),last_select_object+"MPH",OBJ_TREND,0,Time[shift1],high_price,Time[tm],max_price);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_COLOR,clrDarkGray);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_WIDTH,1);
ObjectSetString(ChartID(),last_select_object+"MPH",OBJPROP_TOOLTIP,gericekilme);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"MPH",OBJPROP_SELECTED,False);





if ( gericekilme == 13 ) {yuzde21=DivZero(fark,21);} else {yuzde21=DivZero(fark,13);}

max_price=(Low[shift1]+yuzde21*100);


double max_price_up=0;

if ( max_price_new > max_price ) {
max_price_up=max_price_new+(max_price_new-max_price);
} else {
max_price_up=max_price+(max_price-max_price_new);
}

ObjectDelete(ChartID(),last_select_object+"MP3");
ObjectCreate(ChartID(),last_select_object+"MP3",OBJ_TREND,0,Time[shift2],max_price,Time[0],max_price);
ObjectSetInteger(ChartID(),last_select_object+"MP3",OBJPROP_COLOR,clrBlue);
ObjectSetInteger(ChartID(),last_select_object+"MP3",OBJPROP_WIDTH,1);
if ( gericekilme == 13 ) ObjectSetString(ChartID(),last_select_object+"MP3",OBJPROP_TOOLTIP,"21");
if ( gericekilme == 21 ) ObjectSetString(ChartID(),last_select_object+"MP3",OBJPROP_TOOLTIP,"13");


ObjectDelete(ChartID(),last_select_object+"MPNU");
ObjectCreate(ChartID(),last_select_object+"MPNU",OBJ_TREND,0,Time[shift2],max_price_up,Time[0],max_price_up);
ObjectSetInteger(ChartID(),last_select_object+"MPNU",OBJPROP_COLOR,clrMagenta);
ObjectSetInteger(ChartID(),last_select_object+"MPNU",OBJPROP_WIDTH,1);







double low_prices=Low[shift1];

double high_price=Low[shift2];
double high_prices=Low[shift2];

//double high_price=High[shift2];
//double high_prices=High[shift2];


for (int i=shift1;i>shift2;i--) {
//for (int i=shift2+1;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


fark=High[shift1]-low_price;


double yuzde=DivZero(high_price-low_price,100);


ObjectDelete(ChartID(),last_select_object+"LP");
ObjectCreate(ChartID(),last_select_object+"LP",OBJ_TREND,0,ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,0),low_price,Time[0],low_price);
ObjectSetInteger(ChartID(),last_select_object+"LP",OBJPROP_SELECTABLE,False);

ObjectDelete(ChartID(),last_select_object+"HP");
ObjectCreate(ChartID(),last_select_object+"HP",OBJ_TREND,0,Time[shift1],high_price,Time[0],high_price);
ObjectSetInteger(ChartID(),last_select_object+"HP",OBJPROP_SELECTABLE,False);

ObjectDelete(ChartID(),last_select_object+"CP");
ObjectCreate(ChartID(),last_select_object+"CP",OBJ_TREND,0,ObjectGetInteger(ChartID(),last_select_object,OBJPROP_TIME,1),ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1),Time[0],ObjectGetDouble(ChartID(),last_select_object,OBJPROP_PRICE,1));
ObjectSetInteger(ChartID(),last_select_object+"CP",OBJPROP_SELECTABLE,False);

//double lower=low_price;


double levels=101;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
//ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price,mnt,low_price);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices+(high_price-low_price),mnt,high_prices+(high_price-low_price));
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


//double dip=High[2]-yuzde*100;
//double yuzde=DivZero(high_price-(lower-farks),100);


double fibo=high_prices+(high_price-low_price);


levels=100;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],fibo+yuzde*levels,mnt,fibo+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=80.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],fibo+yuzde*levels,mnt,fibo+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],fibo+yuzde*levels,mnt,fibo+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=78.6;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices+yuzde*levels,mnt,high_prices+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=61.81;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_prices+yuzde*levels,mnt,high_prices+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrBlack);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


}

}

if ( mode == true ) {        
          
if ( obj_prc1 > obj_prc2 ) {




ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrLimeGreen);


low_price=Low[shift2];
high_price=High[shift1];


//Alert(low_price,"/",shift2);

//Sleep(100);
if ( auto_mode == true ) {

for (int i=shift1;i>shift2;i--) {
//for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}


} else {
if ( mode_off_shift != -1 ) {high_price=High[mode_off_shift];shift1=mode_off_shift;}
}


//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

double ote;
if ( mode_hl_shift != -1 ) ote=Low[shift2]+((DivZero((High[mode_hl_shift]-Low[shift2]),100)*79));




ObjectMove(ChartID(),last_select_object,0,Time[shift1],High[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],Low[shift2]);


double yuzde=DivZero(high_price-low_price,100);


double levels=66.7;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

if ( mode_hl_shift != -1 ) {
levels=79.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],ote,mnt,ote);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),last_select_object+"Exp"+level,OBJPROP_TOOLTIP,"OTE");
}


levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=61.81;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],low_price+yuzde*66.70,mnt,low_price+yuzde*61.80);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrPink);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=61.82;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],low_price+yuzde*61.80,mnt,low_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=50.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=45.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],low_price+yuzde*levels,mnt,low_price+yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);


} else {



ObjectSetInteger(ChartID(),sparam,OBJPROP_COLOR,clrCrimson);


low_price=Low[shift1];
high_price=High[shift2];

/*
for (int i=shift1;i>shift2;i--) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}
*/

//for (int i=shift1;i>shift2;i--) {
for (int i=shift2;i<shift1;i++) {

if ( High[i] > high_price ) {high_price=High[i];shift2=i;}
//if ( Low[i] < low_price ) {low_price=Low[i];shift2=i;}

}

//////////////////////////////////
if ( auto_mode == true ) {

//for (int i=shift1;i>shift2;i--) {
for (int i=shift1;i>shift2;i--) {

//if ( High[i] > high_price ) {high_price=High[i];shift1=i;}
if ( Low[i] < low_price ) {low_price=Low[i];shift1=i;}

}


} else {
if ( mode_off_shift != -1 ) {low_price=Low[mode_off_shift];shift1=mode_off_shift;}
}
//////////////////////////////

double ote;
if ( mode_hl_shift != -1 ) ote=High[shift2]-((DivZero((High[shift2]-Low[mode_hl_shift]),100)*79));


ObjectMove(ChartID(),last_select_object,0,Time[shift1],Low[shift1]);
ObjectMove(ChartID(),last_select_object,1,Time[shift2],High[shift2]);

double yuzde=DivZero(high_price-low_price,100);


double levels=66.7;
string level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

if ( mode_hl_shift != -1 ) {
levels=79.;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],ote,mnt,ote);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);
ObjectSetString(ChartID(),last_select_object+"Exp"+level,OBJPROP_TOOLTIP,"OTE");
}



levels=61.8;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=61.81;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],high_price-yuzde*66.70,mnt,high_price-yuzde*61.80);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrPink);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=61.82;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_RECTANGLE,0,Time[shift2],high_price-yuzde*61.80,mnt,high_price);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrLightGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=55.9;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=50.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);

levels=45.0;
level=DoubleToString(levels,2);
ObjectDelete(ChartID(),last_select_object+"Exp"+level);
ObjectCreate(ChartID(),last_select_object+"Exp"+level,OBJ_TREND,0,Time[shift2],high_price-yuzde*levels,mnt,high_price-yuzde*levels);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_RAY,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_COLOR,clrDarkGreen);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_STYLE,STYLE_DOT);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTABLE,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_BACK,True);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_SELECTED,False);
ObjectSetInteger(ChartID(),last_select_object+"Exp"+level,OBJPROP_WIDTH,2);




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
// Thank You For Life 26.01.2024

/////////////////////////////////////////////////////////////////////////////////////////////////////////
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

if ( OrderMagicNumber() != magic ) continue;

//Print(OrderTicket());


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
//if ( OrderType() == OP_BUY //&& OrderMagicNumber() == magic 
) {
buy_total=buy_total+1;
buy_profit=buy_profit+OrderProfit();
buy_profit=buy_profit+OrderCommission();
buy_lot=buy_lot+OrderLots();


buy_orders[buy_total,0]=OrderTicket();
buy_orders[buy_total,1]=OrderProfit()+OrderCommission();
buy_orders[buy_total,2]=OrderLots();
buy_orders[buy_total,3]=OrderOpenPrice();



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
//if ( OrderType() == OP_SELL //&& OrderMagicNumber() == magic 
 ) {
sell_total=sell_total+1;
sell_profit=sell_profit+OrderProfit();
sell_profit=sell_profit+OrderCommission();
sell_lot=sell_lot+OrderLots();


sell_orders[sell_total,0]=OrderTicket();
sell_orders[sell_total,1]=OrderProfit()+OrderCommission();
sell_orders[sell_total,2]=OrderLots();
sell_orders[sell_total,3]=OrderOpenPrice();



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
////////////////////////////////////////////////////////////////////////////
// Pip - Price Fonksiyonu  ? 100 pip kazansa 0.01 bu kur ne kazandirir ?
////////////////////////////////////////////////////////////////////////////
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
        
   double BS_spread_one = DivZero(BS_spread_price,BS_spread)*lots;     
    double Order_Profit = pips*BS_spread_one;   
    
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


double PipPricex(string sym,double fiyat,int pips,double lots) {



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


//////////////////////////////////////////////////////////
string last_sinyal_server = "";
string server_order_comment = "sinyal";
int last_sinyal_number = -1;
 int max_sinyal_number = (ChartGetInteger(0,CHART_WIDTH_IN_PIXELS,0)-130) / 140; // Otomatik Sinyal Kutusu
 
 

 

//////////////////////////////////////////////////////////////////////////////////////////////////

void CreateSinyalButton() {


Lot=0;


  int max_sinyal_number = 17;
  
  string buttonID="";
  
  //if ( ChartID() == 0 ) {
  /////////////////////////////////////////////////////////////////////////////////////////////////////
     for (int bs=0;bs<=max_sinyal_number;bs++){
   
   buttonID="ButtonSinyal"+bs; // Support LeveL Show
   
   string text="";
   color renk=clrGreen;
   
   if ( bs ==  2 ) text ="Auto";
   if ( bs ==  1 ) text ="Otomatik";
   if ( bs ==  0 ) text ="Mode";
   if ( bs ==  4 ) text ="Reset";
   if ( bs ==  5 ) text ="Wick";
   if ( bs ==  3 ) text ="Price";
   if ( bs ==  6 ) text ="Order";
   if ( bs ==  7 ) text ="Up";
   if ( bs ==  8 ) text ="Down";
   if ( bs ==  9 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT);
   if ( bs ==  10 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*2;
   if ( bs ==  11 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*3;
   if ( bs ==  12 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*4;
   if ( bs ==  13 ) text ="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*5;
   if ( bs ==  14 ) text ="Lot "+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT)*10,2);
   if ( bs ==  15  ) text ="Aggressive";
   if ( bs ==  16  ) text ="Standart";
   if ( bs ==  17  ) text ="Defensive";
   if ( bs ==  15  ) text ="Trend";
   if ( bs ==  16  ) text ="Reserval";
   if ( bs ==  17  ) text ="Turbo";
   
   
   if ( text=="Auto" && auto_mode == true ) renk=clrRed;
   if ( text=="Otomatik" && oto_system == true ) renk=clrRed;
   if ( text=="Mode" && mode == true ) renk=clrRed;
   if ( text=="Wick" && wick == true ) renk=clrRed;
   if ( text=="Price" && price_level == true ) renk=clrDarkGreen;
   if ( text=="Order" && order_mode == true ) renk=clrLightGray;
   if ( text=="Down" && order_mode_buy == true ) renk=clrBlue;
   if ( text=="Up" && order_mode_sell == true ) renk=clrOrangeRed;
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT) && order_mode_one == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT);}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*2 && order_mode_two == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*2;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*3 && order_mode_three == true ) {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*3;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*4 && order_mode_four == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*4;}
   if ( text=="Lot "+MarketInfo(Symbol(),MODE_MINLOT)*5 && order_mode_five == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*5;}
   if ( text=="Lot "+DoubleToString(MarketInfo(Symbol(),MODE_MINLOT)*10,2) && order_mode_six == true )  {renk=clrTurquoise;Lot=Lot+MarketInfo(Symbol(),MODE_MINLOT)*10;}
   
   if ( text=="Aggressive" && order_mode_aggressive == true ) {renk=clrRed;}
   
   if ( text=="Standart" && order_mode_standart == true ) {renk=clrRed;}
      
   if ( text=="Defensive" && order_mode_defensive == true ) {renk=clrRed;}      
   

   if ( text=="Trend" && order_mode_trend == true ) renk=clrNavy;
   if ( text=="Reserval" && order_mode_reserval == true ) renk=clrMaroon;
   if ( text=="Turbo" && order_mode_turbo == true ) renk=clrLimeGreen;
   
      
      
                                    
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   //ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGreen);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,renk);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,10);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,130+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,50);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);  
    
   if ( bs >= 6 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,150+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
   
   
   if ( bs >= 9 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,180+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
      


   if ( bs >= 15 ) {
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,5);
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,210+(20*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,60);
   }
   
   
   
   
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,text);
   //ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 6  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,16);
   //if ( StringLen(symbolfind("EURUSD")) == 9  ) ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,11);
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,7);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_UPPER); 
   /*
   buttonID="ButtonSinyalTime"+bs;
   
   ObjectCreate(0,buttonID,OBJ_BUTTON,0,100,100);
   ObjectSetInteger(0,buttonID,OBJPROP_COLOR,clrWhite);
   ObjectSetInteger(0,buttonID,OBJPROP_BGCOLOR,clrGray);
   ObjectSetInteger(0,buttonID,OBJPROP_XDISTANCE,130+(120*bs));
   ObjectSetInteger(0,buttonID,OBJPROP_YDISTANCE,30);
   ObjectSetInteger(0,buttonID,OBJPROP_XSIZE,110);
   ObjectSetInteger(0,buttonID,OBJPROP_YSIZE,20);
   ObjectSetString(0,buttonID,OBJPROP_FONT,"Arial");
   ObjectSetString(0,buttonID,OBJPROP_TEXT,"TIME");
   ObjectSetInteger(0,buttonID,OBJPROP_FONTSIZE,8);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,0);
   ObjectSetInteger(0,buttonID,OBJPROP_BACK,false);
   ObjectSetInteger(0,buttonID,OBJPROP_CORNER,CORNER_LEFT_LOWER); 
   //ObjectSetInteger(0,buttonID,OBJPROP_HIDDEN,true);
   ObjectSetInteger(0,buttonID,OBJPROP_SELECTABLE,true);*/
   
   }

}         

void FiyatSeviyeleri() {

ObjectsDeleteAlls(ChartID(),"Sweet",-1,-1);


   dPt = Point;
   if(Digits==3||Digits==5){
      dPt=dPt*10;
   } 
   
   if ( StringFind(Symbol(),"XAUUSD",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US30",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"SP500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"USDZAR",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"USDMXN",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"USDJPY",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"NAS100",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"GER30",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"GER40",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"EURMXN",0) != -1 ) dPt=dPt*100;
   
   
   if ( StringFind(AccountCompany(),"Robo",0) != -1 ) {
   
   
   if ( StringFind(Symbol(),"DE40",0) != -1 ) dPt=dPt*10;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*0.1;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=1;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=Point*100;
   if ( StringFind(Symbol(),"USTECH",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"BTC",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"BNB",0) != -1 ) dPt=dPt*10;
   }
   
   if ( StringFind(AccountCompany(),"XM",0) != -1 ) {
   
   if ( StringFind(Symbol(),"GOLD",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"DE40",0) != -1 ) dPt=dPt*10;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*0.1;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=1;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=Point*100;
   if ( StringFind(Symbol(),"USTECH",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"BTC",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"BNB",0) != -1 ) dPt=dPt*10;
   }


//Alert(AccountCompany());

   if ( StringFind(AccountCompany(),"Prime",0) != -1 ) {
   
   if ( StringFind(Symbol(),"GOLD",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"DE40",0) != -1 ) dPt=dPt*10;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=dPt*0.1;
   //if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=1;
   if ( StringFind(Symbol(),"ETHUSD",0) != -1 ) dPt=Point*100;
   if ( StringFind(Symbol(),"USTECH",0) != -1 ) dPt=dPt*100;
   if ( StringFind(Symbol(),"US500",0) != -1 ) dPt=dPt*10;
   if ( StringFind(Symbol(),"BTC",0) != -1 ) dPt=dPt*1000;
   if ( StringFind(Symbol(),"BNB",0) != -1 ) dPt=dPt*10;
   }
   
      
      
   
   //Alert(Point*100);
  
   Ict();
   Ict250();
   
   
 

}

extern int LinesAboveBelow= 10;
color LineColorMain= DarkGray;
color LineColorSub= DarkGray;

double dPt;


double open_order=false;
double first_question=false;

void Ict() {


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%50;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*50); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
            
      

      
      
         
      SetLevel(DoubleToStr(ds1,Digits), ds1,  linecolor, style, Time[10]);
   }
   
   
}


void Ict250() {


static datetime timelastupdate= 0;
   static datetime lasttimeframe= 0;
   
    
   // no need to update these buggers too often   
   if (CurTime()-timelastupdate < 600 && Period()==lasttimeframe)
      return;
      
   int i, ssp1, style, ssp;
   double ds1;
   color linecolor;
   
   ssp1= Bid / dPt;
   ssp1= ssp1 - ssp1%25;

   for (i= -LinesAboveBelow; i<LinesAboveBelow; i++) {
      ssp= ssp1+(i*25); 
      
      if (ssp%100==0) {
         style= STYLE_SOLID;
         linecolor= LineColorMain;
      }
      else {
         style= STYLE_DOT;
         linecolor= LineColorSub;
      }
      
      ds1= ssp*dPt;
      SetLevel(DoubleToStr(ds1,Digits), ds1,  clrLightGray, STYLE_DOT, Time[10]);
   }
   
   
}



void SetLevel(string text, double level, color col1, int linestyle, datetime startofday)
{
   int digits= Digits;
   string linename= "[SweetSpot] " + text + " Line",
          pricelabel; 

   // create or move the horizontal line   
   if (ObjectFind(ChartID(),linename) != 0) {
      ObjectCreate(ChartID(),linename, OBJ_HLINE, 0, 0, level);
      ObjectSetInteger(ChartID(),linename, OBJPROP_STYLE, linestyle);
      ObjectSetInteger(ChartID(),linename, OBJPROP_COLOR, col1);
      ObjectSetInteger(ChartID(),linename, OBJPROP_WIDTH, 0);
   }
   else {
      ObjectMove(ChartID(),linename, 0, Time[0], level);
   }
}

void ObjectsDeleteAlls(long oda_charid,string oda_wilcard,int oda_window,int oda_type) {


//return;

             int obj_total=ObjectsTotal(oda_charid,oda_window,oda_type)-1;
    for(int i=ObjectsTotal(oda_charid,oda_window,oda_type);i>=0;i--)
        {
        string name = ObjectName(oda_charid,i,oda_window,oda_type);
        
  int index = StringFind(name,oda_wilcard, 0); 


  if ( index != -1 ) {
  Sleep(100);
  ObjectDelete(ChartID(),name);
   }  
   
  }


}

//////////////////////////////////////////////////////////
int StrtoTF(string sinyal_sym_periyod){
int Chart_Config_per=-1;
//sinyal_sym_periyod=StringToUpper(sinyal_sym_periyod);
   if ( sinyal_sym_periyod == "M1" ) Chart_Config_per = PERIOD_M1;
   if ( sinyal_sym_periyod == "M5" ) Chart_Config_per = PERIOD_M5;
   if ( sinyal_sym_periyod == "M15" ) Chart_Config_per = PERIOD_M15;
   if ( sinyal_sym_periyod == "M30" ) Chart_Config_per = PERIOD_M30;
   if ( sinyal_sym_periyod == "H1" ) Chart_Config_per = PERIOD_H1;
   if ( sinyal_sym_periyod == "H4" ) Chart_Config_per = PERIOD_H4;
   if ( sinyal_sym_periyod == "D1" ) Chart_Config_per = PERIOD_D1;
   if ( sinyal_sym_periyod == "W1" ) Chart_Config_per = PERIOD_W1;
   if ( sinyal_sym_periyod == "MN1" ) Chart_Config_per = PERIOD_MN1;
return Chart_Config_per;
}

string TFtoStr(int period) {
 switch(period) {
  case 1     : return("M1");  break;
  case 5     : return("M5");  break;
  case 15    : return("M15"); break;
  case 30    : return("M30"); break;
  case 60    : return("H1");  break;
  case 240   : return("H4");  break;
  case 1440  : return("D1");  break;
  case 10080 : return("W1");  break;
  case 43200 : return("MN1"); break;
  default    : 0;//return(DoubleToStr(period,0));
 }
 return("UNKNOWN");
}//string TFtoStr(int period) {
//end stuff by fxdaytrader


void PeriodBilgisi() {


string LabelChart="PeriodBilgisis";
        ObjectDelete(ChartID(),LabelChart);
     
        LabelChart="PeriodBilgisi";
        ObjectDelete(ChartID(),LabelChart);
        
      //  if ( Period() != PERIOD_M15 ) {
        
        string PeriodBilgisi=Symbol() + " [" + TFtoStr(Period())+"]";
    // if ( ObjectFind(ChartID(),LabelChart) == -1 ) {
     /*
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, CORNER_LEFT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrDarkBlue);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 18);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 5);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 35);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_LEFT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrLimeGreen);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 18);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 4);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 35); */
     

     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER, CORNER_RIGHT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrDarkBlue);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 20);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 205);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 40);  
     
     LabelChart="PeriodBilgisis";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_RIGHT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrLimeGreen);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 20);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 204);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 40);      
     

     LabelChart="SpreadBilgisi";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString(((Ask-Bid)/Point),0));
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_RIGHT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BGCOLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrRed);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 20);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 44);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 80);   


     LabelChart="SureBilgisi";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"00:00");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_RIGHT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BGCOLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 74);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 120);   


     LabelChart="LotBilgisi";
     ObjectCreate(ChartID(),LabelChart, OBJ_LABEL,0 , 0, 0);
     //ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,DoubleToString((Ask-Bid)/Point),0));
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,"LotBilgisi");
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_CORNER,CORNER_RIGHT_LOWER);
     ObjectSetString(ChartID(),LabelChart, OBJPROP_FONT, "Trebuchet MS");
     //ObjectSetInteger(ChartID(),LabelChart, OBJPROP_BGCOLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_COLOR, clrBlack);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_FONTSIZE, 15);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_XDISTANCE, 300);
     ObjectSetInteger(ChartID(),LabelChart, OBJPROP_YDISTANCE, 160);        
          
          
     
         
    /* } else {     
     LabelChart="PeriodBilgisi";
     ObjectSetString(ChartID(),LabelChart,OBJPROP_TEXT,PeriodBilgisi);
     } 
     }*/
  
  

}

////////////////////////////////////////////////////////////////////////
// Skyper Order 
////////////////////////////////////////////////////////////////////////

int min_candle_body = 10;
//int min_distance=8000;
int min_bar_range=100;
int min_distance=200;
int min_bar=3;
//int min_bar=4;


int last_sell_shift=-1;
double last_sell_price=-1;
double last_buy_price=-1;
int last_buy_shift=-1;

extern bool spread_filter=false;//Spread Filter
extern int max_spead = 30;//MaxSpread (zero or negative value means no limit)
double spread;
bool spread_onay = true;


void SkyperOrder() {

if ( order_mode_standart == true ) {

min_bar=3;
 
if ( Period() == PERIOD_M1  ) {
min_candle_body = 10;
//int min_distance=8000;
min_bar_range=100;
min_distance=200;
}


if ( Period() == PERIOD_M5  ) {
min_candle_body = 20;
//int min_distance=8000;
min_bar_range=200;
min_distance=400;
}

if ( Period() == PERIOD_M15  ) {
min_candle_body = 30;
//int min_distance=8000;
min_bar_range=300;
min_distance=600;
}

}


if ( order_mode_defensive == true ) {
if ( Period() == PERIOD_M1  ) min_candle_body = 10;
if ( Period() == PERIOD_M5  ) min_candle_body = 20;
if ( Period() == PERIOD_M15  ) min_candle_body = 30;
min_bar_range=300;
min_distance=600;
min_bar=4;
}

if ( order_mode_aggressive == true ) {
if ( Period() == PERIOD_M1  ) min_candle_body = 10;
if ( Period() == PERIOD_M5  ) min_candle_body = 20;
if ( Period() == PERIOD_M15  ) min_candle_body = 30;
min_bar_range=100;
min_distance=200;
min_bar=2;
}




if ( order_mode == false ) return;

if ( order_mode_buy == false && order_mode_sell == false ) return;

if ( Lot == 0 ) return;


////////////////////////////////////////////////////////////////////////
// Spread Filter 
////////////////////////////////////////////////////////////////////////
   double ask=SymbolInfoDouble(Symbol(),SYMBOL_ASK);
   double bid=SymbolInfoDouble(Symbol(),SYMBOL_BID);
   spread=(ask-bid)/Point;
   //Print("spread",spread,"/",max_spead);
   spread_onay=true;
   if ( spread_filter == true ) {
   if ( spread > max_spead && max_spead > 0 ) {
   spread_onay=false;
   //return;
   }
   }
//////////////////////////////////////////////////////////////////////////
  
  
  if ( spread_onay == false ) return;
  
  
  //Print("SkyperOrder Work");
  
  
    
  if ( order_mode_sell == true && spread_onay == true ) {  

  if ( Open[1] > Close[1] && (Open[1]-Close[1])/Point >= min_candle_body && Close[2] > Open[2]) {
  
  
  bool find=false;
  int say=0;
  int shift=2;
  
  for (int i=2;i<52;i++) {
  
  if ( find == true ) continue;
  
  if ( Close[i] > Open[i] || MathAbs(Close[i]-Open[i])/Point < min_candle_body ) {
  say=say+1;
  } else {
  find=true;
  shift=i;
  }
  
  }
  
  
if ( spread_onay == true && say >= min_bar && find == true && (High[2]-Low[shift])/Point >= min_bar_range && last_sell_shift != shift && ((Bid > last_sell_price && (Bid-last_sell_price)/Point >= min_distance) || last_sell_price == -1 )  ) {
ObjectDelete(ChartID(),"SELL"+Time[2]);
ObjectCreate(ChartID(),"SELL"+Time[2],OBJ_TRENDBYANGLE,0,Time[2],High[2],Time[shift],Low[shift]);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"SELL"+Time[2],OBJPROP_RAY,False);

last_sell_shift=shift;
last_sell_price=Bid;

if ( order_mode_turbo == true ) {

if ( order_mode_reserval == true ) int ticket=OrderSend(Symbol(),OP_SELL,Lot*2,Bid,0,0,0,"",magic,0,clrNONE);
if ( order_mode_trend == true ) int ticket=OrderSend(Symbol(),OP_BUY,Lot*2,Ask,0,0,0,"",magic,0,clrNONE);

} else {

if ( order_mode_reserval == true ) int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);
if ( order_mode_trend == true ) int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);

}


/*
if ( buy_total > 0 ) {
double Lots=(buy_lot/buy_total)*2;
}

if ( sell_total > 0 ) {
double Lots=(sell_lot/sell_total)*2;
}
}*/






}

  
  
  
  }
  
  }
  
  
  
if ( order_mode_buy == true && spread_onay == true ) {  
 
  if ( Close[1] > Open[1] && (Close[1] -Open[1])/Point >= min_candle_body && Open[2] > Close[2] ) {
  
  
  bool find=false;
  int say=0;
  int shift=2;
  
  for (int i=2;i<52;i++) {
  
  if ( find == true ) continue;
  
  if ( Open[i] > Close[i] || MathAbs(Open[i]-Close[i])/Point < min_candle_body ) {
  say=say+1;
  } else {
  find=true;
  shift=i;
  }
  
  }
  
  
if ( spread_onay == true && say >= min_bar && find == true && (High[shift]-Low[2])/Point >= min_bar_range && last_sell_shift != shift && ((Ask < last_buy_price && (last_buy_price-Ask)/Point >= min_distance) || last_buy_price==-1) ) {
ObjectDelete(ChartID(),"BUY"+Time[2]);
ObjectCreate(ChartID(),"BUY"+Time[2],OBJ_TRENDBYANGLE,0,Time[shift],High[shift],Time[2],Low[2]);
ObjectSetInteger(ChartID(),"BUY"+Time[2],OBJPROP_COLOR,clrLimeGreen);
ObjectSetInteger(ChartID(),"BUY"+Time[2],OBJPROP_RAY,False);

last_buy_shift=shift;
last_buy_price=Ask;

if ( order_mode_turbo == true ) {

if ( order_mode_reserval == true ) int ticket=OrderSend(Symbol(),OP_BUY,Lot*2,Ask,0,0,0,"",magic,0,clrNONE);
if ( order_mode_trend == true ) int ticket=OrderSend(Symbol(),OP_SELL,Lot*2,Bid,0,0,0,"",magic,0,clrNONE);

} else {

if ( order_mode_reserval == true ) int ticket=OrderSend(Symbol(),OP_BUY,Lot,Ask,0,0,0,"",magic,0,clrNONE);
if ( order_mode_trend == true ) int ticket=OrderSend(Symbol(),OP_SELL,Lot,Bid,0,0,0,"",magic,0,clrNONE);


}

/*
if ( order_mode_turbo == true ) {
if ( buy_total > 0 ) {
double Lots=(buy_lot/buy_total)*2;
}

if ( sell_total > 0 ) {
double Lots=(sell_lot/sell_total)*2;
}
}*/





}  
  
  
  }
  
  
  }





} // İşlem Açma Sorunum olduğu için bu işi otomatik yapmaya karar verdim başka çarem kalmadı, senelerce aynı döngü dönüp duruyor. Haberlerde çok fazla tersde kalıp işlem açıyorum.
/////////////////////////////////////////////////////////////////////////////////////////


int GeriCekilmeSistemi(int lts){

int lty=0;

   switch(lts)                                // 
     {                                          // 
      case 13 : lty=21;    break;//
      case 21 : lty=50;    break;
      //case 50 : lty=13;    break;
      default: lty=13;   // 
     } 
     
     
return lty;
};
