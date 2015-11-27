From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 27 Nov 2015 01:04:41 +0000
Subject: [PATCH] arm64: renesas: salvator-x: set ak4613 In/Out pin as single-end
Message-Id: <87mvu0s19n.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
>> Simon

This patch is based on
http://thread.gmane.org/gmane.linux.alsa.devel/147227
But, it do nothing without above patch.
Thus, I think you don't need to wait/merge above ASoC branch

 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 3417de4..50807b4 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -197,6 +197,15 @@
 		#sound-dai-cells = <0>;
 		reg = <0x10>;
 		clocks = <&rcar_sound 3>;
+
+		asahi-kasei,in1-single-end;
+		asahi-kasei,in2-single-end;
+		asahi-kasei,out1-single-end;
+		asahi-kasei,out2-single-end;
+		asahi-kasei,out3-single-end;
+		asahi-kasei,out4-single-end;
+		asahi-kasei,out5-single-end;
+		asahi-kasei,out6-single-end;
 	};
 
 	cs2000: clk_multiplier@4f {
-- 
1.9.1

