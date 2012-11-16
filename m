From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 16 Nov 2012 10:34:49 +0000
Subject: [PATCH 02/04] ARM: mach-shmobile: sh7372 INTC DT section mismatch fix
Message-Id: <20121116103449.4231.27320.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Fix section mismatches in the sh7372 INTC DT code.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Applies to the devel/of branch of
 git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git

 arch/arm/mach-shmobile/intc-sh7372.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- 0003/arch/arm/mach-shmobile/intc-sh7372.c
+++ work/arch/arm/mach-shmobile/intc-sh7372.c	2012-11-16 15:31:45.000000000 +0900
@@ -40,7 +40,7 @@ static struct intc_desc intca_irq_pins_h
 static struct resource intca_pins_hi_resources[1] __initdata;
 static unsigned short intevtsa_vect;
 
-static int sh7372_intca_of_init(struct device_node *np,
+static int __init sh7372_intca_of_init(struct device_node *np,
 			struct device_node *parent)
 {
 	int ret;
@@ -65,7 +65,7 @@ error:
 	return ret;
 }
 
-static int sh7372_intcs_of_init(struct device_node *np,
+static int __init sh7372_intcs_of_init(struct device_node *np,
 			struct device_node *parent)
 {
 	int ret;
@@ -93,7 +93,7 @@ error:
 	return ret;
 }
 
-static int sh7372_intca_pins_lo_of_init(struct device_node *np,
+static int __init sh7372_intca_pins_lo_of_init(struct device_node *np,
 				    struct device_node *parent)
 {
 	int ret;
@@ -120,7 +120,7 @@ error:
 	return ret;
 }
 
-static int sh7372_intca_pins_hi_of_init(struct device_node *np,
+static int __init sh7372_intca_pins_hi_of_init(struct device_node *np,
 				    struct device_node *parent)
 {
 	int ret;
