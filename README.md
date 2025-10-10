# Decibel

<p align="center">
  <img src="media/images/logo.png" 
       alt="App Icon" 
       width="200"
       style="border-radius: 50%;"/>
</p>



**A Full-Stack Music Streaming Mobile App**  
_Built with Flutter (MVVM) + FastAPI | Powered by PostgreSQL, SQLAlchemy, and Cloudinary_

---

## Overview  

Decibel is a **music streaming mobile application** that delivers a seamless listening experience with **real-time playback**, **user authentication**, and **media management**.  

It’s built with a **Flutter MVVM architecture** for structured state management and a **FastAPI backend** that handles secure media operations, JWT authentication, and database workflows.  

---

## ✨ Features  

- 🎧 **Full-Stack Music Streaming:** Built with Flutter (MVVM) frontend and FastAPI + SQLAlchemy backend.  
- 🔐 **JWT Authentication:** Implemented with Pydantic validation and custom FastAPI middleware for secure routes.  
- 🧩 **State Management:** Used Provider with annotations/code generation for scalable, type-safe state handling.  
- ☁️ **Cloudinary Integration:** Media upload, storage, and retrieval workflows integrated with PostgreSQL for asset URL management.  
- 🔄 **Core App Features:** Background audio playback, listening history, library management, and a floating mini-player for continuous playback.  

---

## 🛠️ Tech Stack  

- **Frontend:** Flutter (MVVM Architecture) + Provider  
- **Backend:** FastAPI + SQLAlchemy  
- **Database:** PostgreSQL  
- **Storage:** Cloudinary  
- **Auth:** JWT with Pydantic validation  

---


## 🧩 MVVM Architecture Overview

The Decibel app follows the **MVVM (Model-View-ViewModel)** pattern for clean separation of concerns, making it easier to scale and maintain.  
Here’s how data and control flow across the app and backend:

```mermaid
flowchart TD
    subgraph UI[" View (Flutter UI)"]
        A1[Music Player Screen]
        A2[Library & History Screens]
        A3[Floating Audio Player]
    end

    subgraph VM["ViewModel (Provider)"]
        B1[AudioPlayerViewModel]
        B2[AuthViewModel]
        B3[LibraryViewModel]
    end

    subgraph M["Model Layer"]
        C1[User Model]
        C2[Track Model]
        C3[Playback Model]
    end

    subgraph Backend["FastAPI Backend"]
        D1[JWT Auth Service]
        D2[Media Service Cloudinary]
        D3[Database Service PostgreSQL via SQLAlchemy]
    end

    %% Connections between layers
    A1 --> B1
    A2 --> B3
    A3 --> B1
    B1 --> C3
    B2 --> C1
    B3 --> C2
    C1 --> D1
    C2 --> D2
    C3 --> D3
    D1 --> C1
    D2 --> C2
    D3 --> C3

```


## Quick Start

Here's how you can quickly set it up and run the backend (FastAPI) as well as the frontend (Flutter).

---

### 🔹 Backend (FastAPI and SQLAlchemy)

1. Once you clone , cd to the server directory :
   
```bash
   cd server
```
2. In the server directory, create a python virtual environment (Venv). Recommending this to avoid version issues and to make sure one has all the dependencies.

   
```bash
   python -m venv venv
   source venv/bin/activate   # Linux/Mac
   venv\Scripts\activate      # Windows
```

3. Install dependencies from requirements.txt :

   
```bash
   pip install -r requirements.txt
```

4. Start the server :

   
```bash
   uvicorn main:app -reload
```

5. All set :
   If things are good, the backend should now be running.

### 🔹 Frontend (Flutter)

1. cd into the frontend directory

   
```bash
   cd frontend
```

2. Install flutter dependencies :

   
```bash
   flutter pub get
```

3. Run the flutter app
   
```bash
   flutter run
```