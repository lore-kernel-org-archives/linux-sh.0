From: Simon Horman <horms+renesas@verge.net.au>
Date: Fri, 11 Sep 2015 02:03:15 +0000
Subject: [PATCH/RFC v2 4/5] arm64: dts: r8a7795: enable nfs root on Salvator-X board
Message-Id: <1441936996-18437-5-git-send-email-horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

As has been the practice for boards for 32bit ARM Renesas SoCs

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

--

v2
* No change
---
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 4fb141230f0c..35980456c21a 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -21,7 +21,7 @@
 	};
 
 	chosen {
-		bootargs = "ignore_loglevel";
+		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
 		stdout-path = &scif2;
 	};
 
-- 
2.1.4

