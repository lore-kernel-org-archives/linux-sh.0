From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 12 Oct 2012 01:39:36 +0000
Subject: [PATCH] ARM: shmobile: armadillo800eva: enable restart
Message-Id: <87r4p4bh9o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fw7w38mf.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Cc: Masahiro Nakai <nakai@atmark-techno.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 3cc8b1c..499e6e3 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1229,6 +1229,13 @@ static void __init eva_add_early_devices(void)
 	shmobile_timer.init = eva_earlytimer_init;
 }
 
+#define RESCNT2 IOMEM(0xe6188020)
+static void eva_restart(char mode, const char *cmd)
+{
+	/* Do soft power on reset */
+	writel((1 << 31), RESCNT2);
+}
+
 static const char *eva_boards_compat_dt[] __initdata = {
 	"renesas,armadillo800eva",
 	NULL,
@@ -1243,4 +1250,5 @@ DT_MACHINE_START(ARMADILLO800EVA_DT, "armadillo800eva")
 	.init_late	= shmobile_init_late,
 	.timer		= &shmobile_timer,
 	.dt_compat	= eva_boards_compat_dt,
+	.restart	= eva_restart,
 MACHINE_END
-- 
1.7.9.5

