From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 30 Oct 2015 02:29:04 +0000
Subject: [PATCH] arm64: renesas: tidyup AUDIO_CLKOUTx frequency
Message-Id: <87bnbhgklg.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

AUDIO_CLKOUTx are generated from AUDIO_CLKx, and Salvator-X has
AUDIO_CLKA from X11, AUDIO_CLKB from CS2000, AUDIO_CLKC from ADV7482.
And AUDIO_CLKOUTx are used as AK4613 / CS2000 system clock.
Because of this, generate AUDIO_CLKOUTx from AUDIO_CLKA (= X11) is
stable. This patch tidyup it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 86b70ce..ba31bdc 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -160,7 +160,7 @@
 
 	/* audio_clkout0/1/2/3 */
 	#clock-cells = <1>;
-	clock-frequency = <12288000>;
+	clock-frequency = <11289600>;
 
 	status = "okay";
 
-- 
1.9.1

