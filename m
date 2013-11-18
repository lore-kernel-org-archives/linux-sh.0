From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Nov 2013 02:51:39 +0000
Subject: [PATCH 1/3] ARM: shmobile: bockw: remove unused RSND_SSI_CLK_FROM_ADG
Message-Id: <87haba777r.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

92eba04e4bcd469518cc759ac1bf1a49acaa5cc1
(ASoC: rcar: remove RSND_SSI_CLK_FROM_ADG) removed
RSND_SSI_CLK_FROM_ADG, it is no longer needed

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Mark

Could you please give your Ack ?

 arch/arm/mach-shmobile/board-bockw.c |    4 ++--
 include/sound/rcar_snd.h             |    1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-bockw.c b/arch/arm/mach-shmobile/board-bockw.c
index 1b1dae3..ffca67c 100644
--- a/arch/arm/mach-shmobile/board-bockw.c
+++ b/arch/arm/mach-shmobile/board-bockw.c
@@ -308,11 +308,11 @@ static struct rsnd_ssi_platform_info rsnd_ssi[] = {
 	RSND_SSI_UNUSED, /* SSI 1 */
 	RSND_SSI_UNUSED, /* SSI 2 */
 	RSND_SSI_SET(1, 0, gic_iid(0x85), RSND_SSI_PLAY),
-	RSND_SSI_SET(2, 0, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE | RSND_SSI_CLK_FROM_ADG),
+	RSND_SSI_SET(2, 0, gic_iid(0x85), RSND_SSI_CLK_PIN_SHARE),
 	RSND_SSI_SET(0, 0, gic_iid(0x86), RSND_SSI_PLAY),
 	RSND_SSI_SET(0, 0, gic_iid(0x86), 0),
 	RSND_SSI_SET(3, 0, gic_iid(0x86), RSND_SSI_PLAY),
-	RSND_SSI_SET(4, 0, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE | RSND_SSI_CLK_FROM_ADG),
+	RSND_SSI_SET(4, 0, gic_iid(0x86), RSND_SSI_CLK_PIN_SHARE),
 };
 
 static struct rsnd_scu_platform_info rsnd_scu[9] = {
diff --git a/include/sound/rcar_snd.h b/include/sound/rcar_snd.h
index 12afab1..6ce506b 100644
--- a/include/sound/rcar_snd.h
+++ b/include/sound/rcar_snd.h
@@ -34,7 +34,6 @@
  * B : SSI direction
  */
 #define RSND_SSI_CLK_PIN_SHARE		(1 << 31)
-#define RSND_SSI_CLK_FROM_ADG		(1 << 30) /* clock parent is master */
 #define RSND_SSI_SYNC			(1 << 29) /* SSI34_sync etc */
 
 #define RSND_SSI_PLAY			(1 << 24)
-- 
1.7.9.5

