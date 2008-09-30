From: thaoth <thaoth@cybersoft-vn.com>
Date: Tue, 30 Sep 2008 11:30:09 +0000
Subject: [UBoot] Hows to boot Linux Kernel from USB
Message-Id: <loom.20080930T111336-805@post.gmane.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi All,

I would like to know how to boot linux kernel from USB. I have 
ported UBoot
(support serial, USB driver) but didn't support CF card. 

Would you please tell me how to boot Linux Kernel from USB Flash memory? 
I have
many guide could help hows to boot Linux kernel from CF card or network 
but  I
didn't see help for USB Flash memory.

Here is step by step I did but didn't work.
- First initialization USB

=> usb start

- List file on USB Flash memory

=> fatls usb 0:1
  3876248   vmlinux.srec
  1348231   vmlinux
  2207942   vmlinux.bin
.
  1277956   zimage

- load zImage into SDRAM memory at base address 0x8c000000 + 200000 

=> fatload usb 0:1 200000 zimage
reading zimage
.
.
.
.
......................................................
..........................
............................................

1277956 bytes read

=> bootm
Wrong Image Format for bootm command
ERROR: can't get kernel image!

This seems here is wrong command. I should load uImage (not zImage) 
into SDRAM
memory. Google booting kernel from USB on the internet but I 
didn't see any help. :(

Thank you for answer
Best regards,

