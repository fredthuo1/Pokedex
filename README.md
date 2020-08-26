![icon](./Pokédex/Assets.xcassets/icon.imageset/icon.png)

![Xcode 11.3](./Pokédex/Assets.xcassets/Xcode-11.3-blue.imageset/Xcode-11.3-blue.png)
![Swift 5.0](./Pokédex/Assets.xcassets/Swift-5.0-orange.imageset/Swift-5.0-orange.png)

# Pokédex
For this project; students will be tasked with creating a simple __Pokédex__.\
See `Pokédex_Screenshots.pdf` for an example of what the basic interface should look like at various points.  
See `Pokédex_Demo.mov` for an example user experience.

### Objectives
* Perform `GET` calls using a custom service client
* Manage flat file persistence of objects retrieved from service
* Utilize *UI components* such as `UITableView`, `UIImage`, `UIActivityIndicatorView` and `UIStoryboardSegue`
* Build on concepts introduced in the previous project(s)

### Appflow
The user experience should present as the following:
* The user opens the App to a list of downloaded Pokémon names
* When the user selects a name, they are presented with a screen that displays information about the Pokémon including:
    * An image of the Pokémon's sprite
    * The Pokémon's name (i.e. species, no nicknames)
    * The Pokémon's height
    * The Pokémon's types
    * A button that when tapped; plays the Pokémon's cry 

### Tasks
This project will require students to do several things:
* Build the necessary user interface elements in `List.storyboard` and `Detail.storyboard`
* __Connect__ those interface elements to `ListViewController.swift`  and `DetailViewController.swift` as `IBAction`s and `IBOutlet`s as appropriate
* __Conform__ `ListViewController` to the `ListModelDelegate`, `UITableViewDelegate`, and `UITableViewDataSource` protocols
* Finish/Add methods in:
    * `ListModel.swift`
    * `ListViewController.swift`
    * `DetailViewController.swift`
    * `PokéAPIServiceClient.swift`
    * `PokémonPersistence.swift`

### Requirements
* Autolayout for `iPhone Portrait Mode` is required
* __MVC__ is required; view logic should only be present in the ViewControllers, and likewise, business logic should be kept exclusively in the data-models
* The criterion of __ALL__ `TODO` tasks outlined in the project template __MUST__ be satisfied

### Notes
* To test that the service and persistence layers are functioning properly:
    * Set breakpoints to validate control flow
    * Delete the app and reinstall to see a download or persistence check run for the "first time"
* Places where code should be implemented are marked with `TODO` comments and will appear as warnings in the Issue navigator when building the project
* A __SwiftLint__ build script has been added for convenience
* This project will utilize some pre-packaged objects from our `ObjectLibrary` package:
    * `Pokédex`
    * `PokédexPersistence`
    * `PokédexResult`
    * `Pokémon`
    * `ServicePokémon`
    * `PokémonResult`
    * `FileStoragePersistence`
    * `BaseServiceClient`
    * `ServiceCallResult`
    * `ServiceCallError`
    * `URLProvider`

(`ctrl + cmd + click` or `alt + click` on an object in the project to see documentation)

### Submission
* Projects should run on a minimum of __Xcode 11.3__
* Projects should be free of compile-time errors and crashes (run-time errors)
* Projects should not have any compile-time warnings (in yellow)
* Unless added by the student completing the project; __All__ comments (the green stuff) __MUST__ be deleted before submission
* The following files/directories __MUST__ be deleted from the project directory before submission:
    * `README.md`
    * `Pokédex_Screenshots.pdf`
    * `Pokédex_Demo.mov`
    * `.gitignore`
    * `.git/`
    * `.github/`

When ready to submit; the student should rename the directory containing their project to their __UMSL ssoid__ (e.g. 'gmhz7b').  
Then, *right-click* on that folder and select the option that should say ' __Compress "{ssoid_directory_name}"__ '. Finally, upload the resulting __zip__ file to __Canvas__.  
Students should take special care to ensure their projects are devoid of compile-time errors/warnings and run-time errors. Failure to do so will result in significant deductions.  
