import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jameel/features/authentication/presentation/pages/authentication_page.dart';

import 'core/error/failures.dart';
import 'features/authentication/presentation/bloc/bloc.dart';
import 'features/find_shops/presentation/bloc/bloc.dart';
import 'features/find_shops/presentation/bloc/get_shops_bloc.dart';
import 'injector.dart';

void main() {
  Injector.setup();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<VerifyPhoneBloc>(
        create: (context) => Injector.resolve<VerifyPhoneBloc>()..add(AppStarted()),
        child: AuthenticationBuilder(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _execute() {
    BlocProvider.of<GetShopsBloc>(context).add(NearbyShopsRequested(10.0));
  }

  @override
  Widget build(BuildContext context) {
    DateUtil dateUtil = DateUtil();
    print(dateUtil.daysInMonth(2, 2020));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: BlocListener<GetShopsBloc, GetShopsState>(
        listener: (context, state) {
          if (state is GetShopsFail) {
            final failure = state.failure;
            if (failure is SearchFailure) {
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
                content: Text(failure.message),
              ));
            }
          }
          if (state is GetShopsSuccess) {
            Scaffold.of(context)
                .showSnackBar(SnackBar(content: Text('succeeded')));
          }
        },
        child: BlocBuilder<GetShopsBloc, GetShopsState>(
          builder: reservationsBuilder,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _execute,
        tooltip: 'execute',
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget reservationsBuilder(BuildContext context, GetShopsState state) {
    if (state is GetShopsSuccess) {
      return ListView.builder(
        itemCount: state.shopList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: Colors.green[100],
              ),
              padding: EdgeInsets.all(40.0),
              child: Column(
                children: <Widget>[
                  Text(
                    state.shopList[index].name.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    state.shopList[index].shopID.toString(),
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
