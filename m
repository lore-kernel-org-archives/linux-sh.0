From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 19 May 2010 10:29:47 +0000
Subject: [PATCH] ARM: mach-shmobile: Use 0x2200 as INTCS_VECT_BASE
Message-Id: <20100519102947.29201.13518.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Change INTCS_VECT_BASE from 0x3400 to 0x2200.

The old value 0x3400 gave the INTCA and INTCS interrupt
conrollers separated spaces, but required ARM support
for more than 512 NR_IRQS which is not in place at this
point.

The value 0x2200 will make some of the INTCA interrupts
make use of empty INTCS areas. This is a bit more error
prone but works fine as a workaround for G3, G3 and AP4.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/include/mach/irqs.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/include/mach/irqs.h
+++ work/arch/arm/mach-shmobile/include/mach/irqs.h	2010-05-19 19:01:07.000000000 +0900
@@ -9,7 +9,7 @@
 #define irq2evt(irq)		(((irq) + 16) << 5)
 
 /* INTCS */
-#define INTCS_VECT_BASE		0x3400
+#define INTCS_VECT_BASE		0x2200
 #define INTCS_VECT(n, vect)	INTC_VECT((n), INTCS_VECT_BASE + (vect))
 #define intcs_evt2irq(evt)	evt2irq(INTCS_VECT_BASE + (evt))
 
