From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 21 Nov 2014 00:54:51 +0000
Subject: [PATCH 25/29] ARM: shmobile: koelsch: add Volume Ramp usage on comment
Message-Id: <ce47481652106e955296651a1b76c0dd4561cfbc.1416476366.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1416476366.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1416476366.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index a10f534..487fc99 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -27,6 +27,15 @@
  *
  *	amixer set "DVC Out Mute" on
  *	amixer set "DVC In Mute" on
+ *
+ * You can use Volume Ramp
+ *
+ *	amixer set "DVC Out Ramp Up Rate"   "0.125 dB/64 steps"
+ *	amixer set "DVC Out Ramp Down Rate" "0.125 dB/512 steps"
+ *	amixer set "DVC Out Ramp" on
+ *	aplay xxx.wav &
+ *	amixer set "DVC Out"  80%  // Volume Down
+ *	amixer set "DVC Out" 100%  // Volume Up
  */
 
 /dts-v1/;
-- 
2.1.1

