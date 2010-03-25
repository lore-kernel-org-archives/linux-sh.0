From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 25 Mar 2010 07:07:51 +0000
Subject: [PATCH 01/06] ARM: mach-shmobile: Makefile update for old clock code
Message-Id: <20100325070751.24148.47410.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Update the main SH-Mobile ARM Makefile to only build
the old clock framework code when CONFIG_COMMON_CLKDEV
is set. This variable is always set at this point.

This change allows us to easily move over to the clock
framework code from the SH architecture. In the future
we can enable the new code by selecting a new Kconfig
variable and deselecting CONFIG_COMMON_CLKDEV in one
atomic commit.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-03-25 12:45:59.000000000 +0900
@@ -6,9 +6,12 @@
 obj-y				:= timer.o console.o
 
 # CPU objects
-obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o clock-sh7367.o intc-sh7367.o
-obj-$(CONFIG_ARCH_SH7377)	+= setup-sh7377.o clock-sh7367.o intc-sh7377.o
-obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o clock-sh7367.o intc-sh7372.o
+obj-$(CONFIG_ARCH_SH7367)	+= setup-sh7367.o intc-sh7367.o
+obj-$(CONFIG_ARCH_SH7377)	+= setup-sh7377.o intc-sh7377.o
+obj-$(CONFIG_ARCH_SH7372)	+= setup-sh7372.o intc-sh7372.o
+
+# Clock framework
+obj-$(CONFIG_COMMON_CLKDEV)	+= clock-sh7367.o
 
 # Pinmux setup
 pfc-$(CONFIG_ARCH_SH7367)	:= pfc-sh7367.o
