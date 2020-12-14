import 'package:flutter/material.dart';

class AlertDialogCustom {
  static void showAlert(BuildContext context, String text) {
    var alert = new AlertDialog(
      content: Container(
        child: Row(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
        new FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "OK",
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  static void showAlertChangePage(
      BuildContext context, String text, String page) {
    var alert = new AlertDialog(
      content: Container(
        child: Row(
          children: <Widget>[Text(text)],
        ),
      ),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, page);
            },
            child: Text(
              'Aceptar',
              style: TextStyle(color: Colors.blue),
            ))
      ],
    );

    showDialog(
        context: context,
        builder: (_) {
          return alert;
        });
  }

  static void showInfoPeliculas(BuildContext context, dynamic movie) {
    if (movie == null) {
      return;
    } else {
      var alert = new AlertDialog(
        content: Container(
          child: Column(
            children: <Widget>[
              Text(
                movie['title'],
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
                movie['classification'],
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
                movie['trailer'],
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
                movie['website'],
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
                movie['releaseDate'],
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
                movie['director'],
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
                movie['originalLanguage'],
                style: TextStyle(fontSize: 15.0),
              ),
              Text(
                movie['sypnosys'],
                style: TextStyle(fontSize: 15.0),
              ),
              RaisedButton(
                child: Container(
                  child: Text('Recervación'),
                  padding:
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                elevation: 0.0,
                color: Colors.deepPurple,
                textColor: Colors.white,
                onPressed: () => {},
              )
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              ))
        ],
      );

      showDialog(
          context: context,
          builder: (_) {
            return alert;
          });
    }
  }
}
