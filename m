From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Oct 2015 02:29:36 +0000
Subject: [PATCH] arm64: renesas: salvator-x: add missing AUDIO_CLKx/AUDIO_CLKOUTx
Message-Id: <87a8r1gkkk.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index ba31bdc..f3b8dbf 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -102,7 +102,8 @@
 	};
 
 	sound_clk_pins: sound_clk {
-		renesas,groups = "audio_clkout3_a";
+		renesas,groups = "audio_clk_a_a", "audio_clk_b_a", "audio_clk_c_a",
+				 "audio_clkout_a", "audio_clkout3_a";
 		renesas,function = "audio_clk";
 	};
 
-- 
1.9.1

