From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 16 Nov 2015 04:46:45 +0000
Subject: [PATCH 4/4] ARM: Renesas: r8a7791: Enable CLU support in VSPS
Message-Id: <1447649205-1560-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1447649205-1560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1447649205-1560-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-media@vger.kernel.org
Cc: linux-sh@vger.kernel.org

The VSPS includes a CLU module, describe it in DT.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7791.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index 831525dd39a6..fc2a1b10c1af 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -873,6 +873,7 @@
 		clocks = <&mstp1_clks R8A7791_CLK_VSP1_S>;
 		power-domains = <&cpg_clocks>;
 
+		renesas,has-clu;
 		renesas,has-lut;
 		renesas,has-sru;
 		renesas,#rpf = <5>;
-- 
2.4.10

