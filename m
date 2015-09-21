From: Simon Horman <horms@verge.net.au>
Date: Mon, 21 Sep 2015 00:30:05 +0000
Subject: Re: [PATCH/RFC v3 3/5] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <20150921003005.GB24857@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1442556314-10512-4-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1442556314-10512-4-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 18, 2015 at 03:58:27PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 9/18/2015 9:05 AM, Simon Horman wrote:
> 
> >From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >
> >Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >[horms: minor updates]
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> [...]
> 
> >diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> >index 5bae2cc0c61e..4fb141230f0c 100644
> >--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> >+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> [...]
> >@@ -56,3 +61,31 @@
> >
> >  	status = "okay";
> >  };
> >+
> >+&avb {
> >+	pinctrl-0 = <&avb_pins>;
> >+	pinctrl-names = "default";
> >+	renesas,no-ether-link;
> >+	phy-reset-gpio = <&gpio2 10 0>;
> 
>    Undocumented prop. You were going to delete it from the binding example.

Thanks and sorry for letting that slip through a second time.
