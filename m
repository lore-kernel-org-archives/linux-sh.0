From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Thu, 28 Nov 2013 01:03:48 +0000
Subject: [PATCH v3 11/15] ARM: shmobile: Let Lager multiplatform boot with Lager DTB
Message-Id: <1385600632-5181-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Let the multiplatform Lager support boot with the legacy DTS for Lager
as well as the Lager reference DTS.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/Makefile                     | 2 +-
 arch/arm/mach-shmobile/board-lager-reference.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 37aefa2..f28b4ef 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -234,7 +234,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
-	r8a7790-lager-reference.dtb \
+	r8a7790-lager.dtb \
 	r8a7791-koelsch-reference.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index 85a744b..0723a68 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -68,6 +68,7 @@ static void __init lager_add_standard_devices(void)
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
+	"renesas,lager",
 	"renesas,lager-reference",
 	NULL,
 };
-- 
1.8.3.2

