# Multi-Timezone Digital Clock in Assembly

This project is an x86 Assembly language program using the **Irvine32** library. It displays the current system **date** and **time** in three different time zones:

- **GMT (Greenwich Mean Time)**
- **Pakistan Time (PKT)**
- **US Eastern Time (EST)**

The program fetches the system's local time, calculates corresponding times for other time zones, and continuously updates the display every second.

## 🛠 Features

- Shows current **Date** in `YYYY-MM-DD` format.
- Shows current **Time** (HH:MM:SS) in:
  - GMT (UTC +0)
  - Pakistan Time (UTC +5)
  - US Eastern Time (UTC -5)
- Handles **hour wrapping** (e.g., going below 0 or above 23).
- Refreshes the clock every second.
- Color-coded output for readability.

## 💻 Requirements

- Windows OS
- [Irvine32 Library](https://kipirvine.com/asm/examples/)
- 32-bit Assembler (such as **MASM**)
- DOSBox or a 32-bit compatible environment (if running on 64-bit system)

## 🧾 File Structure

- `clock.asm` – The main source file containing Assembly code.
- `Irvine32.inc` – Include file for Irvine32 macros (provided by KIP Irvine).
- `README.md` – This documentation file.

## 🔧 How It Works

1. Retrieves local system time using `GetLocalTime`.
2. Displays date in green.
3. Calculates and displays:
   - GMT (subtracts 5 hours from local time)
   - Pakistan Time (adds 5 hours to GMT)
   - US Eastern Time (subtracts 9 hours from Pakistan Time)
4. Handles wrapping when crossing midnight.
5. Delays for 1 second using `Delay`.
6. Repeats infinitely by resetting the cursor with `Gotoxy`.

## 📦 Example Output

Date: 2025-05-12
GMT Time: 10:45:22
Pakistan Time (PK): 15:45:22
US Eastern Time (US): 06:45:22

*(Colors are visible when run in compatible console environments)*

## ⚠️ Notes

- The calculations are static and assume fixed UTC offsets. **Daylight Saving Time (DST)** is **not accounted for**.
- This program is for **educational purposes** and demonstrates use of system time, control structures, and display formatting in Assembly.

## 📚 References

- KIP Irvine’s book: *Assembly Language for x86 Processors*
- [Irvine Library Documentation](https://kipirvine.com/asm/)
- Windows API: `GetLocalTime`

---

Feel free to fork or modify this project to add more time zones or improved formatting.
