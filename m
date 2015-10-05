From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Oct 2015 02:29:36 +0000
Subject: Re: [PATCH v4] arm64: renesas: r8a7795: add AUDIO_DMAC support
Message-Id: <20151005022934.GC25427@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <874mikuw3e.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874mikuw3e.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 24, 2015 at 07:19:43AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Hi,

I have taken the liberty of updating this patch with the following
incremental change from Geert. The result can be found in the
topic/r8a7795-sound-v3.update.rebase branch of my renesas tree.

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 16abf8956c68cb00..e70c3cfe0c025a4d 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -455,6 +455,8 @@
 					clock-indices = <
 						R8A7795_CLK_AUDIO_DMAC0 R8A7795_CLK_AUDIO_DMAC1
 					>;
+					clock-output-names +						"audmac0", "audmac1";
 				};
 
 				mstp6_clks: mstp6@e61501c0 {
-- 
1.9.1

