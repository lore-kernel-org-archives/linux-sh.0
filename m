From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Oct 2015 02:29:47 +0000
Subject: Re: [PATCH 07/18 v3] arm64: renesas: r8a7795: Sound DVC support
Message-Id: <20151005022945.GE25427@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 18, 2015 at 02:04:49AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Hi,

I have taken the liberty of updating this patch with the following
incremental change from Geert. The result can be found in the
topic/r8a7795-sound-v3.update.rebase branch of my renesas tree.

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index 4b096abf9409143a..dc01c62822848475 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -574,6 +574,7 @@
 						"ssi5", "ssi4", "ssi3", "ssi2",
 						"ssi1", "ssi0",
 						"scu-all",
+						"scu-dvc1", "scu-dvc0",
 						"scu-src9", "scu-src8",
 						"scu-src7", "scu-src6",
 						"scu-src5", "scu-src4",
-- 
1.9.1

