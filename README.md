# 📝 Flutter To-Do List App

A simple **Flutter task manager** built for **study and portfolio purposes**, developed by **Patrick da Silva Gonzaga**.  
This app allows you to add, check, remove, and reorder tasks — everything stored locally using JSON and the `path_provider` package.  

---

## 🚀 Overview

This project was created as part of my Flutter learning journey and to serve as a portfolio example.  
It demonstrates the use of local persistence, state management with `setState()`, and modern UI elements such as `Dismissible`, `SnackBar`, and `CheckboxListTile`.

---

## ⚙️ Features

✅ Add new tasks with a title  
✅ Delete tasks with a swipe gesture (with undo option)  
✅ Mark tasks as completed with a checkbox  
✅ Automatically reorder tasks (completed tasks stay at the bottom)  
✅ Persistent storage with JSON files using `path_provider`  
✅ Pull-to-refresh functionality to reorder tasks  

---

## 🧩 Technologies Used

- **Flutter** (UI framework)
- **Dart** (programming language)
- **path_provider** (to locate device directories)
- **JSON** (for local data storage)
- **Material Design** (for consistent UI components)

---

## 🛠️ How to Run the Project

1. **Clone this repository**
   ```bash
   git clone https://github.com/yourusername/flutter_todo_list.git
   ```

2. **Navigate into the folder**

   ```bash
   cd flutter_todo_list
   ```

3. **Install dependencies**

   ```bash
   flutter pub get
   ```

4. **Run the app**

   ```bash
   flutter run
   ```

💡 *Make sure you have Flutter SDK installed and configured before running the app.*

---

## 📂 Project Structure

```
lib/
 ├── main.dart      # App entry point
 ├── widgets/       # Custom widgets (optional future refactor)
 ├── assets/        # Icons or images (if added later)
```

---

## 👨‍💻 Author

**Patrick da Silva Gonzaga**
🎯 Purpose: *Study and Portfolio Development*

---

## 🪪 License

This project is open-source and available for learning and personal use.
Feel free to fork, modify, and improve it! 🚀

```
