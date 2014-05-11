From: Simon Horman <horms@verge.net.au>
Date: Sun, 11 May 2014 22:53:54 +0000
Subject: Re: [PATCH] ARM: shmobile: henninger: add QSPI DT support
Message-Id: <20140511225354.GC6451@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201405060245.32952.sergei.shtylyov@cogentembedded.com>
 <536FBEB7.9080605@cogentembedded.com>
In-Reply-To: <536FBEB7.9080605@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Sun, May 11, 2014 at 10:17:27PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/06/2014 02:45 AM, Sergei Shtylyov wrote:
> 
> >Define the Henninger board dependent part of the QSPI device node.
> >Add device nodes for Spansion S25FL512S SPI flash and MTD partitions on it.
> 
> >Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >---
> >This patch is against 'renesas-devel-v3.15-rc3-20140502' tag of Simon Horman's
> >'renesas.git' repo and SDHI0/2 DT support patch posted last weekend.
> 
> >  arch/arm/boot/dts/r8a7791-henninger.dts |   38 ++++++++++++++++++++++++++++++++
> >  1 file changed, 38 insertions(+)
> 
> >Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
> >=================================> >--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
> >+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
> [...]
> >@@ -158,3 +163,36 @@
> >  	cd-gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;
> >  	status = "okay";
> >  };
> >+
> >+&qspi {
> >+	pinctrl-0 = <&qspi_pins>;
> >+	pinctrl-names = "default";
> >+
> >+	status = "okay";
> >+
> >+	flash@0 {
> >+		#address-cells = <1>;
> >+		#size-cells = <1>;
> >+		compatible = "spansion,s25fl512s";
> >+		reg = <0>;
> >+		spi-max-frequency = <30000000>;
> >+		spi-tx-bus-width = <4>;
> >+		spi-rx-bus-width = <4>;
> >+		m25p,fast-read;
> >+
> >+		partition@0 {
> >+			label = "loader_prg";
> >+			reg = <0x00000000 0x00040000>;
> >+			read-only;
> >+		};
> >+		partition@40000 {
> >+			label = "user_prg";
> >+			reg = <0x00040000 0x00400000>;
> >+			read-only;
> 
>    Oops, there shouldn't be "read-only" here, I forgot to refresh
> the patch as I'm now seeing... too bad it's too late to resend now.
> :-(

Could you send an incremental fix for me to queue up?
