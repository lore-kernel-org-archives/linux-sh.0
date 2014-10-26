From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Sun, 26 Oct 2014 17:40:09 +0000
Subject: [PATCH v3 2/9] dmaengine: rcar-dmac: Remove duplicate sentence from DT bindings
Message-Id: <1414345216-14486-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

DT bindings are complex enough without expressing the same information
twice in a slightly different way. Remove the duplicate.

Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
index df0f48bcf75a..5fb13ada29a9 100644
--- a/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
+++ b/Documentation/devicetree/bindings/dma/renesas,rcar-dmac.txt
@@ -5,9 +5,6 @@ controller instances named DMAC capable of serving multiple clients. Channels
 can be dedicated to specific clients or shared between a large number of
 clients.
 
-DMA clients are connected to the DMAC ports referenced by an 8-bit identifier
-called MID/RID.
-
 Each DMA client is connected to one dedicated port of the DMAC, identified by
 an 8-bit port number called the MID/RID. A DMA controller can thus serve up to
 256 clients in total. When the number of hardware channels is lower than the
-- 
2.0.4

