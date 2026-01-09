# крч скрипт от дип сика
# by Deepseek
import tkinter as tk
from tkinter import scrolledtext, messagebox
import base64

def string_to_hex(text):
    """Конвертация строки в HEX формат 0x"""
    hex_chars = []
    for char in text:
        hex_value = f"0x{ord(char):02x}"
        hex_chars.append(hex_value)
    return hex_chars

def encrypt_lua():
    """Основная функция шифрования"""
    lua_code = input_text.get("1.0", "end-1c")
    
    if not lua_code.strip():
        messagebox.showwarning("Внимание", "Введите Lua код!")
        return
    
    # Base64 шифрование
    encoded = base64.b64encode(lua_code.encode()).decode()
    
    # Конвертация в HEX
    hex_array = string_to_hex(encoded)
    hex_str = ', '.join(hex_array)
    
    # Создание зашифрованного кода
    result = f"""-- Зашифрованный Lua код
local hex_data = {{{hex_str}}}

-- Функция для преобразования HEX в строку
local function hex_to_string(hex_table)
    local result = ""
    for i, hex_val in ipairs(hex_table) do
        result = result .. string.char(hex_val)
    end
    return result
end

-- Декодирование Base64
local function decode_base64(encoded)
    local decoded = ""
    for i = 1, #encoded, 4 do
        local chunk = encoded:sub(i, i + 3)
        local bytes = 0
        local bits = 0
        
        for j = 1, 4 do
            local char = chunk:sub(j, j)
            local value = 0
            if char >= 'A' and char <= 'Z' then
                value = string.byte(char) - 65
            elseif char >= 'a' and char <= 'z' then
                value = string.byte(char) - 71
            elseif char >= '0' and char <= '9' then
                value = string.byte(char) + 4
            elseif char == '+' then
                value = 62
            elseif char == '/' then
                value = 63
            end
            
            bytes = bytes * 64 + value
            bits = bits + 6
        end
        
        while bits >= 8 do
            bits = bits - 8
            local byte = math.floor(bytes / (2 ^ bits)) % 256
            decoded = decoded .. string.char(byte)
        end
    end
    return decoded
end

-- Выполнение кода
local encoded_str = hex_to_string(hex_data)
local decoded_code = decode_base64(encoded_str)

local success, func = pcall(loadstring, decoded_code)
if success and func then
    func()
else
    warn("Ошибка выполнения кода")
end"""
    
    result_text.delete("1.0", "end")
    result_text.insert("1.0", result)
    
    # Автоматическое копирование
    root.clipboard_clear()
    root.clipboard_append(result)
    status_label.config(text="✅ Код зашифрован и скопирован!")

def xor_encrypt():
    """XOR шифрование"""
    lua_code = input_text.get("1.0", "end-1c")
    
    if not lua_code.strip():
        messagebox.showwarning("Внимание", "Введите Lua код!")
        return
    
    key = "roblox"  # Можно изменить ключ
    
    # XOR шифрование
    encrypted_bytes = []
    for i, char in enumerate(lua_code):
        key_char = key[i % len(key)]
        xor_val = ord(char) ^ ord(key_char)
        encrypted_bytes.append(xor_val)
    
    # Конвертация в HEX
    hex_array = [f"0x{val:02x}" for val in encrypted_bytes]
    hex_str = ', '.join(hex_array)
    
    # Создание зашифрованного кода
    result = f"""-- XOR + HEX шифрование
local hex_data = {{{hex_str}}}
local key = "{key}"

-- Функция XOR дешифровки
local function xor_decrypt(data, key)
    local result = ""
    for i = 1, #data do
        local key_char = string.byte(key, (i - 1) % #key + 1)
        local char_code = data[i] ~ key_char
        result = result .. string.char(char_code)
    end
    return result
end

-- Выполнение
local bytes = {{}}
for i, hex_val in ipairs(hex_data) do
    table.insert(bytes, hex_val)
end

local decrypted = xor_decrypt(bytes, key)
local func = loadstring(decrypted)
if func then
    func()
end"""
    
    result_text.delete("1.0", "end")
    result_text.insert("1.0", result)
    
    # Автоматическое копирование
    root.clipboard_clear()
    root.clipboard_append(result)
    status_label.config(text="✅ XOR шифрование завершено и скопировано!")

def simple_hex():
    """Простая конвертация в HEX"""
    lua_code = input_text.get("1.0", "end-1c")
    
    if not lua_code.strip():
        messagebox.showwarning("Внимание", "Введите Lua код!")
        return
    
    hex_array = string_to_hex(lua_code)
    hex_str = ', '.join(hex_array)
    
    result = f"""-- HEX шифрование
local hex_data = {{{hex_str}}}

-- Декодирование
local code = ""
for i, hex_val in ipairs(hex_data) do
    code = code .. string.char(hex_val)
end

-- Выполнение
local func = loadstring(code)
if func then
    func()
end"""
    
    result_text.delete("1.0", "end")
    result_text.insert("1.0", result)
    
    # Автоматическое копирование
    root.clipboard_clear()
    root.clipboard_append(result)
    status_label.config(text="✅ HEX конвертация завершена и скопирована!")

def clear_all():
    """Очистка всех полей"""
    input_text.delete("1.0", "end")
    result_text.delete("1.0", "end")
    status_label.config(text="✅ Готов к работе")

# Создание главного окна
root = tk.Tk()
root.title("Roblox Lua Encryptor")
root.geometry("800x600")
root.configure(bg="#2c3e50")

# Заголовок
title_label = tk.Label(root, text="🔒 Roblox Lua Шифратор", 
                       font=("Arial", 16, "bold"), 
                       bg="#2c3e50", fg="white")
title_label.pack(pady=10)

# Контейнер для кнопок
button_frame = tk.Frame(root, bg="#2c3e50")
button_frame.pack(pady=5)

# Кнопки
btn1 = tk.Button(button_frame, text="Base64 + HEX", command=encrypt_lua,
                 bg="#3498db", fg="white", font=("Arial", 10), width=15)
btn1.pack(side="left", padx=5)

btn2 = tk.Button(button_frame, text="XOR + HEX", command=xor_encrypt,
                 bg="#e74c3c", fg="white", font=("Arial", 10), width=15)
btn2.pack(side="left", padx=5)

btn3 = tk.Button(button_frame, text="Просто HEX", command=simple_hex,
                 bg="#2ecc71", fg="white", font=("Arial", 10), width=15)
btn3.pack(side="left", padx=5)

btn4 = tk.Button(button_frame, text="Очистить", command=clear_all,
                 bg="#95a5a6", fg="white", font=("Arial", 10), width=15)
btn4.pack(side="left", padx=5)

# Контейнер для текстовых полей
text_frame = tk.Frame(root, bg="#2c3e50")
text_frame.pack(fill="both", expand=True, padx=20, pady=10)

# Левое поле - ввод
left_frame = tk.Frame(text_frame, bg="#34495e", relief="sunken", bd=2)
left_frame.pack(side="left", fill="both", expand=True, padx=(0, 10))

input_label = tk.Label(left_frame, text="Введите Lua код:", 
                       bg="#34495e", fg="white", font=("Arial", 10, "bold"))
input_label.pack(pady=5)

input_text = scrolledtext.ScrolledText(left_frame, bg="#2c3e50", fg="white",
                                       font=("Consolas", 10), height=15)
input_text.pack(fill="both", expand=True, padx=5, pady=(0, 5))

# Правое поле - результат
right_frame = tk.Frame(text_frame, bg="#34495e", relief="sunken", bd=2)
right_frame.pack(side="right", fill="both", expand=True, padx=(10, 0))

result_label = tk.Label(right_frame, text="Результат (автокопирование):", 
                        bg="#34495e", fg="white", font=("Arial", 10, "bold"))
result_label.pack(pady=5)

result_text = scrolledtext.ScrolledText(right_frame, bg="#2c3e50", fg="#00ff00",
                                        font=("Consolas", 10), height=15)
result_text.pack(fill="both", expand=True, padx=5, pady=(0, 5))

# Статус бар
status_label = tk.Label(root, text="✅ Готов к работе", 
                        bg="#2c3e50", fg="white", font=("Arial", 10))
status_label.pack(pady=10)

# Инструкция
info_text = """💡 Инструкция:
1. Введите Lua код в левое поле
2. Выберите метод шифрования
3. Результат автоматически скопируется
4. Вставьте код в Roblox"""
info_label = tk.Label(root, text=info_text, bg="#2c3e50", fg="#bdc3c7",
                      font=("Arial", 9), justify="left")
info_label.pack(pady=5)

# Запуск приложения
root.mainloop()
