From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 27 Nov 2015 01:55:34 +0000
Subject: [PATCH 17/18] arm64: renesas: salvator-x: Sound SRC support
Message-Id: <f7df91f5f2f987f2639d292dc3f9101ad7318cf7.1448587800.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1448587800.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1448587800.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index e49e5dc6dafc..47bf252774d7 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -136,8 +136,8 @@
 
 	rcar_sound,dai {
 		dai0 {
-			playback = <&ssi0>;
-			capture  = <&ssi1>;
+			playback = <&ssi0 &src0>;
+			capture  = <&ssi1 &src1>;
 		};
 	};
 };
-- 
2.1.4

