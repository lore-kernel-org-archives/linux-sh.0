From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 14 Jul 2015 04:57:05 +0000
Subject: [PATCH 2/3] ARM: shmobile: koelsch: add sound label on DTS
Message-Id: <874ml7bar5.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

It is easy to modify settings for Test or other purpose if sound has label

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index cffe33f..dc15884 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -242,7 +242,7 @@
 			  1800000 0>;
 	};
 
-	sound {
+	rsnd_ak4643: sound {
 		compatible = "simple-audio-card";
 
 		simple-audio-card,format = "left_j";
-- 
1.9.1

