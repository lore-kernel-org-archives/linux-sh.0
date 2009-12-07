From: Nicolas Palix <npalix@diku.dk>
Date: Mon, 07 Dec 2009 09:46:26 +0000
Subject: [PATCH] arch/sh: Replace an explicit computation by the use of the container_of macro
Message-Id: <200912071046.27330.npalix@diku.dk>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>, kernel-janitors@vger.kernel.org, Stuart Menefy <stuart.menefy@st.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

From 945e75c0e3202ab4cd0b8f185ea4be5609806edb Mon Sep 17 00:00:00 2001
From: Nicolas Palix <npalix@diku.dk>
Date: Mon, 7 Dec 2009 10:38:55 +0100

The macro container_of from kernel.h performs the same
pointer arithmetic operation.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@
type T;
expression mptr;
expression member;
@@

- (void *)((char *)mptr - offsetof(T, member))
+ container_of(mptr, T, member)
// </smpl>

Signed-off-by: Nicolas Palix <npalix@diku.dk>
---
 arch/sh/kernel/cpu/irq/ipr.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/sh/kernel/cpu/irq/ipr.c b/arch/sh/kernel/cpu/irq/ipr.c
index c1508a9..9282d96 100644
--- a/arch/sh/kernel/cpu/irq/ipr.c
+++ b/arch/sh/kernel/cpu/irq/ipr.c
@@ -17,16 +17,17 @@
  * for more details.
  */
 #include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/io.h>
-#include <linux/interrupt.h>
 #include <linux/topology.h>
 
 static inline struct ipr_desc *get_ipr_desc(unsigned int irq)
 {
 	struct irq_chip *chip = get_irq_chip(irq);
-	return (void *)((char *)chip - offsetof(struct ipr_desc, chip));
+	return container_of(chip, struct ipr_desc, chip);
 }
 
 static void disable_ipr_irq(unsigned int irq)
-- 
1.6.0.4

