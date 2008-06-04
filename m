From: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
Date: Wed, 04 Jun 2008 08:16:15 +0000
Subject: [PATCH] sh: Fix compile error SH7763 setup code
Message-Id: <48464F4F.5040203@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

SH7763's setup code use old DECLARE_INTC_DESC.
There was a compile error because of this.

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7763.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
index ae2b222..f189a55 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7763.c
@@ -291,8 +291,9 @@ static struct intc_sense_reg irq_sense_registers[] __initdata = {
 };

 static DECLARE_INTC_DESC(intc_irq_desc, "sh7763-irq", irq_vectors,
-			 NULL, NULL, irq_mask_registers, irq_prio_registers,
-			 irq_sense_registers);
+			NULL, irq_mask_registers, irq_prio_registers,
+			irq_sense_registers);
+

 /* External interrupt pins in IRL mode */
 static struct intc_vect irl_vectors[] __initdata = {
@@ -324,10 +325,10 @@ static struct intc_mask_reg irl7654_mask_registers[] __initdata = {
 };

 static DECLARE_INTC_DESC(intc_irl7654_desc, "sh7763-irl7654", irl_vectors,
-			 NULL, NULL, irl7654_mask_registers, NULL, NULL);
+			NULL, irl7654_mask_registers, NULL, NULL);

 static DECLARE_INTC_DESC(intc_irl3210_desc, "sh7763-irl3210", irl_vectors,
-			 NULL, NULL, irl3210_mask_registers, NULL, NULL);
+			NULL, irl3210_mask_registers, NULL, NULL);

 #define INTC_ICR0	0xffd00000
 #define INTC_INTMSK0	0xffd00044
-- 
1.5.5.1

