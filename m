From: "Ha Nguyen" <hanguytv@gmail.com>
Date: Wed, 30 Jan 2008 09:32:37 +0000
Subject: mem-to-mem copy using fdma ...
Message-Id: <4d014b890801300132g48a88a0ejb3a64ebe697d3835@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi all,

I have to read UDP packets from sk_buff to my module in kernel space
and the udp stack uses copy_to_user() to do my task. I'm wondering if
using dma for mem-to-mem copy can improve data transfer performance
instead of using copy_to_user()???

If yes, could someone gives me some hints to go with it. I'm currently
working on ST7109 and stlinux 2.6.17.14. I have tried the guide at
http://www.stlinux.com/docs/manual/distribution/fdma_legacy.php and
http://www.stlinux.com/docs/manual/distribution/fdma_sh_exmpl1.php but
not succeeded, kernel crashed with the following error:

Unable to handle kernel NULL pointer dereference at virtual address 00000000
pc = 86cd56aa
*pde = 00000000
Oops: 0001 [#1]

Pid : 818, Comm: udhcpc
PC is at create_llu_list+0x86/0x8c
PC : 86cd56aa SP : 8f633d38 SR : 40008001 TEA : c0103a64 Not tainted
R0 : 00000000 R1 : 00000000 R2 : 8f633d80 R3 : 00000001
R4 : 8f633d80 R5 : 00000000 R6 : 00000000 R7 : 00000000
R8 : 00000001 R9 : 8f633d40 R10 : 00000030 R11 : 86d6616c
R12 : 0f516ae0 R13 : 86d6616c R14 : 8fbc6000
MACH: 00000000 MACL: 00000000 GBR : 295737e8 PR : 86cd696c

I would really appreciate any feedback! Thanks!

/ha
