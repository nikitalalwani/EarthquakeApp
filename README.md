# EarthquakeApp


1) What  was the purpose, goal or objective of the project? Explain what use cases this project solved What does the code do? 

This apps purpose was to provide detailed information about the earthquakes which took place recently along with providing other details such as magnitude,type or time of earthquake.

Use Cases : 

- You can view the whole list of earthquake details
- You can view the whole list of earthquakes in a map pinned
- You can directly go to the detailed web page of a particular earthquake 
- You can sort the list in different ways (Magnitude, Date ascending, Date descending,None(Default))

2) What and Why did you choose this technology? 

I chose swift because it is safer as it has built in error handling. The syntax is comparatively easier to write and is flexible. I dont need to create separate interface and implementation files like Objective-C which saved a lot of time. Swift has so many different features such as enums.
In addition to that, swift is high in performance compared to Objective-C



3) What architect or design choices did you make for the project? 

- First and foremost design choice I made was to use MVVM design pattern. Since, MVVM is something new, I decided to give it a try. MVVM solves the problem of Massive View Controllers and the viewmodels are whole in it itself. They perform all the the tasks and just provide view with the data that needs to displayed. This makes viewmodel easily testable and independent
- Another choice I made is that I create a hierarchy of view models so that every viewmodel's responsibilities are
   separate and no two viewmodel's are performing the same task
- I used protocols to communicate between ViewModels and ViewController
- I also used UserDefaults for persisting some keys
- I have implemented tableviews with self sizing tableview cells and the app looks good in both the orientations.
- In addition to that, I have used webViews, extensions, enums, completion handlers etc.
- I have also added few basic automation test cases.
- I have added autolayout to make screen appear almost perfect in both the orientations
<<<<<<< HEAD
=======
- A utility class that takes care of all miscellaneous tasks or methods, store strings, enums, extensions etc.
>>>>>>> a561a19... Readme


Why are you proud of this project? 

I am proud of this project because it helped me understand one of the most important design pattern i.e MVVM. I faced a lot of difficulties in understanding the communication between VM and views, but I was able to make a perfectly working project. I have used features such as protocols and enums that are significant areas of iOS.
I also made a good use of corelocation library.
The sorting functionality was particularly complex to implement, but there were many things to learn and may use cases to consider.

Future scope - 

Core Data for offline maintenance
Unit tests on View Models
Getting data based on user's location

Below is the viewmodel hierarchy -

                                            Generic ViewModel               Detail ViewModel
                                              _________|  |_________                
                                              |                  |
                                              |                  |
                                        HomeViewModel          MapViewModel
                                                
