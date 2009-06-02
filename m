From: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Date: Tue, 02 Jun 2009 02:49:28 +0000
Subject: [PATCH 4/4] sh7723: add l2_cache_init support
Message-Id: <u8wkbe4ef.wl%morimoto.kuninori@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7723.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
index 04cb4aa..d8f4a13 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7723.c
@@ -14,6 +14,7 @@
 #include <linux/serial_sci.h>
 #include <linux/uio_driver.h>
 #include <linux/sh_timer.h>
+#include <linux/io.h>
 #include <asm/clock.h>
 #include <asm/mmzone.h>
 
@@ -485,6 +486,15 @@ void __init plat_early_device_setup(void)
 				   ARRAY_SIZE(sh7723_early_devices));
 }
 
+#define RAMCR_CACHE_L2FC	0x0002
+#define RAMCR_CACHE_L2E		0x0001
+#define L2_CACHE_ENABLE		(RAMCR_CACHE_L2E|RAMCR_CACHE_L2FC)
+void __uses_jump_to_uncached l2_cache_init(void)
+{
+	/* Enable L2 cache */
+	ctrl_outl(L2_CACHE_ENABLE, RAMCR);
+}
+
 enum {
 	UNUSED=0,
 
-- 
1.6.0.4

