From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Tue, 02 Dec 2014 16:35:46 +0000
Subject: [PATCH 5/5] ARM: shmobile: koelsch: Rename SCIF[01] serial ports to ttySC[01]
Message-Id: <1417538146-23350-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

There's no reason to name the only two available serial ports on the
board ttySC6 and ttySC7 (apart from confusing userspace, which we should
try to avoid).

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791-koelsch.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 990af167c551..bf58c79a6554 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -48,8 +48,8 @@
 	compatible = "renesas,koelsch", "renesas,r8a7791";
 
 	aliases {
-		serial6 = &scif0;
-		serial7 = &scif1;
+		serial0 = &scif0;
+		serial1 = &scif1;
 	};
 
 	chosen {
-- 
2.0.4

