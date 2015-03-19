From: Simon Horman <horms+renesas@verge.net.au>
Date: Thu, 19 Mar 2015 02:15:20 +0000
Subject: [PATCH 2/6] ARM: shmobile: r8a7791: add reg-names for sound
Message-Id: <d88a6a2a2184b0f58c42dfda77fdda87ab28b6aa.1426731062.git.horms+renesas@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <cover.1426731062.git.horms+renesas@verge.net.au>
In-Reply-To: <cover.1426731062.git.horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Rensas R-Car sound driver supports reg-names.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7791.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
index e899f79..8631e02 100644
--- a/arch/arm/boot/dts/r8a7791.dtsi
+++ b/arch/arm/boot/dts/r8a7791.dtsi
@@ -1504,6 +1504,8 @@
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
 			<0 0xec541000 0 0x1280>; /* SSI */
+		reg-names = "scu", "adg", "ssiu", "ssi";
+
 		clocks = <&mstp10_clks R8A7791_CLK_SSI_ALL>,
 			<&mstp10_clks R8A7791_CLK_SSI9>, <&mstp10_clks R8A7791_CLK_SSI8>,
 			<&mstp10_clks R8A7791_CLK_SSI7>, <&mstp10_clks R8A7791_CLK_SSI6>,
-- 
2.1.4

