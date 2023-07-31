import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  const SecondRoute({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: ManipulationPage(),
    );
  }
}

class ManipulationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('images/background.png')
              )
          ),
          child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(

                backgroundColor: Colors.transparent, // 투명으로 해도 appBar 자체 그림자 생김
                elevation: 0.0, // appBar 그림자 0.0 해주면 완전 투명됨
              ),

              body: SingleChildScrollView(
                padding: EdgeInsets.all(30),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[

                      Text(
                        '회원정보를 입력하세요',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize:24,

                        ),),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Name',
                          hintText: 'Leslie Alexander',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color(0xff3C62DD))
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          hintText: 'lesliealexander@example.com',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color(0xff3C62DD))

                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      Container(
                          child: Column(
                            children: [
                              Text('8자리 이상의 영문,숫자,특수문자를 조합',
                              ),
                            ],
                          )
                      ),

                      TextFormField(
                        obscureText : true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: '********',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color(0xff3C62DD))
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),

                      TextFormField(
                        obscureText : true,
                        decoration: InputDecoration(
                          labelText: 'Confirm password',
                          hintText: '********',
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color:Color(0xff3C62DD))
                          ),
                        ),
                      ),

                      SizedBox(height: 20,),
                    ],),
                ),
              )
          ),
        )
    );
  }
}