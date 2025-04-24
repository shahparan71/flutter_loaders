import 'package:flutter/material.dart';
import 'package:flutter_loaders/flutter_loaders.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Loaders Demo',
      home: Scaffold(
        appBar: AppBar(title: const Text('Loaders Demo')),
        body: Center(
          child: Column(
            children: [

              const SizedBox(height: 10,),
              const LoaderCube(color: Colors.blue),
              const SizedBox(height: 30,),
              const LoaderBounce(color: Colors.blue),
              const SizedBox(height: 10,),
              const LoaderPulse(),
              const SizedBox(height: 10,),
              const LoaderRing(color: Colors.indigo),
              const SizedBox(height: 10,),
              const LoaderWave(
                colors: [Colors.red, Colors.orange, Colors.green, Colors.blue, Colors.purple],
                size: 80,
              ),

              /*SizedBox(height: 50,),
              SpinnerLoader(
                size: 100,
                color: Colors.teal,
              ),
              SizedBox(height: 50,),
              MultiRingLoader(),*/
              /*const AtomicParticlesLoader(
                size: 180,
                duration: Duration(seconds: 4),
              ),*/
              //PendulumAnimation(),
              NewtonsCradle(),
            ],
          ),
        ),
      ),
    );
  }
}
