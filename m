From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Sat, 12 Sep 2009 17:56:03 +0000
Subject: R2D-plus USB Crash
Message-Id: <20090912175603.GA5017@game.jcrosoft.org>
List-Id: <linux-sh.vger.kernel.org>
To: linux-sh@vger.kernel.org

Hi,

	During some regression test I've found this on my r2d-plus

usb 1-1.2: new full speed USB device using sm501-usb and address 3
usb 1-1.2: New USB device found, idVendor1c, idProduct11
usb 1-1.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-1.2: Product: Voyager Mini
usb 1-1.2: Manufacturer: Corsair
usb 1-1.2: SerialNumber: 32I29XG397GQ14Y9
usb 1-1.2: configuration #1 chosen from 1 choice
scsi1 : SCSI emulation for USB Mass Storage devices
scsi 1:0:0:0: Direct-Access     Corsair  Voyager Mini     1100 PQ: 0 ANSI:
0 CCS
sd 1:0:0:0: [sda] 7831552 512-byte hardware sectors: (4.00 GB/3.73 GiB)
sd 1:0:0:0: [sda] Write Protect is off
sd 1:0:0:0: [sda] Assuming drive cache: write through
sd 1:0:0:0: [sda] Assuming drive cache: write through
 sda:<0>------------[ cut here ]------------
Badness at 8c01d5c0 [verbose debug info unavailable]

Pid : 0, Comm:          swapper
CPU : 0                 Not tainted  (2.6.30-00000-v2.6.30 #14)

PC is at dma_free_coherent+0xa0/0xc0
PR is at hcd_free_coherent+0x4e/0xa0
PC  : 8c01d5c0 SP  : 8c33be70 SR  : 400080f0 TEA : 296a3d68
R0  : 000000f0 R1  : fffffff4 R2  : 00000000 R3  : 00000004
R4  : 8f93ce10 R5  : 00000000 R6  : b07c6000 R7  : 007c6000
R8  : 00000001 R9  : 000007c6 R10 : 8f8a611c R11 : 8f8a6120
R12 : 8f943400 R13 : 00000000 R14 : b07c6000
MACH: 000135a4 MACL: 00001f40 GBR : 1bb5426f PR  : 8c1ac0ae

Call trace:
[<8c1ac0ae>] hcd_free_coherent+0x4e/0xa0
[<8c1ac1ae>] unmap_urb_for_dma+0xae/0xc0
[<8c1ac1e8>] usb_hcd_giveback_urb+0x28/0xe0
[<8c1b827a>] finish_urb+0x5a/0xc0
[<8c1b839c>] takeback_td+0xbc/0xe0
[<8c1ba944>] ohci_irq+0x1c4/0x3a0
[<8c1b82e0>] takeback_td+0x0/0xe0
[<8c1ac68c>] usb_hcd_irq+0x6c/0xc0
[<8c04c04a>] handle_IRQ_event+0x4a/0x1a0
[<8c04e146>] handle_level_irq+0x46/0xc0
[<8c0266e0>] printk+0x0/0x40
[<8c0120c0>] default_idle+0x0/0xe0
[<8c0127b4>] do_IRQ+0x34/0x60
[<8c0170e4>] ret_from_exception+0x0/0xc
[<8c28c040>] schedule+0x0/0x40
[<8c012780>] do_IRQ+0x0/0x60
[<8c0120c0>] default_idle+0x0/0xe0
[<8c080920>] quicklist_trim+0x0/0xe0
[<8c28c040>] schedule+0x0/0x40
[<8c0120c0>] default_idle+0x0/0xe0
[<8c0266e0>] printk+0x0/0x40
[<8c012100>] default_idle+0x40/0xe0
[<8c012052>] cpu_idle+0x52/0xc0
[<8c011024>] _stext+0x24/0x30
[<8c011000>] _stext+0x0/0x30

 sda1
sd 1:0:0:0: [sda] Attached SCSI removable disk
usb 1-1.2: USB disconnect, address 3

Best Regards,
J.
