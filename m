From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 Feb 2008 09:49:27 +0000
Subject: [PATCH] smc91x: Add MigoR board support
Message-Id: <20080208094927.2020.3230.sendpatchset@clockwork.opensource.se>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

This patch adds MigoR board support to the smc91x driver.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/net/smc91x.h |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- 0001/drivers/net/smc91x.h
+++ work/drivers/net/smc91x.h	2008-02-06 23:13:55.000000000 +0900
@@ -306,6 +306,20 @@ SMC_outw(u16 val, void __iomem *ioaddr, 
 #define SMC_insw(a, r, p, l)   insw((a) + (r), p, l)
 #define SMC_outsw(a, r, p, l)  outsw((a) + (r), p, l)
 
+#elif defined(CONFIG_SH_MIGOR)
+
+#define SMC_IRQ_FLAGS		(-1)
+#define SMC_CAN_USE_8BIT	0
+#define SMC_CAN_USE_16BIT	1
+#define SMC_CAN_USE_32BIT	0
+#define SMC_IO_SHIFT		0
+#define SMC_NOWAIT		1
+
+#define SMC_inw(a, r)		inw((a) + (r))
+#define SMC_outw(v, a, r)	outw(v, (a) + (r))
+#define SMC_insw(a, r, p, l)	insw((a) + (r), p, l)
+#define SMC_outsw(a, r, p, l)	outsw((a) + (r), p, l)
+
 #else /* BOARDS */
 
 #define SMC_CAN_USE_8BIT       1
