import 'package:firebase_db/bussiness_logic/fetch_data_bloc/fetch_data_bloc.dart';
import 'package:firebase_db/bussiness_logic/fetch_data_bloc/fetch_data_event.dart';
import 'package:firebase_db/bussiness_logic/fetch_data_bloc/fetch_data_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});
  @override
  State<StatefulWidget> createState() {
    return UserScreenWidget();
  }
}

class UserScreenWidget extends State<UserScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FetchDataBloc>().add(FetchDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("User Data"),centerTitle: true,),
      body: Column(
        children: [
          BlocConsumer<FetchDataBloc, FetchDataState>(
              builder: (context, state) {
                if (state is FetchDataInitState ||
                    state is FetchDataLoadingState) {
                  return CircularProgressIndicator();
                }
                if (state is FetchDataErrorModel) {
                  return Text(state.error.toString());
                }
                if (state is FetchDataLoadedState) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: state.model.length,
                        itemBuilder: (context, index) {
                          return Card(
                            color: Colors.white,
                            margin:
                                EdgeInsets.only(left: 7, right: 7, bottom: 5),
                            child: Container(
                              margin: EdgeInsets.only(left: size.width*0.04),
                              alignment: Alignment.centerLeft,
                              width: size.width * 0.8,
                              height: size.height * 0.1,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.model[index].firstName.toString()),
                                  Text(state.model[index].lastName.toString()),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                }
                return Container();
              },
              listener: (context, state) {})
        ],
      ),
    );
  }
}
