From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 01 Aug 2012 08:44:57 +0000
Subject: [PATCH] sh: explicitly include sh_dma.h in setup-sh7722.c
Message-Id: <Pine.LNX.4.64.1208011044150.5406@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

setup-sh7722.c defines several objects, whose types are defined in
sh_dma.h, so, it has to be included explicitly.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7722.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
index 65786c7..6a868b0 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7722.c
@@ -12,6 +12,7 @@
 #include <linux/platform_device.h>
 #include <linux/serial.h>
 #include <linux/serial_sci.h>
+#include <linux/sh_dma.h>
 #include <linux/sh_timer.h>
 #include <linux/sh_intc.h>
 #include <linux/uio_driver.h>
-- 
1.7.2.5

