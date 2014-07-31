From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 31 Jul 2014 00:25:15 +0000
Subject: [PATCH] ARM: shmobile: Rework multiplatform include workaround
Message-Id: <20140731002515.30680.1397.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Now when the majority of the include files have moved from
arch/arm/mach-shmobile/include/mach/ to arch/arm/mach-shmobile/
remove the header include file workaround in the Makefile...

... and add another workaround in irqs.h to cope with the fact
that <mach/irqs.h> needs to be where it is until the PFC code
has been updated to remove legacy non-DT interfaces.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 Written against renesas-devel-v3.16-rc7-20140729

 arch/arm/mach-shmobile/Makefile |    2 --
 arch/arm/mach-shmobile/irqs.h   |    2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2014-07-31 09:11:18.000000000 +0900
@@ -2,8 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
-
 # Common objects
 obj-y				:= timer.o console.o
 
--- 0001/arch/arm/mach-shmobile/irqs.h
+++ work/arch/arm/mach-shmobile/irqs.h	2014-07-31 09:12:56.000000000 +0900
@@ -2,7 +2,7 @@
 #define __SHMOBILE_IRQS_H
 
 #include <linux/sh_intc.h>
-#include <mach/irqs.h>
+#include "include/mach/irqs.h"
 
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
