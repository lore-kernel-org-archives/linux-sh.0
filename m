From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 15 Jun 2015 04:53:11 +0000
Subject: [PATCH 1/6][RFC] clk: shmobile: add CPG common lock support for Gen3
Message-Id: <874mm9wp5h.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Gen3 needs to access CPG write protect register for CPG/MSTP.
This patch adds common spin lock method for it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/clk/shmobile/Makefile   |  1 +
 drivers/clk/shmobile/rcar-clk.c | 30 ++++++++++++++++++++++++++++++
 drivers/clk/shmobile/rcar-clk.h | 21 +++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 drivers/clk/shmobile/rcar-clk.c
 create mode 100644 drivers/clk/shmobile/rcar-clk.h

diff --git a/drivers/clk/shmobile/Makefile b/drivers/clk/shmobile/Makefile
index 97c71c8..6790268 100644
--- a/drivers/clk/shmobile/Makefile
+++ b/drivers/clk/shmobile/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_ARCH_R8A7794)		+= clk-rcar-gen2.o
 obj-$(CONFIG_ARCH_SH73A0)		+= clk-sh73a0.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-div6.o
 obj-$(CONFIG_ARCH_SHMOBILE_MULTI)	+= clk-mstp.o
+obj-$(CONFIG_ARCH_RCAR_GEN3)		+= rcar-clk.o
diff --git a/drivers/clk/shmobile/rcar-clk.c b/drivers/clk/shmobile/rcar-clk.c
new file mode 100644
index 0000000..57943aa
--- /dev/null
+++ b/drivers/clk/shmobile/rcar-clk.c
@@ -0,0 +1,30 @@
+/*
+ * rcar-clk.c
+ *
+ * Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#include <linux/spinlock.h>
+
+static DEFINE_SPINLOCK(rcar_cpg_lock);
+
+/*
+ * R-Car Gen3 needs CPGWPCR write protection for
+ *	CPG
+ *	MSTP
+ *	APMU
+ * these lock/unlock are for CPGWPCR
+ */
+
+void rcar_cpgwpcr_lock(unsigned long *flags)
+{
+	spin_lock_irqsave(&rcar_cpg_lock, *flags);
+}
+
+void rcar_cpgwpcr_unlock(unsigned long *flags)
+{
+	spin_unlock_irqrestore(&rcar_cpg_lock, *flags);
+}
diff --git a/drivers/clk/shmobile/rcar-clk.h b/drivers/clk/shmobile/rcar-clk.h
new file mode 100644
index 0000000..12cf2f0
--- /dev/null
+++ b/drivers/clk/shmobile/rcar-clk.h
@@ -0,0 +1,21 @@
+/*
+ * rcar-clk.h
+ *
+ * Copyright (c) 2015 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __RCAR_CLK_H
+#define __RCAR_CLK_H
+
+#if defined(CONFIG_ARCH_RCAR_GEN3)
+void rcar_cpgwpcr_lock(unsigned long *flags);
+void rcar_cpgwpcr_unlock(unsigned long *flags);
+#else
+#define rcar_cpgwpcr_lock(flags)
+#define rcar_cpgwpcr_unlock(flags)
+#endif
+
+#endif /* __RCAR_CLK_H */
-- 
1.9.1

