From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 14 Dec 2010 07:15:35 +0000
Subject: [PATCH] ARM: mach-shmobile: Fix up pinmux entries in Makefile
Message-Id: <20101214071535.11037.17853.sendpatchset@t400s>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm@opensource.se>

Compiling in multiple CPUs into the same kernel binary
requires a Makefile update. With this patch in place
it is possible to enable the pinmux code for both the
SH7372 and the SH7377.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2010-12-14 13:47:18.000000000 +0900
@@ -12,11 +12,11 @@ obj-$(CONFIG_ARCH_SH7372)	+= setup-sh737
 obj-$(CONFIG_ARCH_SH73A0)	+= setup-sh73a0.o clock-sh73a0.o
 
 # Pinmux setup
-pfc-$(CONFIG_ARCH_SH7367)	:= pfc-sh7367.o
-pfc-$(CONFIG_ARCH_SH7377)	:= pfc-sh7377.o
-pfc-$(CONFIG_ARCH_SH7372)	:= pfc-sh7372.o
-pfc-$(CONFIG_ARCH_SH73A0)	:= pfc-sh73a0.o
-obj-$(CONFIG_GENERIC_GPIO)	+= $(pfc-y)
+pfc-y				:+pfc-$(CONFIG_ARCH_SH7367)	+= pfc-sh7367.o
+pfc-$(CONFIG_ARCH_SH7377)	+= pfc-sh7377.o
+pfc-$(CONFIG_ARCH_SH7372)	+= pfc-sh7372.o
+pfc-$(CONFIG_ARCH_SH73A0)	+= pfc-sh73a0.o
 
 # Board objects
 obj-$(CONFIG_MACH_G3EVM)	+= board-g3evm.o
@@ -24,3 +24,6 @@ obj-$(CONFIG_MACH_G4EVM)	+= board-g4evm.
 obj-$(CONFIG_MACH_AP4EVB)	+= board-ap4evb.o
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
 obj-$(CONFIG_MACH_MACKEREL)	+= board-mackerel.o
+
+# Framework support
+obj-$(CONFIG_GENERIC_GPIO)	+= $(pfc-y)
