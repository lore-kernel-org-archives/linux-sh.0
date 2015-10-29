From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 29 Oct 2015 23:27:54 +0000
Subject: [PATCH v5 08/14] arm64: renesas: salvator-x: Sound SSI DMA support
Message-Id: <1446161280-23097-9-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1446161280-23097-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

DMA transfer to/from SSI

     DMA
[MEM] -> [SSI]

     DMA
[MEM] <- [SSI]

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 6a7df7e0ef7a..167c62eb3794 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -145,11 +145,11 @@
 };
 
 &ssi0 {
-	pio-transfer;
+	no-busif;
 };
 
 &ssi1 {
-	pio-transfer;
+	no-busif;
 	shared-pin;
 };
 
-- 
2.1.4

