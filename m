From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 14 Nov 2013 10:27:32 +0000
Subject: [PATCH 07/17] ARM: shmobile: marzen: remove SDHI0 WP pin setting
Message-Id: <878uwrz3an.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<87bo1nz3c9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo1nz3c9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon <horms@verge.net.au>
Cc: Laurent <laurent.pinchart@ideasonboard.com>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

WP pin is not implemented on Marzen

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-marzen.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-marzen.c b/arch/arm/mach-shmobile/board-marzen.c
index fa102f7..2288dc2 100644
--- a/arch/arm/mach-shmobile/board-marzen.c
+++ b/arch/arm/mach-shmobile/board-marzen.c
@@ -346,8 +346,6 @@ static const struct pinctrl_map marzen_pinctrl_map[] = {
 				  "sdhi0_ctrl", "sdhi0"),
 	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
 				  "sdhi0_cd", "sdhi0"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh_mobile_sdhi.0", "pfc-r8a7779",
-				  "sdhi0_wp", "sdhi0"),
 	/* SMSC */
 	PIN_MAP_MUX_GROUP_DEFAULT("smsc911x", "pfc-r8a7779",
 				  "intc_irq1_b", "intc"),
-- 
1.7.9.5

