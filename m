From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 10 Nov 2013 03:15:53 +0000
Subject: [PATCH v2 6/8] ARM: shmobile: Let Lager multiplatform boot with Lager DTB
Message-Id: <1384053355-30703-7-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
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
index 27414c9..97eed49 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -214,7 +214,7 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	r8a73a4-ape6evm-reference.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
-	r8a7790-lager-reference.dtb
+	r8a7790-lager.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_cyclone5.dtb \
 	socfpga_vt.dtb
 dtb-$(CONFIG_ARCH_SPEAR13XX) += spear1310-evb.dtb \
diff --git a/arch/arm/mach-shmobile/board-lager-reference.c b/arch/arm/mach-shmobile/board-lager-reference.c
index ff92d22..2964995 100644
--- a/arch/arm/mach-shmobile/board-lager-reference.c
+++ b/arch/arm/mach-shmobile/board-lager-reference.c
@@ -67,6 +67,7 @@ static void __init lager_add_standard_devices(void)
 }
 
 static const char *lager_boards_compat_dt[] __initdata = {
+	"renesas,lager",
 	"renesas,lager-reference",
 	NULL,
 };
-- 
1.8.1.5

