import tkinter as tk
from tkinter import scrolledtext, messagebox
import base64

def string_to_hex(text):
    hex_chars = []
    for char in text:
        hex_value = f"0x{ord(char):02x}"
        hex_chars.append(hex_value)
    return hex_chars

def encrypt_lua():
    lua_code = input_text.get("1.0", "end-1c")
    
    if not lua_code.strip():
        messagebox.showwarning("Warning", "Enter Lua code!")
        return
    
    encoded = base64.b64encode(lua_code.encode()).decode()
    
    hex_array = string_to_hex(encoded)
    hex_str = ', '.join(hex_array)
    
    result = f"""local hex_data = {{{hex_str}}}

local function hex_to_string(hex_table)
    local result = ""
    for i, hex_val in ipairs(hex_table) do
        result = result .. string.char(hex_val)
    end
    return result
end

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

local encoded_str = hex_to_string(hex_data)
local decoded_code = decode_base64(encoded_str)

local success, func = pcall(loadstring, decoded_code)
if success and func then
    func()
else
    warn("Code execution error")
end"""
    
    result_text.delete("1.0", "end")
    result_text.insert("1.0", result)
    
    root.clipboard_clear()
    root.clipboard_append(result)
    status_label.config(text="✅ Code encrypted and copied!")

def xor_encrypt():
    lua_code = input_text.get("1.0", "end-1c")
    
    if not lua_code.strip():
        messagebox.showwarning("Warning", "Enter Lua code!")
        return
    
    key = "roblox"
    
    encrypted_bytes = []
    for i, char in enumerate(lua_code):
        key_char = key[i % len(key)]
        xor_val = ord(char) ^ ord(key_char)
        encrypted_bytes.append(xor_val)
    
    hex_array = [f"0x{val:02x}" for val in encrypted_bytes]
    hex_str = ', '.join(hex_array)
    
    result = f"""local hex_data = {{{hex_str}}}
local key = "{key}"

local function xor_decrypt(data, key)
    local result = ""
    for i = 1, #data do
        local key_char = string.byte(key, (i - 1) % #key + 1)
        local char_code = data[i] ~ key_char
        result = result .. string.char(char_code)
    end
    return result
end

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
    
    root.clipboard_clear()
    root.clipboard_append(result)
    status_label.config(text="✅ XOR encryption complete and copied!")

def simple_hex():
    lua_code = input_text.get("1.0", "end-1c")
    
    if not lua_code.strip():
        messagebox.showwarning("Warning", "Enter Lua code!")
        return
    
    hex_array = string_to_hex(lua_code)
    hex_str = ', '.join(hex_array)
    
    result = f"""local hex_data = {{{hex_str}}}

local code = ""
for i, hex_val in ipairs(hex_data) do
    code = code .. string.char(hex_val)
end

local func = loadstring(code)
if func then
    func()
end"""
    
    result_text.delete("1.0", "end")
    result_text.insert("1.0", result)
    
    root.clipboard_clear()
    root.clipboard_append(result)
    status_label.config(text="✅ HEX conversion complete and copied!")

def clear_all():
    input_text.delete("1.0", "end")
    result_text.delete("1.0", "end")
    status_label.config(text="✅ Ready to work")

root = tk.Tk()
root.title("Roblox Lua Encryptor")
root.geometry("800x600")
root.configure(bg="#2c3e50")

title_label = tk.Label(root, text="🔒 Roblox Lua Encryptor", 
                       font=("Arial", 16, "bold"), 
                       bg="#2c3e50", fg="white")
title_label.pack(pady=10)

button_frame = tk.Frame(root, bg="#2c3e50")
button_frame.pack(pady=5)

btn1 = tk.Button(button_frame, text="Base64 + HEX", command=encrypt_lua,
                 bg="#3498db", fg="white", font=("Arial", 10), width=15)
btn1.pack(side="left", padx=5)

btn2 = tk.Button(button_frame, text="XOR + HEX", command=xor_encrypt,
                 bg="#e74c3c", fg="white", font=("Arial", 10), width=15)
btn2.pack(side="left", padx=5)

btn3 = tk.Button(button_frame, text="Simple HEX", command=simple_hex,
                 bg="#2ecc71", fg="white", font=("Arial", 10), width=15)
btn3.pack(side="left", padx=5)

btn4 = tk.Button(button_frame, text="Clear All", command=clear_all,
                 bg="#95a5a6", fg="white", font=("Arial", 10), width=15)
btn4.pack(side="left", padx=5)

text_frame = tk.Frame(root, bg="#2c3e50")
text_frame.pack(fill="both", expand=True, padx=20, pady=10)

left_frame = tk.Frame(text_frame, bg="#34495e", relief="sunken", bd=2)
left_frame.pack(side="left", fill="both", expand=True, padx=(0, 10))

input_label = tk.Label(left_frame, text="Enter Lua code:", 
                       bg="#34495e", fg="white", font=("Arial", 10, "bold"))
input_label.pack(pady=5)

input_text = scrolledtext.ScrolledText(left_frame, bg="#2c3e50", fg="white",
                                       font=("Consolas", 10), height=15)
input_text.pack(fill="both", expand=True, padx=5, pady=(0, 5))

right_frame = tk.Frame(text_frame, bg="#34495e", relief="sunken", bd=2)
right_frame.pack(side="right", fill="both", expand=True, padx=(10, 0))

result_label = tk.Label(right_frame, text="Result (auto-copied):", 
                        bg="#34495e", fg="white", font=("Arial", 10, "bold"))
result_label.pack(pady=5)

result_text = scrolledtext.ScrolledText(right_frame, bg="#2c3e50", fg="#00ff00",
                                        font=("Consolas", 10), height=15)
result_text.pack(fill="both", expand=True, padx=5, pady=(0, 5))

status_label = tk.Label(root, text="✅ Ready to work", 
                        bg="#2c3e50", fg="white", font=("Arial", 10))
status_label.pack(pady=10)

info_text = """💡 Instructions:
1. Enter Lua code in left field
2. Select encryption method
3. Result auto-copied to clipboard
4. Paste code in Roblox"""
info_label = tk.Label(root, text=info_text, bg="#2c3e50", fg="#bdc3c7",
                      font=("Arial", 9), justify="left")
info_label.pack(pady=5)

root.mainloop()
