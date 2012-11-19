From: Simon Horman <horms@verge.net.au>
Date: Mon, 19 Nov 2012 05:13:22 +0000
Subject: [RFC 10/15] ARM: shmobile: Include DTSI of sh73a0 to kzm9g board
Message-Id: <1353302007-31045-11-git-send-email-horms@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1353302007-31045-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1353302007-31045-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>

Cc: Magnus Damm <damm@opensource.se>
Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/boot/dts/sh73a0-kzm9g.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sh73a0-kzm9g.dts b/arch/arm/boot/dts/sh73a0-kzm9g.dts
index bcb9119..7b37901 100644
--- a/arch/arm/boot/dts/sh73a0-kzm9g.dts
+++ b/arch/arm/boot/dts/sh73a0-kzm9g.dts
@@ -9,7 +9,7 @@
  */
 
 /dts-v1/;
-/include/ "skeleton.dtsi"
+/include/ "sh73a0.dtsi"
 
 / {
 	model = "KZM-A9-GT";
-- 
1.7.10.4

