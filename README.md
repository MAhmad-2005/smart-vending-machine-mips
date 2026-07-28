# Smart Vending Machine Controller

A fully functional vending machine simulation built entirely in **MIPS assembly language**, run on the **MARS simulator**. The project goes beyond a typical high-level simulation — it manages memory, registers, arithmetic operations, and conditional logic at the hardware level to replicate real-time stock tracking, user purchases, receipt generation, and secure admin access.

## Overview

Vending machines feel simple on the surface, but the internal logic — memory management, register usage, and control flow — is normally hidden inside compiled software. This project pulls that logic into the open by implementing the entire system from scratch in assembly: inventory tracking, price calculation, change computation, and stock updates, all handled directly through MIPS instructions and MARS syscalls.

## Features

- **Menu-driven interface** displaying all items, prices, and live stock counts
- **User Mode** — select an item, enter quantity, calculate total price, insert money, receive a printed receipt, and have stock update automatically
- **Admin Mode** — password-protected access to view and update stock quantities
- **Real-time stock management** — inventory updates immediately after every purchase
- **Receipt generation** — displays item ID, quantity, total amount, money inserted, and remaining balance
- **Error handling** — gracefully handles insufficient funds, invalid quantities, and out-of-stock purchase attempts

## Block Diagram

```
                    ┌───────────────┐
        ┌──────────▶│ Admin Module  │──────────┐
        │           └───────────────┘          ▼
┌──────┐    ┌───────────┐              ┌───────────────┐
│ User │───▶│ Main Menu │              │ Stock Memory  │
└──────┘    └───────────┘              └───────────────┘
        │           ▲                          ▲
        │           │                          │
        └──────────▶│    ┌──────────────────┐  │
                     └────│ Purchase Module  │──┘
                          └──────────────────┘
                                   │
                                   ▼
                          ┌──────────────────┐
                          │ Receipt Generation│
                          └──────────────────┘
```

## Workflow

1. The program displays the main menu with all items, prices, and stock.
2. The user selects an item, enters a quantity, and the system checks stock availability.
3. If stock is sufficient, the total price is calculated and the user is prompted to insert money.
4. If the money inserted is sufficient, stock is updated, change is calculated, and a receipt is printed.
5. Insufficient money or insufficient stock trigger dedicated error paths back to the main menu.
6. Selecting Admin Mode requires a password; on success, the admin can view or restock inventory.

## Built With

<p>
  <img src="https://img.shields.io/badge/MIPS%20Assembly-A31F34?style=for-the-badge" />
  <img src="https://img.shields.io/badge/MARS%20Simulator-1E3A8A?style=for-the-badge" />
</p>

- **MIPS Assembly Language** — Implements all logic, arithmetic, and control flow
- **MARS Simulator** — Used to write, assemble, and execute the program
- **Registers & Memory** — Used directly for item data, user input, and computation results, with no high-level abstractions

## Project Scope

- Simulates a complete vending machine system in MIPS assembly
- Covers user transactions, real-time stock management, and password-protected admin control
- Built for learning purposes — to understand low-level programming and computer architecture concepts in a practical, hands-on system
- Does not include persistent storage; all data resets when the program restarts
- Reflects a low-level approach similar to real vending machine hardware, where control and transactions happen close to the metal

## Project Structure

```
smart-vending-machine-mips/
└── smart_vending_machine.asm   # Complete MIPS assembly source — menu, purchase logic,
                                  admin mode, stock management, and receipt generation
```

## Getting Started

Clone the repository:

```bash
git clone https://github.com/AbdulRehman2345/smart-vending-machine-mips.git
```

1. Download and open the [MARS MIPS Simulator](https://dpetersanderson.github.io/index.html)
2. Open `smart_vending_machine.asm` in MARS
3. Assemble and run the program
4. Follow the on-screen menu to buy items or enter Admin Mode (default admin password: `1234`)

## Sample Interaction

```
===== SMART VENDING MACHINE =====
1. Chips        Price: 50  Stock: 5
2. Soda         Price: 40  Stock: 5
...
9. Admin Mode

Please select an option:
[1-8] Buy an item
[9] Admin Mode
[0] Exit
Your choice: 5
Enter quantity: 2
Total amount: Rs 70
Insert money: 100

Purchase successful!

--- RECEIPT ---
Item ID: 5
Quantity: 2
Total amount: Rs 70
Insert money: 100
Remaining balance: Rs 30
```

## Conclusion

This project demonstrates a fully functional system built entirely in MIPS assembly — covering item selection, purchase processing, receipt generation, stock management, and admin control. It bridges the gap between the theory of computer architecture and a working, practical application, while highlighting how precise, hardware-level operations can power a complete real-world system.


## Authors

**Abdul Rehman** — Software Engineer
[LinkedIn](https://www.linkedin.com/in/abdul-rehman-750208312/)

**Muhammad Ahmad** — Software Engineer
[LinkedIn](https://www.linkedin.com/in/muhammad-ahmad-021228348/)

## License

This project is open source and available for reference. Feel free to explore the code.
