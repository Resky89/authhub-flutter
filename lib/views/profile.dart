import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Image.asset(
          'lib/assets/logo.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        actions: [
          SizedBox(width: 24),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.45],
            colors: [
              Color(0xFF3A2F0B),
              Colors.black,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.delete_outline, color: Colors.grey),
                  Text(
                    'PROFILE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(width: 24),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFFFFB703),
                              width: 2,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 60.0,
                            backgroundImage:
                                AssetImage('assets/profile_image.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Color(0xFFFFB703),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Jhon Doe',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              Shadow(
                                blurRadius: 10.0,
                                color: Color(0xFFFFB703),
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(
                          Icons.edit,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Divider(color: Colors.grey[800]),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                minLeadingWidth: 20,
                leading: Icon(Icons.phone, color: Colors.grey[600], size: 20),
                title: Text(
                  '+62xxxxxxxxxx',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                  ),
                ),
              ),
              ListTile(
                contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                minLeadingWidth: 20,
                leading: Icon(Icons.email, color: Colors.grey[600], size: 20),
                title: Text(
                  'jhondoe@gmail.com',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 20,
                  ),
                ),
              ),
              Spacer(),
              Divider(color: Colors.grey[800]),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(33, 255, 0, 0),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.red[900]!, width: 1),
                    ),
                    elevation: 0,
                  ),
                  onPressed: () {
                    // Implementasi logout
                  },
                  child: Text(
                    'Log Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
