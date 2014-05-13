From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 May 2014 00:10:24 +0000
Subject: Re: [PATCH] ARM: shmobile: henninger: add QSPI DT support
Message-Id: <20140513001024.GC18157@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201405060245.32952.sergei.shtylyov@cogentembedded.com>
 <536FBEB7.9080605@cogentembedded.com>
 <20140511225354.GC6451@verge.net.au>
 <537151DA.8000101@cogentembedded.com>
In-Reply-To: <537151DA.8000101@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 13, 2014 at 02:57:30AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 05/12/2014 02:53 AM, Simon Horman wrote:
> 
> >>>Define the Henninger board dependent part of the QSPI device node.
> >>>Add device nodes for Spansion S25FL512S SPI flash and MTD partitions on it.
> 
> >>>Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> >>>---
> >>>This patch is against 'renesas-devel-v3.15-rc3-20140502' tag of Simon Horman's
> >>>'renesas.git' repo and SDHI0/2 DT support patch posted last weekend.
> 
> >>>  arch/arm/boot/dts/r8a7791-henninger.dts |   38 ++++++++++++++++++++++++++++++++
> >>>  1 file changed, 38 insertions(+)
> 
> >>>Index: renesas/arch/arm/boot/dts/r8a7791-henninger.dts
> >>>=================================> >>>--- renesas.orig/arch/arm/boot/dts/r8a7791-henninger.dts
> >>>+++ renesas/arch/arm/boot/dts/r8a7791-henninger.dts
> >>[...]
> >>>@@ -158,3 +163,36 @@
> >>>  	cd-gpios = <&gpio6 22 GPIO_ACTIVE_LOW>;
> >>>  	status = "okay";
> >>>  };
> >>>+
> >>>+&qspi {
> >>>+	pinctrl-0 = <&qspi_pins>;
> >>>+	pinctrl-names = "default";
> >>>+
> >>>+	status = "okay";
> >>>+
> >>>+	flash@0 {
> >>>+		#address-cells = <1>;
> >>>+		#size-cells = <1>;
> >>>+		compatible = "spansion,s25fl512s";
> >>>+		reg = <0>;
> >>>+		spi-max-frequency = <30000000>;
> >>>+		spi-tx-bus-width = <4>;
> >>>+		spi-rx-bus-width = <4>;
> >>>+		m25p,fast-read;
> >>>+
> >>>+		partition@0 {
> >>>+			label = "loader_prg";
> >>>+			reg = <0x00000000 0x00040000>;
> >>>+			read-only;
> >>>+		};
> >>>+		partition@40000 {
> >>>+			label = "user_prg";
> >>>+			reg = <0x00040000 0x00400000>;
> >>>+			read-only;
> 
> >>    Oops, there shouldn't be "read-only" here, I forgot to refresh
> >>the patch as I'm now seeing... too bad it's too late to resend now.
> >>:-(
> 
> >Could you send an incremental fix for me to queue up?
> 
>    Oops, I've rechecked and it should indeed be read-only, so the
> patch was correct. Sorry. :-)

Thanks for double checking.
I think we can safely do nothing for now :-)
