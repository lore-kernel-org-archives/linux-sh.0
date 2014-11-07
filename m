From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri, 07 Nov 2014 13:46:32 +0000
Subject: [PATCH 1/2] ARM: shmobile: kzm9g-reference: Add restart callback
Message-Id: <1415367993-31033-1-git-send-email-geert+renesas@glider.be>
List-Id: <linux-sh.vger.kernel.org>
References: <1385428879-26849-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1385428879-26849-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Port the sh73a0 restart handling from the kzm9g-legacy board code to the
kzm9g-reference board code.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Tested on kzm9g-reference

 arch/arm/mach-shmobile/board-kzm9g-reference.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c b/arch/arm/mach-shmobile/board-kzm9g-reference.c
index f2ef759b6e969cc8..2e82e44ab85258b7 100644
--- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
+++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
@@ -39,6 +39,13 @@ static void __init kzm_init(void)
 #endif
 }
 
+#define RESCNT2 IOMEM(0xe6188020)
+static void kzm9g_restart(enum reboot_mode mode, const char *cmd)
+{
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
 static const char *kzm9g_boards_compat_dt[] __initdata = {
 	"renesas,kzm9g-reference",
 	NULL,
@@ -50,5 +57,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g-reference")
 	.init_early	= shmobile_init_delay,
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
+	.restart	= kzm9g_restart,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
1.9.1

