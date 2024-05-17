import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) 
  {
    return Scaffold(
        appBar: AppBar(
          title:const Text('Home' ,style: TextStyle(
              fontWeight: FontWeight.bold, // Make the text bold
            ),),
          backgroundColor: Colors.green,
          centerTitle: true,

        ),
        backgroundColor: Colors.grey,
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ServiceCard(
                title: 'Computer Vision',
                description:
                    'Analyze and extract insights from images and videos.',
              ),
              ServiceCard(
                title: 'Natural Language Processing (NLP)',
                description:
                    'Understand and process human language for various tasks.',
              ),
              ServiceCard(
                title: 'Longformer Language Models (LLM)',
                description: 'Efficiently handle long-text processing tasks.',
              ),
              ServiceCard(
                title: 'Flutter Android App Development',
                description:
                    'Build robust, cross-platform mobile applications.',
              ),
              ServiceCard(
                title: 'Machine Learning',
                description:
                    'Develop intelligent systems that learn from data.',
              ),
              ServiceCard(
                title: 'Deep Learning',
                description: 'Build deep neural networks for complex tasks.',
              ),
              ServiceCard(
                title: 'Data Cleaning',
                description:
                    'Ensure data accuracy and consistency for analysis.',
              ),
              ServiceCard(
                title: 'Data Visualization',
                description:
                    'Create compelling visual representations of data.',
              ),
              ServiceCard(
                title: 'Feature Engineering',
                description:
                    'Extract relevant features from raw data for ML models.',
              ),
              ServiceCard(
                title: 'Fine-tuning LLM models',
                description:
                    'Fine-tune pre-trained language models for specific tasks.',
              ),
            ],
          ),
      
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final String description;

  const ServiceCard({super.key, 
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.only(bottom: 16.0),
       color: Colors.blue, 
      child: Padding(
        
        padding:const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Text(
              title,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
