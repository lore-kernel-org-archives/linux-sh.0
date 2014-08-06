From: Simon Horman <horms+renesas@verge.net.au>
Date: Wed, 06 Aug 2014 01:37:59 +0000
Subject: [PATCH] dt/bindings: rcar-audmapp: tidyup dmas explanation
Message-Id: <84fd82a23742e2d716a1ccb7ad9ef21165dc30bc.1407288912.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87y4v3of3z.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87y4v3of3z.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current dmas explanation of SRC/DRS is confusable.
This patch clarifies it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 Documentation/devicetree/bindings/dma/rcar-audmapp.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/rcar-audmapp.txt b/Documentation/devicetree/bindings/dma/rcar-audmapp.txt
index 9f1d750..61bca50 100644
--- a/Documentation/devicetree/bindings/dma/rcar-audmapp.txt
+++ b/Documentation/devicetree/bindings/dma/rcar-audmapp.txt
@@ -16,9 +16,9 @@ Example:
 * DMA client
 
 Required properties:
-- dmas:		a list of <[DMA multiplexer phandle] [SRS/DRS value]> pairs,
-		where SRS/DRS values are fixed handles, specified in the SoC
-		manual as the value that would be written into the PDMACHCR.
+- dmas:		a list of <[DMA multiplexer phandle] [SRS << 8 | DRS]> pairs.
+		where SRS/DRS are specified in the SoC manual.
+		It will be written into PDMACHCR as high 16-bit parts.
 - dma-names:	a list of DMA channel names, one per "dmas" entry
 
 Example:
-- 
2.0.1

