From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Oct 2015 02:29:31 +0000
Subject: Re: [PATCH 10/18 v3] arm64: renesas: salvator-x: Sound SSI PIO support
Message-Id: <20151005022929.GB25427@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 18, 2015 at 02:05:50AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch adds PIO sound support for Salvator-X board.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi,

I have taken the liberty of updating this patch with the following
incremental change from Geert. The result can be found in the
topic/r8a7795-sound-v3.update.rebase branch of my renesas tree.

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index e70c3cfe0c025a4d..c084dd2d7e48b0f5 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -568,6 +568,11 @@
 						R8A7795_CLK_SCU_SRC9 R8A7795_CLK_SCU_SRC8 R8A7795_CLK_SCU_SRC7 R8A7795_CLK_SCU_SRC6 R8A7795_CLK_SCU_SRC5
 						R8A7795_CLK_SCU_SRC4 R8A7795_CLK_SCU_SRC3 R8A7795_CLK_SCU_SRC2 R8A7795_CLK_SCU_SRC1 R8A7795_CLK_SCU_SRC0
 					>;
+					clock-output-names +						"ssi-all",
+						"ssi9", "ssi8", "ssi7", "ssi6",
+						"ssi5", "ssi4", "ssi3", "ssi2",
+						"ssi1", "ssi0";
 				};
 			};
 		};
-- 
1.9.1

