From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Dec 2014 09:42:14 +0000
Subject: [PATCH v2 01/05] ARM: shmobile: kzm9g-reference: 0x48008000 load address
Message-Id: <20141217094214.7039.68681.sendpatchset@w520>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Magnus Damm <damm+renesas@opensource.se>

Adjust the load address for the KZM9G DT reference case
to make it compatible with upcoming sh73a0 Multiplatform
and CONFIG_AUTO_ZRELADDR=y.

Without the not-yet-merged sh73a0 multiplatform support
the KZM9G uImage can be built without any special care,
but once we go DTS-only then the Makefile.boot entry will
disappear and the Multiplatform image will be built using
CONFIG_AUTO_ZRELADDR=y. To generate an uImage for KZM9G
the following example can be followed:

$ make ARCH=arm LOADADDR=0x48008000 uImage

For now simply adjust the non-multiplatform KZM9G DT
reference implementation to be compatible with ZRELADDR.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
---

 arch/arm/mach-shmobile/Makefile.boot |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 0001/arch/arm/mach-shmobile/Makefile.boot
+++ work/arch/arm/mach-shmobile/Makefile.boot	2014-12-17 16:21:58.000000000 +0900
@@ -6,7 +6,7 @@ loadaddr-$(CONFIG_MACH_ARMADILLO800EVA)
 loadaddr-$(CONFIG_MACH_BOCKW) += 0x60008000
 loadaddr-$(CONFIG_MACH_BOCKW_REFERENCE) += 0x60008000
 loadaddr-$(CONFIG_MACH_KZM9G) += 0x41008000
-loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x41008000
+loadaddr-$(CONFIG_MACH_KZM9G_REFERENCE) += 0x48008000
 loadaddr-$(CONFIG_MACH_MACKEREL) += 0x40008000
 loadaddr-$(CONFIG_MACH_MARZEN) += 0x60008000
 
