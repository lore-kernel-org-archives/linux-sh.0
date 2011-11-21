From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Mon, 21 Nov 2011 15:56:06 +0000
Subject: [PATCH] PM: fix compile breakage on sh #ifndef CONFIG_PM_RUNTIME
Message-Id: <Pine.LNX.4.64.1111211642200.10414@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Fix the following compalitaion breakage:

In file included from linux/drivers/sh/pm_runtime.c:15:
linux/include/linux/pm_domain.h: In function 'dev_to_genpd':
linux/include/linux/pm_domain.h:142: error: implicit declaration of function 'ERR_PTR'
linux/include/linux/pm_domain.h:142: warning: return makes pointer from integer without a cast
In file included from linux/include/linux/sh_clk.h:10,
                 from linux/drivers/sh/pm_runtime.c:19:
linux/include/linux/err.h: At top level:
linux/include/linux/err.h:22: error: conflicting types for 'ERR_PTR'
linux/include/linux/pm_domain.h:142: note: previous implicit declaration of 'ERR_PTR' was here
make[3]: *** [drivers/sh/pm_runtime.o] Error 1

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 765083ad..b931682 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -10,6 +10,7 @@
 #define _LINUX_PM_DOMAIN_H
 
 #include <linux/device.h>
+#include <linux/err.h>
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
