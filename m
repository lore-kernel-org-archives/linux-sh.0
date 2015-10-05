From: Simon Horman <horms@verge.net.au>
Date: Mon, 05 Oct 2015 02:27:21 +0000
Subject: Re: [PATCH 0/3] Basic GPIO support for r8a7795
Message-Id: <20151005022721.GA25427@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1441035401-5843-1-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1441035401-5843-1-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Ulrich,

On Mon, Aug 31, 2015 at 05:36:38PM +0200, Ulrich Hecht wrote:
> Hi!
> 
> This has been broken out of horms's GPIO and EthernetAVB RFC (thanks again)
> and has its minor issues fixed, hopefully.  Specifically, it fixes the GPIO
> 6 and 7 clock references, dumps the MSTP's "clock-output-names" property,
> and omits the extraneous options in defconfig.

I have taken the liberty of:

* rebasing and updating this patch set on top of
  "[PATCH v10 00/07] Renesas R-Car H3 (r8a7795) integration patches V10"
* Updating the patch set to to once again have clock-output-names using the
  following update below provided to me by Geert - hopefully that
  merry-go-round has now paused for v4.4.
* Updating the clock definition order by folding in
  "arm64: dts: r8a7795: add GPIO clocks"

I would greatly appreciate if you and any other interested parties could
review the result which can be found in the topic/r8a7795-gpio-v1.rebase2
branch of the renesas tree.  If you find any problems please repost the
patch set at your earliest convenience.

diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index f1c47ad3ea7fc781..8ce92db14c8bd101 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -530,6 +530,10 @@
 						R8A7795_CLK_I2C2  R8A7795_CLK_I2C1
 						R8A7795_CLK_I2C0
 					>;
+					clock-output-names +						"gpio7", "gpio6", "gpio5",
+						"gpio4", "gpio3", "gpio2",
+						"gpio1", "gpio0";
 				};
 
 				mstp10_clks: mstp10_clks@e6150998 {
-- 
1.9.1

