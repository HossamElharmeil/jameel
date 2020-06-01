import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injector.dart';
import '../../../../main.dart';
import '../../../find_shops/presentation/bloc/bloc.dart';
import '../bloc/bloc.dart';

class AuthenticationPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AuthenticationBuilder();
  }
}

class AuthenticationBuilder extends StatelessWidget {
  const AuthenticationBuilder({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication Screen"),
      ),
      body: BlocListener<VerifyPhoneBloc, VerifyPhoneState>(
        bloc: BlocProvider.of<VerifyPhoneBloc>(context),
        listener: (listenerContext, state) {
          if (state is EnteringVerificationCode) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (materialPageRouteContext) =>
                        BlocProvider<VerifyPhoneBloc>(
                            create: (blocProviderContext) =>
                                BlocProvider.of<VerifyPhoneBloc>(context),
                            child:
                                CodeVerificationPage(state.verificationID))));
          }
          if (state is VerifyPhoneSuccess){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (materialPageRouteContext) =>
                        BlocProvider<GetShopsBloc>(
                            create: (context) =>
                                Injector.resolve<GetShopsBloc>()..add(NearbyShopsRequested(25.0)),
                            child:
                                MyHomePage(title: 'Nearby Shops',))));
          }
          print(state.toString());
        },
        child: BlocBuilder<VerifyPhoneBloc, VerifyPhoneState>(
          builder: (context, state) => Center(
            child: RaisedButton(
              child: Text('Authenticate'),
              onPressed: () {
                BlocProvider.of<VerifyPhoneBloc>(context)
                    .add(PhoneEntered('+919852954321'));
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.forward),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CodeVerificationPage(null),
            ),
          );
        },
      ),
    );
  }
}

class CodeVerificationPage extends StatefulWidget {
  final verificationID;

  const CodeVerificationPage(this.verificationID, {Key key}) : super(key: key);
  @override
  _CodeVerificationPageState createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter SMS code'),
      ),
      body: BlocListener<VerifyPhoneBloc, VerifyPhoneState>(
        listener: (context, state) {
          if (state is VerifyPhoneSuccess) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => BlocProvider<GetShopsBloc>(
                          create: (context) => Injector.resolve<GetShopsBloc>()
                            ..add(NearbyShopsRequested(10.0)),
                          child: MyHomePage(
                            title: 'Nearby shops',
                          ),
                        )));
          }
          print(state.toString());
        },
        child: Center(
          child: TextFormField(
            controller: _controller,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<VerifyPhoneBloc>(context)
              .add(CodeEntered(widget.verificationID, _controller.text));
        },
      ),
    );
  }
}
