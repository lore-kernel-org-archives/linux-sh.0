From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Sun, 25 Jan 2015 10:11:51 +0000
Subject: [PATCH] sh: Eliminate unused irq_reg_{readl,writel} accessors
Message-Id: <1422180711-18976-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kevin Cernekee <cernekee@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Kevin Cernekee <cernekee@gmail.com>

Defining these macros way down in arch/sh/.../irq.c doesn't cause
kernel/irq/generic-chip.c to use them.  As far as I can tell this code
has no effect.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be> (cpp/asm comparison)

As of commit 332fd7c4fef5f3b1 ("genirq: Generic chip: Change
irq_reg_{readl,writel} arguments") they cause build errors in
se7722_defconfig:

    In file included from arch/sh/boards/mach-se/7722/irq.c:18:0:
    include/linux/irq.h:847:91: error: conflicting types for 'iowrite16'
    include/asm-generic/iomap.h:35:13: note: previous declaration of 'iowrite16' was here
    include/linux/irq.h:856:90: error: conflicting types for 'ioread16'
    include/asm-generic/iomap.h:29:21: note: previous declaration of 'ioread16' was here
    arch/sh/boards/mach-se/7722/irq.c: In function 'se7722_irq_demux':
    arch/sh/boards/mach-se/7722/irq.c:43:2: error: too few arguments to function 'ioread16'
    include/linux/irq.h:856:90: note: declared here

and se7343_defconfig:

    In file included from arch/sh/boards/mach-se/7343/irq.c:21:0:
    include/linux/irq.h:847:91: error: conflicting types for 'iowrite16'
    include/asm-generic/iomap.h:35:13: note: previous declaration of 'iowrite16' was here
    include/linux/irq.h:856:90: error: conflicting types for 'ioread16'
    include/asm-generic/iomap.h:29:21: note: previous declaration of 'ioread16' was here
    arch/sh/boards/mach-se/7343/irq.c: In function 'se7343_irq_demux':
    arch/sh/boards/mach-se/7343/irq.c:44:2: error: too few arguments to function 'ioread16'
    include/linux/irq.h:856:90: note: declared here

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Fixes: 332fd7c4fef5f3b1 ("genirq: Generic chip: Change irq_reg_{readl,writel} arguments")
---
Fixes se7722_defconfig and se7343_defconfig
http://kisskb.ellerman.id.au/kisskb/buildresult/12350978/
http://kisskb.ellerman.id.au/kisskb/buildresult/12350973/
---
 arch/sh/boards/mach-se/7343/irq.c | 3 ---
 arch/sh/boards/mach-se/7722/irq.c | 3 ---
 2 files changed, 6 deletions(-)

diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
index 7646bf0486c2c9b1..1087dba9b0152317 100644
--- a/arch/sh/boards/mach-se/7343/irq.c
+++ b/arch/sh/boards/mach-se/7343/irq.c
@@ -14,9 +14,6 @@
 #define DRV_NAME "SE7343-FPGA"
 #define pr_fmt(fmt) DRV_NAME ": " fmt
 
-#define irq_reg_readl	ioread16
-#define irq_reg_writel	iowrite16
-
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
diff --git a/arch/sh/boards/mach-se/7722/irq.c b/arch/sh/boards/mach-se/7722/irq.c
index f5e2af1bf040ff93..00e699232621dccf 100644
--- a/arch/sh/boards/mach-se/7722/irq.c
+++ b/arch/sh/boards/mach-se/7722/irq.c
@@ -11,9 +11,6 @@
 #define DRV_NAME "SE7722-FPGA"
 #define pr_fmt(fmt) DRV_NAME ": " fmt
 
-#define irq_reg_readl	ioread16
-#define irq_reg_writel	iowrite16
-
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/interrupt.h>
-- 
1.9.1

