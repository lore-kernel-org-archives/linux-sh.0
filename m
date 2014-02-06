From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 06 Feb 2014 00:25:01 +0000
Subject: [PATCH] ARM: shmobile: r8a7790: Correct SYS DMAC clock defines
Message-Id: <1391646301-20197-1-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1383714098-28770-1-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1383714098-28770-1-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This brings the implementation into line with the documentation.

This problem was introduced when SYS DMAC clock defines were added by
ac991dce6498b5fc ("ARM: shmobile: r8a7790: Add clock index macros for DT
sources") in v3.13-rc2. I do not believe this results in any problems as
these defines do not appear to be used anywhere yet.

Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 include/dt-bindings/clock/r8a7790-clock.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/dt-bindings/clock/r8a7790-clock.h b/include/dt-bindings/clock/r8a7790-clock.h
index 859e9be..6548a5f 100644
--- a/include/dt-bindings/clock/r8a7790-clock.h
+++ b/include/dt-bindings/clock/r8a7790-clock.h
@@ -46,8 +46,8 @@
 #define R8A7790_CLK_MSIOF1		8
 #define R8A7790_CLK_MSIOF3		15
 #define R8A7790_CLK_SCIFB2		16
-#define R8A7790_CLK_SYS_DMAC0		18
-#define R8A7790_CLK_SYS_DMAC1		19
+#define R8A7790_CLK_SYS_DMAC1		18
+#define R8A7790_CLK_SYS_DMAC0		19
 
 /* MSTP3 */
 #define R8A7790_CLK_TPU0		4
-- 
1.8.5.2

