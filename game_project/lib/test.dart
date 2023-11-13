Stack(
      children: [
        Positioned.fill(
            top: 50, // Top margin per card
            child: Container(
              child: Text(
                'data ',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
              ),
            )),
        Positioned.fill(
            top: 250,
            child: Container(
              child: Text(
                'data ',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(80),
                ),
              ),
            )),
      ],
    )