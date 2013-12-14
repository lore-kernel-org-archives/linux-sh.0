From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sat, 14 Dec 2013 15:25:37 +0000
Subject: [PATCH v5 13/17] ARM: shmobile: Let Koelsch multiplatform boot with Koelsch DTB
Message-Id: <1387034741-3852-14-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Let the multiplatform Koelsch support boot with the legacy DTS for
Koelsch as well as the Koelsch reference DTS.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/Makefile                       | 4 ++--
 arch/arm/mach-shmobile/board-koelsch-reference.c | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index f28b4ef..ee0f2bd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -234,8 +234,8 @@ dtb-$(CONFIG_ARCH_SHMOBILE_LEGACY) += emev2-kzm9d.dtb \
 	sh7372-mackerel.dtb
 dtb-$(CONFIG_ARCH_SHMOBILE_MULTI) += emev2-kzm9d.dtb \
 	r7s72100-genmai-reference.dtb \
-	r8a7790-lager.dtb \
-	r8a7791-koelsch-reference.dtb
+	r8a7791-koelsch.dtb \
+	r8a7790-lager.dtb
 dtb-$(CONFIG_ARCH_SOCFPGA) += socfpga_arria5_socdk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_sockit.dtb \
diff --git a/arch/arm/mach-shmobile/board-koelsch-reference.c b/arch/arm/mach-shmobile/board-koelsch-reference.c
index e1c787e..652b592 100644
--- a/arch/arm/mach-shmobile/board-koelsch-reference.c
+++ b/arch/arm/mach-shmobile/board-koelsch-reference.c
@@ -64,6 +64,7 @@ static void __init koelsch_add_standard_devices(void)
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
+	"renesas,koelsch",
 	"renesas,koelsch-reference",
 	NULL,
 };
-- 
1.8.3.2

