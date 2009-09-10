From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Thu, 10 Sep 2009 01:39:55 +0000
Subject: [PATCH 2/6] sh: Add romImage support for EcoVec24
Message-Id: <ur5ufy3v8.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/boards/mach-ecovec24/setup.c               |    1 +
 .../mach-ecovec24/mach/partner-jet-setup.txt       |   79 ++++++++++++++++++++
 arch/sh/include/mach-ecovec24/mach/romimage.h      |   20 +++++
 3 files changed, 100 insertions(+), 0 deletions(-)
 create mode 100644 arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
 create mode 100644 arch/sh/include/mach-ecovec24/mach/romimage.h

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 3632f41..4d6d588 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -448,6 +448,7 @@ static int __init arch_setup(void)
 	gpio_request(GPIO_FN_LNKSTA,       NULL);
 
 	/* enable USB */
+	ctrl_outw(0x0000, 0xA4D80000);
 	gpio_request(GPIO_PTB3,  NULL);
 	gpio_request(GPIO_PTB4,  NULL);
 	gpio_request(GPIO_PTB5,  NULL);
diff --git a/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
new file mode 100644
index 0000000..ae805ba
--- /dev/null
+++ b/arch/sh/include/mach-ecovec24/mach/partner-jet-setup.txt
@@ -0,0 +1,79 @@
+LIST "partner-jet-setup.txt"
+LIST "(C) Copyright 2009 Renesas Solutions Corp"
+LIST "Kuninori Morimoto <morimoto.kuninori@renesas.com>"
+LIST "--------------------------------"
+LIST "zImage (RAM boot)"
+LIST "This script can be used to boot the kernel from RAM via JTAG:"
+LIST "> < partner-jet-setup.txt"
+LIST "> RD zImage, 0xa8800000"
+LIST "> G=0xa8800000"
+LIST "--------------------------------"
+LIST "romImage (Flash boot)"
+LIST "Use the following command to burn the zImage to flash via JTAG:"
+LIST "> RD romImage, 0"
+LIST "--------------------------------"
+
+LIST "disable watchdog"
+EW 0xa4520004, 0xa507
+
+LIST "MMU"
+ED 0xff000010, 0x00000004
+
+LIST "setup clocks"
+ED 0xa4150024, 0x00004000
+ED 0xa4150000, 0x8E003508
+ED 0xa4150004, 0x00000000
+
+WAIT 1
+
+LIST "BSC"
+ED 0xff800020, 0xa5a50000
+ED 0xfec10000, 0x00000013
+ED 0xfec10004, 0x11110400
+ED 0xfec10024, 0x00000440
+
+WAIT 1
+
+LIST "setup sdram"
+ED 0xfd000108, 0x00000181
+ED 0xfd000020, 0x015B0002
+ED 0xfd000030, 0x03061502
+ED 0xfd000034, 0x02020102
+ED 0xfd000038, 0x01090305
+ED 0xfd00003c, 0x00000002
+ED 0xfd000008, 0x00000005
+ED 0xfd000018, 0x00000001
+
+WAIT 1
+
+ED 0xfd000014, 0x00000002
+ED 0xfd000060, 0x00020000
+ED 0xfd000060, 0x00030000
+ED 0xfd000060, 0x00010040
+ED 0xfd000060, 0x00000532
+ED 0xfd000014, 0x00000002
+ED 0xfd000014, 0x00000004
+ED 0xfd000014, 0x00000004
+ED 0xfd000060, 0x00000432
+ED 0xfd000060, 0x000103C0
+ED 0xfd000060, 0x00010040
+
+WAIT 1
+
+ED 0xfd000010, 0x00000001
+ED 0xfd000044, 0x00000613
+ED 0xfd000048, 0x238C003A
+ED 0xfd000014, 0x00000002
+
+LIST "Dummy read"
+DD 0x0c400000, 0x0c400000
+
+ED 0xfd000014, 0x00000002
+ED 0xfd000014, 0x00000004
+ED 0xfd000108, 0x00000080
+ED 0xfd000040, 0x00010000
+
+WAIT 1
+
+LIST "setup cache"
+ED 0xff00001c, 0x0000090b
diff --git a/arch/sh/include/mach-ecovec24/mach/romimage.h b/arch/sh/include/mach-ecovec24/mach/romimage.h
new file mode 100644
index 0000000..1c8787e
--- /dev/null
+++ b/arch/sh/include/mach-ecovec24/mach/romimage.h
@@ -0,0 +1,20 @@
+/* EcoVec board specific boot code:
+ * converts the "partner-jet-script.txt" script into assembly
+ * the assembly code is the first code to be executed in the romImage
+ */
+
+#include <asm/romimage-macros.h>
+#include "partner-jet-setup.txt"
+
+	/* execute icbi after enabling cache */
+	mov.l	1f, r0
+	icbi	@r0
+
+	/* jump to cached area */
+	mova	2f, r0
+	jmp	@r0
+	nop
+
+	.align 2
+1 :	.long 0xa8000000
+2 :
-- 
1.6.0.4

