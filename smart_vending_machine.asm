.data
menu: .asciiz "\n===== SMART VENDING MACHINE =====\n"
item1: .asciiz "1. Chips        Price: 50  Stock: "
item2: .asciiz "\n2. Soda         Price: 40  Stock: "
item3: .asciiz "\n3. Chocolate    Price: 60  Stock: "
item4: .asciiz "\n4. Cookies      Price: 30  Stock: "
item5: .asciiz "\n5. Juice        Price: 35  Stock: "
item6: .asciiz "\n6. Candy        Price: 20  Stock: "
item7: .asciiz "\n7. Water Bottle Price: 25  Stock: "
item8: .asciiz "\n8. Sandwich     Price: 55  Stock: "
adminOpt: .asciiz "\n9. Admin Mode\n"
chooseMsg: .asciiz "\nPlease select an option:\n[1-8] Buy an item\n[9] Admin Mode\n[0] Exit\nYour choice: "
qtyMsg: .asciiz "Enter quantity: "
qtyMsg1: .asciiz "quantity: "
totalMsg: .asciiz "Total amount: Rs "
moneyMsg: .asciiz "Insert money: "
errQty: .asciiz "Error: Quantity exceeds available stock!\n"
errMoney: .asciiz "Error: Insufficient money!\n"
success: .asciiz "\nPurchase successful!\n"
itemIdMsg: .asciiz "Item ID: "
changeMsg: .asciiz "Remaining balance: Rs "
invalidItemMsg: .asciiz "Error: Invalid item selected!\n"
againMsg: .asciiz "\nDo you want to continue shopping?\n1. Yes\n2. No\nChoose: "
adminMsg: .asciiz "\n--- ADMIN MODE ---\n1. View Stock\n2. Restock\n3. Exit Admin\nChoose: "
restockMsg: .asciiz "Enter new stock for item: "
restockAgainMsg: .asciiz "\nDo you want to restock another item?\n1. Yes\n2. No\nChoose: "
newline: .asciiz "\n"
receiptMsg: .asciiz "\n--- RECEIPT ---\n"
inputStr: .space 10
passInputPrompt: .asciiz "Enter admin password: "
adminPassword: .asciiz "1234"
passInput: .space 10
passErr: .asciiz "Incorrect password!\n"
passSuccess: .asciiz "Password correct! Entering Admin Mode...\n"
reMsg: .asciiz "\nChoose item (1-8) to restock: "

prices: .word 50, 40, 60, 30, 35, 20, 25, 55
stock:  .word 5, 5, 5, 5, 5, 5, 5, 5

.text
.globl main

main:
menu_loop:
    # Display Main Menu
    li $v0, 4
    la $a0, menu
    syscall

    # Display items with current stock
    li $v0, 4
    la $a0, item1
    syscall
    lw $a0, stock
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item2
    syscall
    lw $a0, stock+4
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item3
    syscall
    lw $a0, stock+8
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item4
    syscall
    lw $a0, stock+12
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item5
    syscall
    lw $a0, stock+16
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item6
    syscall
    lw $a0, stock+20
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item7
    syscall
    lw $a0, stock+24
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item8
    syscall
    lw $a0, stock+28
    li $v0, 1
    syscall

    # Display Admin Option
    li $v0, 4
    la $a0, adminOpt
    syscall

    # Ask for item selection
    li $v0, 4
    la $a0, chooseMsg
    syscall

    # Read user input as string
    li $v0, 8
    la $a0, inputStr
    li $a1, 10
    syscall

    # Convert string input to integer
    la $t0, inputStr
    li $v0, 0

check_loop:
    lb $t1, 0($t0)
    beq $t1, 10, check_done
    blt $t1, 48, invalid_item
    bgt $t1, 57, invalid_item
    sub $t1, $t1, 48
    mul $v0, $v0, 10
    add $v0, $v0, $t1
    addi $t0, $t0, 1
    j check_loop

check_done:
    move $t0, $v0
    beq $t0, 0, exit
    beq $t0, 9, check_admin_password
    blt $t0, 1, invalid_item
    bgt $t0, 8, invalid_item

    addi $t0, $t0, -1

    # Ask for quantity
    li $v0, 4
    la $a0, qtyMsg
    syscall

    li $v0, 5
    syscall
    move $t1, $v0

    blez $t1, menu_loop

    # Load stock of selected item
    la $t2, stock
    sll $t3, $t0, 2
    add $t2, $t2, $t3
    lw $t4, 0($t2)

    blt $t4, $t1, qty_error

    # Load price and calculate total
    la $t5, prices
    add $t5, $t5, $t3
    lw $t6, 0($t5)
    mul $t7, $t6, $t1

    # Display total amount
    li $v0, 4
    la $a0, totalMsg
    syscall
    li $v0, 1
    move $a0, $t7
    syscall

    # Ask for money
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, moneyMsg
    syscall
    li $v0, 5
    syscall
    move $t8, $v0

    blt $t8, $t7, money_error

    # Update stock
    sub $t4, $t4, $t1
    sw $t4, 0($t2)

    # Success message and receipt
    li $v0, 4
    la $a0, success
    syscall
    sub $t9, $t8, $t7
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, receiptMsg
    syscall

    li $v0, 4
    la $a0, itemIdMsg
    syscall
    li $v0, 1
    addi $a0, $t0, 1
    syscall

    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, qtyMsg1
    syscall
    li $v0, 1
    move $a0, $t1
    syscall

    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, totalMsg
    syscall
    li $v0, 1
    move $a0, $t7
    syscall

    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, moneyMsg
    syscall
    li $v0, 1
    move $a0, $t8
    syscall

    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, changeMsg
    syscall
    li $v0, 1
    move $a0, $t9
    syscall
    li $v0, 4
    la $a0, newline
    syscall

# Continue shopping
continue_loop:
    li $v0, 4
    la $a0, againMsg
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    beq $t0, 1, menu_loop
    beq $t0, 2, exit
    j continue_loop

qty_error:
    li $v0, 4
    la $a0, errQty
    syscall
    j menu_loop

money_error:
    li $v0, 4
    la $a0, errMoney
    syscall
    j menu_loop

invalid_item:
    li $v0, 4
    la $a0, invalidItemMsg
    syscall
    j menu_loop

# Admin password check
check_admin_password:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, passInputPrompt
    syscall
    li $v0, 8
    la $a0, passInput
    li $a1, 10
    syscall

    # Remove newline from input
    la $t0, passInput
remove_newline:
    lb $t1, 0($t0)
    beq $t1, 10, set_null
    beq $t1, 0, compare_password
    addi $t0, $t0, 1
    j remove_newline
set_null:
    sb $zero, 0($t0)

compare_password:
    la $t0, passInput
    la $t1, adminPassword
compare_loop:
    lb $t2, 0($t0)
    lb $t3, 0($t1)
    beq $t2, $t3, next_char
    j wrong_password
next_char:
    beq $t2, 0, correct_password
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    j compare_loop

wrong_password:
    li $v0, 4
    la $a0, passErr
    syscall
    j menu_loop

correct_password:
    li $v0, 4
    la $a0, passSuccess
    syscall
    j admin_mode

# Admin menu
admin_mode:
    li $v0, 4
    la $a0, adminMsg
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    beq $t0, 1, admin_view
    beq $t0, 2, admin_restock
    beq $t0, 3, menu_loop
    j admin_mode

# View stock
admin_view:
    li $v0, 4
    la $a0, newline
    syscall
    li $v0, 4
    la $a0, item1
    syscall
    lw $a0, stock
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item2
    syscall
    lw $a0, stock+4
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item3
    syscall
    lw $a0, stock+8
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item4
    syscall
    lw $a0, stock+12
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item5
    syscall
    lw $a0, stock+16
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item6
    syscall
    lw $a0, stock+20
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item7
    syscall
    lw $a0, stock+24
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item8
    syscall
    lw $a0, stock+28
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall
    j admin_mode

# Restock items
admin_restock:
restock_loop:
    li $v0, 4
    la $a0, newline
    syscall

    # Display all items with current stock
    li $v0, 4
    la $a0, item1
    syscall
    lw $a0, stock
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item2
    syscall
    lw $a0, stock+4
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item3
    syscall
    lw $a0, stock+8
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item4
    syscall
    lw $a0, stock+12
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item5
    syscall
    lw $a0, stock+16
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item6
    syscall
    lw $a0, stock+20
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item7
    syscall
    lw $a0, stock+24
    li $v0, 1
    syscall

    li $v0, 4
    la $a0, item8
    syscall
    lw $a0, stock+28
    li $v0, 1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Ask item ID to restock
    li $v0, 4
    la $a0, reMsg
    syscall
    li $v0, 5
    syscall
    move $t0, $v0
    blt $t0, 1, restock_loop
    bgt $t0, 8, restock_loop
    addi $t0, $t0, -1

    # Ask new stock quantity
    li $v0, 4
    la $a0, restockMsg
    syscall
    li $v0, 5
    syscall
    move $t1, $v0

    # Update stock
    la $t2, stock
    sll $t3, $t0, 2
    add $t2, $t2, $t3
    sw $t1, 0($t2)

    # Ask if admin wants to restock another item
    li $v0, 4
    la $a0, restockAgainMsg
    syscall
    li $v0, 5
    syscall
    move $t4, $v0
    beq $t4, 1, restock_loop
    j admin_mode

# Exit program
exit:
    li $v0, 10
    syscall
