From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 10 Mar 2015 01:39:01 +0000
Subject: [PATCH 1/6] ARM: shmobile: r8a7790: add reg-names for sound
Message-Id: <87wq2pskbf.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1380652251-8143-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1380652251-8143-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Rensas R-Car sound driver supports reg-names.
Let's use it.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/arm/boot/dts/r8a7790.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
index b320252..2041ec7 100644
--- a/arch/arm/boot/dts/r8a7790.dtsi
+++ b/arch/arm/boot/dts/r8a7790.dtsi
@@ -1461,6 +1461,8 @@
 			<0 0xec5a0000 0 0x100>,  /* ADG */
 			<0 0xec540000 0 0x1000>, /* SSIU */
 			<0 0xec541000 0 0x1280>; /* SSI */
+		reg-names = "scu", "adg", "ssiu", "ssi";
+
 		clocks = <&mstp10_clks R8A7790_CLK_SSI_ALL>,
 			<&mstp10_clks R8A7790_CLK_SSI9>, <&mstp10_clks R8A7790_CLK_SSI8>,
 			<&mstp10_clks R8A7790_CLK_SSI7>, <&mstp10_clks R8A7790_CLK_SSI6>,
-- 
1.9.1

