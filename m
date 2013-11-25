From: Simon Horman <horms+renesas@verge.net.au>
Date: Mon, 25 Nov 2013 01:18:31 +0000
Subject: [RFC 16/17] ARM: shmobile: Let Marzen multiplatform boot with Marzen DTB
Message-Id: <1385342312-1967-17-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Let the multiplatform Marzen support boot with the legacy DTS for
Marzen as well as the Marzen reference DTS.

Based on work for the Koelsch board by Laurent Pinchart.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/Makefile                       | 2 +-
 arch/arm/mach-shmobile/board-koelsch-reference.c | 1 +
 arch/arm/mach-shmobile/board-marzen-reference.c  | 1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 166e3dd..2812344 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -216,7 +216,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
-	r8a7779-marzen-reference.dtb \
+	r8a7779-marzen.dtb \
 	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index 25b558f..daad66a 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -38,6 +38,7 @@ static void __init koelsch_add_standard_devices(void)
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
+	"renesas,koelsch",
 	"renesas,koelsch-reference",
 	NULL,
 };
diff --git a/arch/arm/mach-shmobile/board-marzen-reference.c b/arch/arm/mach-shmobile/board-marzen-reference.c
index 7a240e5..2d60798 100644
--- a/arch/arm/mach-shmobile/board-marzen-reference.c
+++ b/arch/arm/mach-shmobile/board-marzen-reference.c
@@ -74,6 +74,7 @@ static void __init marzen_init(void)
 }
 
 static const char *marzen_boards_compat_dt[] __initdata = {
+	"renesas,marzen",
 	"renesas,marzen-reference",
 	NULL,
 };
-- 
1.8.4

