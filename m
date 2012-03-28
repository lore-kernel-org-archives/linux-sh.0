From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 28 Mar 2012 10:22:54 +0000
Subject: [PATCH 04/06] ARM: mach-shmobile: Use 0x3400 as INTCS vector offset
Message-Id: <20120328102254.18870.73004.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
References: <20120328064050.28557.46203.sendpatchset@w520>
In-Reply-To: <20120328064050.28557.46203.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update mach-shmobile to use 0x3400 as INTCS_VECT_BASE.

Since the ARM architecture a little while back added support
for 10 bit irqs we can now undo the previously merged commit
9b7c23adb350a108737a993c9c781463c1439dc6 and use 0x3400 as
INTCS vector base.

This change is necessary to avoid overlapping of interrupt
ranges so separate IRQ domains can be used for different INTC
instances. Without this fix the vectors used by various INTC
instances are overlapping on for instance sh7372 which works
at the moment but breaks upcoming IRQ domain support.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/irqs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0005/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2012-03-27 18:25:17.000000000 +0900
@@ -13,7 +13,7 @@
 #define irq2evt(irq)		(((irq) + 16 - NR_IRQS_LEGACY) << 5)
 
 /* INTCS */
-#define INTCS_VECT_BASE		0x2200
+#define INTCS_VECT_BASE		0x3400
 #define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
 #define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
 
