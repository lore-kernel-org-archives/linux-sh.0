From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 13 May 2014 08:03:34 +0000
Subject: [PATCH 2/2] ARM: shmobile: r8a7791: Correct SYS-DMAC clock defines
Message-Id: <a505daa501dc3f02b08d0b48b049bce719299b74.1399967342.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1399967342.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1399967342.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Car M2 has two MSTP bits for SYS-DMAC, not one.
Also bring the naming in sync with the documentation.

This issue was introduced in v3.14, in commit
4d8864c9e94ec727f1c675b9f6921525c360334b ("ARM: shmobile: r8a7791: Add
clock index macros for DT sources").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r8a7791-clock.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/r8a7791-clock.h b/include/dt-bindings/clock/r8a7791-clock.h
index f069bc6..c3b0130 100644
--- a/include/dt-bindings/clock/r8a7791-clock.h
+++ b/include/dt-bindings/clock/r8a7791-clock.h
@@ -43,7 +43,8 @@
 #define R8A7791_CLK_SCIFB1		7
 #define R8A7791_CLK_MSIOF1		8
 #define R8A7791_CLK_SCIFB2		16
-#define R8A7791_CLK_DMAC		18
+#define R8A7791_CLK_SYS_DMAC1		18
+#define R8A7791_CLK_SYS_DMAC0		19
 
 /* MSTP3 */
 #define R8A7791_CLK_TPU0		4
-- 
1.8.5.2

