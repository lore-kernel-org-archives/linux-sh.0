From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 02 Sep 2013 03:33:49 +0000
Subject: [PATCH] ARM: shmobile: armadillo: fixup ether pinctrol naming
Message-Id: <87fvtnsxr9.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

e5c9b4cd665106d9b5397114ea81a53059410b6a
(sh_eth: get R8A7740 support out of #ifdef)
exchanged sh-eth driver name to r8a7740-gether,
but, eva_pinctrl_map[] didn't follow it.
This patch fixes it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/mach-shmobile/board-armadillo800eva.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index c5be60d..33f219e 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1069,9 +1069,9 @@ static const struct pinctrl_map eva_pinctrl_map[] = {
 	PIN_MAP_MUX_GROUP_DEFAULT("asoc-simple-card.1", "pfc-r8a7740",
 				  "fsib_mclk_in", "fsib"),
 	/* GETHER */
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7740-gether", "pfc-r8a7740",
 				  "gether_mii", "gether"),
-	PIN_MAP_MUX_GROUP_DEFAULT("sh-eth", "pfc-r8a7740",
+	PIN_MAP_MUX_GROUP_DEFAULT("r8a7740-gether", "pfc-r8a7740",
 				  "gether_int", "gether"),
 	/* HDMI */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-mobile-hdmi", "pfc-r8a7740",
-- 
1.7.9.5

