From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Jun 2012 10:39:30 +0000
Subject: [PATCH 2/3] ARM: shmobile: kzm9g: enable DMAEngine on FSI
Message-Id: <87pq8nk74x.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <8762afllwu.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <8762afllwu.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

It is possible to reduce CPU load if FSI playback used DMAEngine.
This patch enabled it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index b056b7a..212c524 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -470,6 +470,7 @@ static struct platform_device gpio_keys_device = {
 /* FSI-AK4648 */
 static struct sh_fsi_platform_info fsi_info = {
 	.port_a = {
+		.tx_id = SHDMA_SLAVE_FSI2A_TX,
 	},
 };
 
-- 
1.7.5.4

