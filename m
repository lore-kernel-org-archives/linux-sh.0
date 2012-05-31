From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 31 May 2012 00:29:43 +0000
Subject: [PATCH 2/2] ARM: mach-shmobile: kzm9g: add FSI DMAEngine support
Message-Id: <87bol58a6j.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5pn7ww6.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5pn7ww6.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index d357b34..1ec7e50 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -279,6 +279,7 @@ static struct platform_device gpio_keys_device = {
 /* FSI-AK4648 */
 static struct sh_fsi_platform_info fsi_info = {
 	.port_a = {
+		.tx_id = SHDMA_SLAVE_FSI2A_TX,
 	},
 };
 
-- 
1.7.5.4

