From: Simon Horman <horms+renesas@verge.net.au>
Date: Sat, 23 Aug 2014 01:44:17 +0000
Subject: [PATCH 07/11] ARM: shmobile: Rework multiplatform include workaround
Message-Id: <f2acab52e77650044b0772a6d7abbfef1eb4cede.1408671240.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm+renesas@opensource.se>

Now when the majority of the include files have moved from
arch/arm/mach-shmobile/include/mach/ to arch/arm/mach-shmobile/
remove the header include file workaround in the Makefile...

... and add another workaround in irqs.h to cope with the fact
that <mach/irqs.h> needs to be where it is until the PFC code
has been updated to remove legacy non-DT interfaces.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/Makefile | 2 --
 arch/arm/mach-shmobile/irqs.h   | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/Makefile b/arch/arm/mach-shmobile/Makefile
index fe3878a..a6a1dc0 100644
--- a/arch/arm/mach-shmobile/Makefile
+++ b/arch/arm/mach-shmobile/Makefile
@@ -2,8 +2,6 @@
 # Makefile for the linux kernel.
 #
 
-ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/arch/arm/mach-shmobile/include
-
 # Common objects
 obj-y				:= timer.o console.o
 
diff --git a/arch/arm/mach-shmobile/irqs.h b/arch/arm/mach-shmobile/irqs.h
index 4ff2d2a..8e28223 100644
--- a/arch/arm/mach-shmobile/irqs.h
+++ b/arch/arm/mach-shmobile/irqs.h
@@ -2,7 +2,7 @@
 #define __SHMOBILE_IRQS_H
 
 #include <linux/sh_intc.h>
-#include <mach/irqs.h>
+#include "include/mach/irqs.h"
 
 /* GIC */
 #define gic_spi(nr)		((nr) + 32)
-- 
2.0.1

