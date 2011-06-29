From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Wed, 29 Jun 2011 04:23:47 +0000
Subject: [PATCH] sh: fix the INTC vector for IRQ and IRL in setup-sh7757
Message-Id: <4E0AA8D3.7040205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 arch/sh/kernel/cpu/sh4a/setup-sh7757.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
index 6eba96b..e915dea 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7757.c
@@ -1089,13 +1089,13 @@ static DECLARE_INTC_DESC(intc_desc, "sh7757", vectors, groups,

 /* Support for external interrupt pins in IRQ mode */
 static struct intc_vect vectors_irq0123[] __initdata = {
-	INTC_VECT(IRQ0, 0x240), INTC_VECT(IRQ1, 0x280),
-	INTC_VECT(IRQ2, 0x2c0), INTC_VECT(IRQ3, 0x300),
+	INTC_VECT(IRQ0, 0x200), INTC_VECT(IRQ1, 0x240),
+	INTC_VECT(IRQ2, 0x280), INTC_VECT(IRQ3, 0x2c0),
 };

 static struct intc_vect vectors_irq4567[] __initdata = {
-	INTC_VECT(IRQ4, 0x340), INTC_VECT(IRQ5, 0x380),
-	INTC_VECT(IRQ6, 0x3c0), INTC_VECT(IRQ7, 0x200),
+	INTC_VECT(IRQ4, 0x300), INTC_VECT(IRQ5, 0x340),
+	INTC_VECT(IRQ6, 0x380), INTC_VECT(IRQ7, 0x3c0),
 };

 static struct intc_sense_reg sense_registers[] __initdata = {
@@ -1129,14 +1129,14 @@ static struct intc_vect vectors_irl0123[] __initdata = {
 };

 static struct intc_vect vectors_irl4567[] __initdata = {
-	INTC_VECT(IRL4_LLLL, 0xb00), INTC_VECT(IRL4_LLLH, 0xb20),
-	INTC_VECT(IRL4_LLHL, 0xb40), INTC_VECT(IRL4_LLHH, 0xb60),
-	INTC_VECT(IRL4_LHLL, 0xb80), INTC_VECT(IRL4_LHLH, 0xba0),
-	INTC_VECT(IRL4_LHHL, 0xbc0), INTC_VECT(IRL4_LHHH, 0xbe0),
-	INTC_VECT(IRL4_HLLL, 0xc00), INTC_VECT(IRL4_HLLH, 0xc20),
-	INTC_VECT(IRL4_HLHL, 0xc40), INTC_VECT(IRL4_HLHH, 0xc60),
-	INTC_VECT(IRL4_HHLL, 0xc80), INTC_VECT(IRL4_HHLH, 0xca0),
-	INTC_VECT(IRL4_HHHL, 0xcc0),
+	INTC_VECT(IRL4_LLLL, 0x200), INTC_VECT(IRL4_LLLH, 0x220),
+	INTC_VECT(IRL4_LLHL, 0x240), INTC_VECT(IRL4_LLHH, 0x260),
+	INTC_VECT(IRL4_LHLL, 0x280), INTC_VECT(IRL4_LHLH, 0x2a0),
+	INTC_VECT(IRL4_LHHL, 0x2c0), INTC_VECT(IRL4_LHHH, 0x2e0),
+	INTC_VECT(IRL4_HLLL, 0x300), INTC_VECT(IRL4_HLLH, 0x320),
+	INTC_VECT(IRL4_HLHL, 0x340), INTC_VECT(IRL4_HLHH, 0x360),
+	INTC_VECT(IRL4_HHLL, 0x380), INTC_VECT(IRL4_HHLH, 0x3a0),
+	INTC_VECT(IRL4_HHHL, 0x3c0),
 };

 static DECLARE_INTC_DESC(intc_desc_irl0123, "sh7757-irl0123", vectors_irl0123,
-- 
1.7.1
