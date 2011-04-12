From: Feng Yang <feng.yang.xb@renesas.com>
Date: Tue, 12 Apr 2011 01:39:47 +0000
Subject: Linux kernel 2.6.35 webcam issue
Message-Id: <35FC1A56EEC91A42A0EB92079193ED8D0335279D@ASISML10.asia-idc.local>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi 
I have trouble in load uvc(USB Video Class) driver on SH platform.
I build kernel config option as below.
<*>   USB Gadget Support  --->   
<M>   USB Gadget Drivers
<M>     USB Webcam Gadget 

#insmod /lib/modules/2.6.35/kernel/drivers/usb/gadget/g_webcam.ko
I insert USB cable form webcam, then I get error message as below.
The webcam brand is "Logitech C270"

------------[ cut here ]------------
kernel BUG at mm/slab.c:3058!
Kernel BUG: 003e [#1]
last sysfs file: /sys/class/usb_device/usbdev1.2/dev
Modules linked in: g_webcam

Pid : 193, Comm:                khubd
CPU : 0                 Not tainted  (2.6.35 #4)

PC  : 88065038 SP  : 97051dd8 SR  : 400081f1 TEA : c000f7ec
R0  : 970032e8 R1  : 97195cc0 R2  : 0000000c R3  : 00000001
R4  : 97001420 R5  : 000000d0 R6  : 970032e8 R7  : ffffffff
R8  : 97001420 R9  : 9700b1a0 R10 : 000000d0 R11 : 00000000
R12 : 970032e0 R13 : 970032f0 R14 : 00000000
MACH: 00000010 MACL: 1bb01000 GBR : 00000000 PR  : 880653e2

Call trace:
 [<880653e2>] 0x880653e2
 [<8817f08a>] 0x8817f08a
 [<8817dc8e>] 0x8817dc8e
 [<8817dd32>] 0x8817dd32
 [<881773a2>] 0x881773a2
 [<88177aa4>] 0x88177aa4
 [<88177d66>] 0x88177d66
 [<88178f6e>] 0x88178f6e
 [<8810d462>] 0x8810d462
 [<8802791c>] 0x8802791c
 [<88027622>] 0x88027622
 [<88178790>] 0x88178790
 [<88003e92>] 0x88003e92
 [<880275cc>] 0x880275cc
 [<88003e8c>] 0x88003e8c

Process: khubd (pid: 193, stack limit = 97050001)
Stack: (0x97051dd8 to 0x97052000)
1dc0:                                                       00000200
00000000
1de0: 97195d20 000000d0 880653e2 970c6418 00000009 000009a5 00000000
000000d0
1e00: 97001420 97001420 8817f08a 00000000 00000009 971fbc00 971fbc64
971fbc00
1e20: 80000380 00000012 00000012 8817dc8e 80000080 00000000 97195c61
971fbc00
1e40: 00000001 00000000 97195d20 00000100 00000000 97195c60 00000001
00001388
1e60: 00000000 971fbe7c 971fbdfc 971fbd3c 00000001 00000000 970c6400
fffffff4
1e80: 8817dd32 971fbc00 00000012 97195c60 881773a2 00000000 00000003
00000040
1ea0: 971fbc00 88336594 971fbc64 00000032 88177aa4 970c6418 970c6230
00000000
1ec0: 971fbc00 00000001 971fbc00 971fbc00 88177d66 00000001 971fbc64
971fbc00
1ee0: 88178f6e 00000001 970c6000 9712db60 8810d462 00000000 97111c1c
97111c1c
1f00: 970c6400 970c6207 970c6230 970c6000 970c6000 9712dbd1 00000000
00000401
1f20: 9712dbf0 9712db68 970c6098 9712db94 9712dba0 9712db9c 9712db98
00000000
1f40: 9707d160 8802791c 97051f48 97051f48 00000401 04010001 00000000
88027622
1f60: 00000000 00000000 00000000 00000000 88178790 00000000 9701ff28
00000000
1f80: 00000000 97051f84 97051f84 88003e92 00000000 00000000 00000000
00000000
1fa0: 00000000 00000000 00000000 00000000 00000000 9701ff28 880275cc
00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000
00000000
1fe0: 97051fa4 88003e8c 00000000 40008000 00000000 00000000 00000000
00000000
---[ end trace 5b3af52b71c01a02 ]---
note: khubd[193] exited with preempt_count 1

Regards,
Feng

E-mail: feng.yang.xb@renesas.com
TEL:+886-2-81759685
FAX:+886-2-81759672
URL : http://tw.renesas.com 
Renesas Electronics Taiwan Co., Ltd. 
Engineering Centre Application, Engineering Department 1

