# 🗂️ File Sorter with Python

A simple Python project to **automatically sort files** based on their extensions — starting with `.jpeg` and `.jpg`.

---

## 📌 Description

This project helps you organize messy folders by moving files with specific formats into corresponding subfolders.

For example, if your directory contains mixed `.jpeg` and `.jpg` files, the script will:

- Create `jpeg/` and `jpg/` folders if they don’t exist
- Move each file into the correct folder based on its extension

This simple automation is highly practical for keeping your workspace clean and efficient.

---

## 🧪 Features

- Sort `.jpeg` and `.jpg` files into respective folders
- Auto-create folders if they don’t exist
- Easily extensible for other formats

---

## 🚀 Getting Started

### 1. Requirements

- Python 3.x
- Jupyter Notebook or any Python IDE
- Modules: `os`, `shutil`

### 2. How to Run

```python
import os
import shutil

# 1. Set your target folder path
folder_path = '/path/to/your/folder'

# 2. List all files in the folder
files = os.listdir(folder_path)

# 3. Create subfolders if not exist
jpeg_folder = os.path.join(folder_path, 'jpeg')
jpg_folder = os.path.join(folder_path, 'jpg')

os.makedirs(jpeg_folder, exist_ok=True)
os.makedirs(jpg_folder, exist_ok=True)

# 4. Sort files
for file in files:
    if file.lower().endswith('.jpeg'):
        shutil.move(os.path.join(folder_path, file), os.path.join(jpeg_folder, file))
    elif file.lower().endswith('.jpg'):
        shutil.move(os.path.join(folder_path, file), os.path.join(jpg_folder, file))
