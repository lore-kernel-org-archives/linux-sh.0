From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 24 Jul 2013 03:38:20 +0000
Subject: [PATCH 07/08] ARM: shmobile: Remove Marzen use of <mach/hardware.h>
Message-Id: <20130724033820.30567.27069.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20130724033715.30567.82782.sendpatchset@w520>
In-Reply-To: <20130724033715.30567.82782.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove unused <mach/hardware.h> on Marzen.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/board-marzen.c |    1 -
 1 file changed, 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/board-marzen.c
+++ work/arch/arm/mach-shmobile/board-marzen.c	2013-07-23 16:05:06.000000000 +0900
@@ -37,7 +37,6 @@
 #include <linux/mmc/host.h>
 #include <linux/mmc/sh_mobile_sdhi.h>
 #include <linux/mfd/tmio.h>
-#include <mach/hardware.h>
 #include <mach/r8a7779.h>
 #include <mach/common.h>
 #include <mach/irqs.h>
