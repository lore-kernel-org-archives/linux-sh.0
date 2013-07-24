From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 03:37:24 +0000
Subject: [PATCH 01/08] ARM: shmobile: Remove sh73a0 use of <mach/hardware.h>
Message-Id: <20130724033724.30567.31754.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724033715.30567.82782.sendpatchset@w520>
In-Reply-To: <20130724033715.30567.82782.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on sh73a0.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh73a0.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/setup-sh73a0.c
+++ work/arch/arm/mach-shmobile/setup-sh73a0.c	2013-07-23 16:00:03.000000000 +0900
@@ -34,7 +34,6 @@
 #include <linux/platform_data/sh_ipmmu.h>
 #include <linux/platform_data/irq-renesas-intc-irqpin.h>
 #include <mach/dma-register.h>
-#include <mach/hardware.h>
 #include <mach/irqs.h>
 #include <mach/sh73a0.h>
 #include <mach/common.h>
