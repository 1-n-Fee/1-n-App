
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:provider/provider.dart';
import 'package:side_app/constants.dart';
import '../main.dart';
import 'package:side_app/chat/chatScreen.dart';
import 'package:flutter/cupertino.dart';
import '../main.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';

import 'package:flutter/painting.dart';
import 'locationSearch.dart';
import 'deliverySearch.dart';
class name{
  var s="안누름";
  name(this.s);
}



class map extends StatefulWidget {

  const map({Key? key}) : super(key: key);

  @override
  State<map> createState() => _mapState();
}

class _mapState extends State<map> {


  Completer<GoogleMapController> _controller = Completer();
  final textcontroller=TextEditingController();
  var z= name ("안녕");
  List<Marker> makers=[];
  List<int>count=[];
  int cnt=2;
  // 초기 카메라 위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.540905, 127.078595),
    zoom: 15,

    //확대
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.4943, 126.8254),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makers.add(Marker(
        markerId: MarkerId("건국대 신공학관"),
        draggable: true,
        infoWindow: InfoWindow(
            title: '건국대 신공학관',
            snippet: '하윙'
        ),
        onTap: ()=>setState(() {
          cnt=5;
        }),
        position: LatLng(37.540905, 127.078595)
    ));

    makers.add(Marker(
        markerId: MarkerId("건국대 공학관"),
        draggable: true,
        infoWindow: InfoWindow(
            title: '건국대 공학관',
            snippet: '하윙'
        ),
        onTap: ()=>setState(() {

          z.s="바윙";
          cnt=3;
        }),
        position: LatLng(37.535905, 127.078595)
    ));


    count.add(1);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body:SingleChildScrollView(
          child:Column(

        children: [

          Padding(padding: EdgeInsets.only(top: 8)),








Container(
  color:Color(0xFFE0E0E0) ,
  child:   Row(children: [

    context.watch<maptab>().tab==1?TextButton(onPressed: (){
      context.read<maptab>().altertab0();

    }, child: Text("X"),style: TextButton.styleFrom(

        primary: Colors.black
    ),) :Text(""),

    SizedBox(
      width: context.watch<maptab>().tab==0?410:346,

      child: DecoratedBox(
          decoration:BoxDecoration(

          ),

          child:TextField(
            onTap: (){
              context.read<maptab>().altertab1();
            },
         autofillHints: [AutofillHints.name],
            onEditingComplete: ()=>context.read<maptab>().altertab0(),
            controller: textcontroller,

            decoration: InputDecoration(
              filled: true,

              border: InputBorder.none,
              hintText: '장소 검색',
            ),
          )) ,

    )

  ],),
)
      ,


          context.watch<maptab>().tab==0?firstui(textcontroller:textcontroller)
         :secondui(textcontroller:textcontroller)

          ,
        Padding(padding: EdgeInsets.only(top: 5)),




        ],
      )
      )
      ,

      // floatingActionButton을 누르게 되면 _goToTheLake 실행된다.
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          //plusbutton

          Navigator.push(context,
          MaterialPageRoute(builder: (context)
          {
            return plusbutton();
          }));
        },
        child:Icon(Icons.edit),
      ),
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
    setState(() {
      z.s="바윙";
    });
  }
}


class firstui extends StatefulWidget {
  const firstui({Key? key,this.textcontroller}) : super(key: key);
final textcontroller;
  @override
  State<firstui> createState() => _firstuiState();
}

class _firstuiState extends State<firstui> {




  void addmarker(location){

    setState(() {

    });



  }


  Completer<GoogleMapController> _controller = Completer();
  // 초기 카메라 위치
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.540905, 127.078595),
    zoom: 15,

    //확대
  );
  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.4943, 126.8254),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<markerdata>().initmarker();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        SizedBox(
          width: double.infinity,
          height: 250,
          child:GoogleMap(
            buildingsEnabled: false,
            onTap: (idx){
     context.read<markerdata>().addmarker(idx);
 showDialog(context: context, builder: (BuildContext context){
   return AlertDialog(
     title: Text("장소 입력"),
     content: Text("장소를 확정하시겠습니까?"),
     actions: [
       TextButton(onPressed: (){}, child: Text("OK")),
       TextButton(onPressed: (){},child: Text("Cancel"),)
     ],
   );

 });
            },
            markers: Set.from(context.watch<markerdata>().marker),
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex, // 초기 카메라 위치
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ) ,
        ),
        Padding(padding: EdgeInsets.only(top: 8)),
        Divider(height: 1.0,color: Colors.black,),


        SizedBox(
          height: 150
          ,child:
        CustomScrollView(
          slivers: [

            SliverFixedExtentList(
              itemExtent: 60.0,
              delegate: SliverChildBuilderDelegate((BuildContext context,int index){
                return Padding(padding: EdgeInsets.only(top: 1),
                  child: ListTile(
                    leading: Icon(Icons.meeting_room,color: Colors.blueAccent,),
                    title: Text("제목 ->ㄱㄱ"),
                    subtitle: Text("참여인원 2명"),
                    trailing: TextButton(onPressed: (){


                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return inforamtion();
                      }));
                    },
                      child: Text("참여하기"),),
                  ),);
              },childCount: context.watch<markerdata>().cnt),
            )


          ],) ,
        ),
        Divider()





      ],);
  }
}

class secondui extends StatefulWidget {
  const secondui({Key? key,this.textcontroller}) : super(key: key);
  final textcontroller;
  @override
  State<secondui> createState() => _seconduiState();
}

class _seconduiState extends State<secondui> {

 List<String>name=["한식","중식","양식","분식","카페","야식","피자","기타"];
 List<Icon>icon=[Icon(Icons.dining),Icon(Icons.ramen_dining),Icon(Icons.restaurant),
 Icon(Icons.dinner_dining),Icon(Icons.local_cafe),Icon(Icons.fastfood),Icon(Icons.local_pizza),Icon(Icons.hail)];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
        height: 70,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: name.length,
              itemBuilder: (BuildContext context,int index){
            return Padding(padding: EdgeInsets.only(left:10),
            child: Column(children: [
              IconButton(onPressed: (){

              },

                icon: icon[index],

              ),Text(name[index])
            ],)

            );

          })


        )

, Divider(height: 1.0,color: Colors.black,),
 Padding(padding: EdgeInsets.only(top:10)),

        SizedBox(
          height: 500,
          child: ListView.builder(

              itemCount: 4,
              itemBuilder: (BuildContext context,int index){
                return Padding(padding: EdgeInsets.only(left:10),
                    child:ListTile(
                      title: Text("건대 맛집"),
                      leading: Icon(Icons.location_on),
                    )
                    
                );

              })

          ,
        )


      ],
    );
  }
}

class thirdui extends StatefulWidget {
  const thirdui({Key? key}) : super(key: key);

  @override
  State<thirdui> createState() => _thirduiState();
}

class _thirduiState extends State<thirdui> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class inforamtion extends StatefulWidget {
  const inforamtion({Key? key}) : super(key: key);

  @override
  State<inforamtion> createState() => _inforamtionState();
}

class _inforamtionState extends State<inforamtion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child:Column(

          children: [

            SizedBox(
                height:
                25),
            SizedBox(height: 150,

                child:
                Image.asset('assets/images/food_1.png',fit: BoxFit.fill,width: double.infinity,)


            ),
            Padding(padding: EdgeInsets.only(top: 1)
              ,child:   Divider(color: Colors.black,height: 1.0,)
              ,),

            ListTile(title: Text("건대 맛집",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),trailing:
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [



                IconButton(onPressed: (){

                  Navigator.of(context,rootNavigator: true).push(
                      CupertinoPageRoute<void>(builder: (BuildContext context)=>comment()));

                }, icon: Icon(Icons.chat_outlined,color: Colors.black,size: 25,))
,
                Padding(padding: EdgeInsets.only(left: 10)),
                Icon(Icons.heart_broken_sharp,color: Colors.red,size: 25,)
              ],
            )
              ,
            ),

            Padding(padding: EdgeInsets.only(left: 11)
              ,
              child: SizedBox(
                height: 25,
                child: Row(
                  children: [
                    Icon(Icons.star,color: Colors.yellow,),
                    Padding(padding: EdgeInsets.only(left: 8),
                      child: Text("4.5(0)"),)
                  ],
                ),
              ),

            ),

            Padding(padding: EdgeInsets.only(top: 20)),

            SizedBox(
              height: 25,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)
                    ,child: Text("최소주문   |    ",style: TextStyle(
                        fontSize: 15
                    ),),),
                  Text("14000원    ",style: TextStyle(
                      fontSize: 15
                  ),),


                  Icon(Icons.arrow_forward),

                  Padding(padding: EdgeInsets.only(left: 10),
                    child: Text("7000원",style: TextStyle(fontSize: 15,color: Colors.redAccent)),),




                ],),
            ),


            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)
                    ,child: Text("배달요금   |      ",style: TextStyle(
                        fontSize: 15
                    ),),),
                  Text("3000원    ",style: TextStyle(
                      fontSize: 15
                  ),),


                  Icon(Icons.arrow_forward),

                  Padding(padding: EdgeInsets.only(left: 10),
                    child: Text("1500원",style: TextStyle(fontSize: 15,color: Colors.redAccent)),)


                  ,




                ],),
            ),


            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)
                    ,child: Text("현재인원   |      ",style: TextStyle(
                        fontSize: 15
                    ),),),
                  Text("1명    ",style: TextStyle(
                      fontSize: 15
                  ),),








                ],),
            ),


            SizedBox(
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)
                    ,child: Text("배달시간   |      ",style: TextStyle(
                        fontSize: 15
                    ),),),
                  Text("30~40분   ",style: TextStyle(
                      fontSize: 15
                  ),),








                ],),
            ),

            SizedBox(
              height: 30,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.only(left: 20)
                    ,child: Text("가게위치   |      ",style: TextStyle(
                        fontSize: 15
                    ),),),
                  Text("1.5km   ",style: TextStyle(
                      fontSize: 15
                  ),),








                ],),
            ),

            Divider(height: 5,color: Colors.black,),



          ],
        )
      )
      ,
      bottomNavigationBar: BottomAppBar(
        color: mainColor,

        child:

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [TextButton(onPressed: (){}, child: Text("참여하기",
          style: TextStyle(color: Colors.white70,
          fontSize: 20),))],
        )
      )
      ,
    )
      ;
  }
}



class comment extends StatefulWidget {
  const comment({Key? key}) : super(key: key);

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  final controllerComment=TextEditingController();
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(title: Text("댓글 "+context.watch<comments>().datas.length.toString()),),
        body: Column(
          children:<Widget>[
            Flexible(
              child:Stack(children: [Positioned(top:0.0,child: Text("")),
                buildItem(index:3)],),

            ),Divider(height: 1.0,color: Colors.black,),
            Container(decoration:BoxDecoration(color: Theme.of(context).cardColor),
              child: Row(children: [Flexible(child:TextField(controller: controllerComment,decoration: InputDecoration(hintText: "댓글을 남겨보세요!") )
              ),TextButton(onPressed: (){
                print(controllerComment.text);

                //context.read<boardData>().addcomment(context.read<boardData>().userData[widget.index],controllerComment.text.toString());
                context.read<comments>().addcomment("고건국", controllerComment.text);
                controllerComment.clear();
              }, child: Text("등록",),style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  primary: Colors.white
              ),)
              ],),)
          ],
        )

    );


  }
}


class buildItem extends StatefulWidget {
  const buildItem({Key? key,this.data,this.index}) : super(key: key);
  final data;
  final index;
  @override
  State<buildItem> createState() => _buildItemState();
}

class _buildItemState extends State<buildItem> {
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState

    super.setState(fn);
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: context.watch<comments>().datas.length,
      itemBuilder: (BuildContext context,int index)=>
          Column(children: [ListTile(
            leading: Icon(Icons.person,size: 30,),
            title:Text(context.watch<comments>().datas[index].name,style: TextStyle(fontSize: 15),),
            subtitle: Text(context.watch<comments>().datas[index].content),
          ),Divider(height: 1,color: Colors.black,)],) ,
    );
  }
}


class plusbutton extends StatefulWidget {
  const plusbutton({Key? key}) : super(key: key);

  @override
  State<plusbutton> createState() => _plusbuttonState();
}

class _plusbuttonState extends State<plusbutton> {

  List<String>drop=['1','2','3','4','5','6','7','8','9'];
  List<String>menu=['짜장면','탕수육','불닭볶음면'];
  String selectedmenu='짜장면';
  String selected='1';
  var moem=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("모임 만들기"),backgroundColor: mainColor,),
      body: SingleChildScrollView
        (
        child: Column(
          children: [


            Padding(padding: EdgeInsets.only(top: 5),
      ),
            SizedBox(height: 150,

              width: double.infinity,
              child: Container(
                color: Colors.grey[300],
                child: TextButton(
                  onPressed: (){},
                  child: Text("사진 추가"),
                ),
              ),
            )

            ,

            Row(children: [

              SizedBox(
                width: 80,
                height: 20,
                child: Padding(padding: EdgeInsets.only(left: 10),
                  child: Text("모임 이름",style: TextStyle(color: Colors.black
                      ,fontSize: 15),
                  ),),
              ),



              SizedBox(
                width: 200,
                height:48,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "모임 이름을 입력하세요",
                    border: InputBorder.none
                    ,
                  ),style: TextStyle(fontSize: 15),
                ),
              )

              ,

            ],),




            Row(children: [

             SizedBox(
               width: 80,
               height: 20,
               child: Padding(padding: EdgeInsets.only(left: 10),
               child: Text("배달 장소",style: TextStyle(color: Colors.black
               ,fontSize: 15),
               ),),
             ),



        SizedBox(
          width: 260,
          height:48,
          child: TextField(
            decoration: InputDecoration(
              hintText: "주문할 가게를 입력하세요",
            border: InputBorder.none
            ,
            ),style: TextStyle(fontSize: 13),
          ),
        )

        ,
             ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: mainColor),onPressed: (){


               Navigator.push(context,
                   MaterialPageRoute(builder: (context)
                   {
                     return deliverysearch();
                   }));
             }, child: Row(children: [Icon(Icons.search)],)),

           ],),


        Row(children: [

          SizedBox(
            width: 80,
            height: 20,
            child: Padding(padding: EdgeInsets.only(left: 10),
              child: Text("모임 장소",style: TextStyle(color: Colors.black,
              fontSize: 15),),),
          ),



          SizedBox(
            width: 260,
            height: 48,
            child: TextField(
            controller: context.watch<markerdata>().moem
            ,decoration: InputDecoration(
                hintText: "모임 장소를 입력하세요",
                border: InputBorder.none
                ,
              ),style: TextStyle(fontSize: 13),
            ),
          )

          ,
          ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: mainColor),onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)
                {
                  return locationSearch();
                }));

          }, child: Row(children: [Icon(Icons.search)],)),
      
        ],)
           ,
           Row(children: [
             SizedBox(width: 80,
             height: 20,
             child: Padding(padding: EdgeInsets.only(left: 10),
             
             child: Text("최소 인원",style: TextStyle(color: Colors.black,
             fontSize: 15),),
             ),),


             DropdownButtonHideUnderline(child:
             DropdownButton(
                 value: selected,
                 items: drop.map((value){
                   return DropdownMenuItem(
                       value: value,child: Text(value,));
                 }).toList(), onChanged: (idx)
             {
               setState(() {
                 selected=idx.toString();
               });
             }))
,
             Text("명",style: TextStyle(color: Colors.black,fontSize: 15),)
             ,
             SizedBox(
               width: 30,
               child: TextField(
                 inputFormatters: [LengthLimitingTextInputFormatter(1)],
                 style:TextStyle(fontSize: 18),
                 decoration: InputDecoration(
                   border: InputBorder.none,

                 ),

               ),
             ),

           ],)

           ,

            Row(children: [
              SizedBox(width: 80,
                height: 20,
                child: Padding(padding: EdgeInsets.only(left: 10),

                  child: Text("배달 금액",style: TextStyle(color: Colors.black,
                  fontSize: 15),),
                ),),

              
              Text("3000",style: TextStyle(color: Colors.red,
              fontSize: 15),)
              ,
              Padding(padding: EdgeInsets.only(left: 3)),
              Text("원",style: TextStyle(fontSize: 15),),
              SizedBox(
                width: 30,
                child: TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  style:TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,

                  ),

                ),
              ),

            ],),

            Row(children: [
              SizedBox(width: 80,
                height: 20,
                child: Padding(padding: EdgeInsets.only(left: 10),

                  child: Text("주문 메뉴",style: TextStyle(color: Colors.black,
                      fontSize: 15),),
                ),),


              DropdownButtonHideUnderline(child:
              DropdownButton(
                  value: selectedmenu,
                  items: menu.map((value){
                    return DropdownMenuItem(
                        value: value,child: Text(value,));
                  }).toList(), onChanged: (idx)
              {
                setState(() {
                  selectedmenu=idx.toString();
                });
              }))
              ,

              SizedBox(
                width: 30,
                child: TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  style:TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,

                  ),

                ),
              ),

            ],),

            Row(children: [
              SizedBox(width: 80,
                height: 20,
                child: Padding(padding: EdgeInsets.only(left: 10),

                  child: Text("배달 시간",style: TextStyle(color: Colors.black,
                      fontSize: 15),),
                ),),


              Text("30~40",style: TextStyle(color: Colors.red,
                  fontSize: 15),)
              ,
              Padding(padding: EdgeInsets.only(left: 3)),
              Text("분",style: TextStyle(fontSize: 15),),
              SizedBox(
                width: 30,
                child: TextField(
                  inputFormatters: [LengthLimitingTextInputFormatter(1)],
                  style:TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                    border: InputBorder.none,

                  ),

                ),
              ),

            ],),




            Row(children: [
        SizedBox(width: 80,
          height: 20,
          child: Padding(padding: EdgeInsets.only(left: 10),

            child: Text("가게 위치",style: TextStyle(color: Colors.black,
                fontSize: 15),),
          ),),


        Text("1.5",style: TextStyle(color: Colors.red,
            fontSize: 15),)
        ,
        Padding(padding: EdgeInsets.only(left: 3)),
        Text("km",style: TextStyle(fontSize: 15),),
        SizedBox(
          width: 30,
          child: TextField(
            inputFormatters: [LengthLimitingTextInputFormatter(1)],
            style:TextStyle(fontSize: 18),
            decoration: InputDecoration(
              border: InputBorder.none,

            ),

          ),
        ),

      ],),
            


          ],
        ),
      ),
bottomNavigationBar: BottomAppBar(
    color: Colors.white60,
    child:
SizedBox(
  width: double.infinity,
  child:
  Container(
    child: TextButton(onPressed: (){}, child: Text("만들기",
      style: TextStyle(color: Colors.black,
          fontSize: 20),))
  )
  ,
)

),
    );
  }
}



