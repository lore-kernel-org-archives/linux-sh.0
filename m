From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Tue, 05 Aug 2014 02:16:35 +0000
Subject: [PATCH] dt/bindings: rcar-audmapp: tidyup dmas explanation
Message-Id: <87y4v3of3z.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1405401560.git.horms+renesas@verge.net.au>
	<caf18c27ddb2fb8ae2a7591b908e7efb7484e459.1405401560.git.horms+renesas@verge.net.au>
	<CAMuHMdUY5rHrvwDp6RpHoY3vmGc9Khi-jkkiTytby6CxZgmauA@mail.gmail.com>
	<87silcwpv9.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87silcwpv9.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms+renesas@verge.net.au>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: devicetree@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Vinod Koul <vinod.koul@intel.com>, dmaengine@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Magnus Damm <magnus.damm@gmail.com>

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Current dmas explanation of SRC/DRS is confusable.
This patch clarifies it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 .../devicetree/bindings/dma/rcar-audmapp.txt       |    6 +++---
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
1.7.9.5

