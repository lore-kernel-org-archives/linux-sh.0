From: Roel Kluin <roel.kluin@gmail.com>
Date: Thu, 21 May 2009 18:25:23 +0000
Subject: [PATCH] SUPERH:beyond ARRAY_SIZE of onchip_ops
Message-Id: <4A159C93.2030000@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Do not go beyond ARRAY_SIZE of onchip_ops

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
index 0e174af..d4757ad 100644
--- a/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
+++ b/arch/sh/kernel/cpu/sh4a/clock-sh7722.c
@@ -809,7 +809,7 @@ struct clk_ops *onchip_ops[] = {
 void __init
 arch_init_clk_ops(struct clk_ops **ops, int type)
 {
-	BUG_ON(type < 0 || type > ARRAY_SIZE(onchip_ops));
+	BUG_ON(type < 0 || type >= ARRAY_SIZE(onchip_ops));
 	*ops = onchip_ops[type];
 }
 

