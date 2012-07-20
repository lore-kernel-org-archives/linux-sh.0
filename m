From: Tetsuyuki Kobayshi <koba@kmckk.co.jp>
Date: Fri, 20 Jul 2012 06:16:30 +0000
Subject: [PATCH] ARM: shmobile: kzm9g: enable restarting
Message-Id: <1342764990-30715-1-git-send-email-koba@kmckk.co.jp>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

Do soft-power-on-reset in sys_reboot system call.

How to test this patch
  Execute "sudo reboot" from command line. The system will start shutdown
  sequence and finally reboot and U-Boot restarts.

Cc: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon Horman <horms@verge.net.au>
Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
This patch is based on renesas.git next branch.

 arch/arm/mach-shmobile/board-kzm9g.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 53b7ea9..fd21fb6 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -763,6 +763,13 @@ static void __init kzm_init(void)
 	platform_add_devices(kzm_devices, ARRAY_SIZE(kzm_devices));
 }
 
+static void kzm9g_restart(char mode, const char *cmd)
+{
+#define RESCNT2 0xe6188020
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
 static const char *kzm9g_boards_compat_dt[] __initdata = {
 	"renesas,kzm9g",
 	NULL,
@@ -777,5 +784,6 @@ DT_MACHINE_START(KZM9G_DT, "kzm9g")
 	.init_machine	= kzm_init,
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
+	.restart	= kzm9g_restart,
 	.dt_compat	= kzm9g_boards_compat_dt,
 MACHINE_END
-- 
1.7.9.5

