From: Simon Horman <horms@verge.net.au>
Date: Wed, 02 Sep 2015 02:01:19 +0000
Subject: Re: [PATCH/RFC 07/10] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <20150902020119.GB12080@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 01:40:01PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 8/27/2015 12:24 PM, Simon Horman wrote:
> 
> >From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >
> >Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >[horms: updated filename to salvator-x; updated changelog]
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >---
> >  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 34 ++++++++++++++++++++++
> >  arch/arm64/boot/dts/renesas/r8a7795.dtsi           |  1 +
> >  2 files changed, 35 insertions(+)
> >
> >diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> >index 88cc34819e6a..e8d940cc831a 100644
> >--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> >+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> [...]
> >@@ -103,3 +108,32 @@
> >  &ohci2 {
> >  	status = "okay";
> >  };
> >+
> >+&avb {
> >+	pinctrl-0 = <&avb_pins>;
> >+	pinctrl-names = "default";
> >+	renesas,no-ether-link;
> >+	renesas,phy = <0>;
> 
>    What's that for? :-)

Thanks for spotting that, I'll remove the renesas,phy property
as I can see anything that is using it.

[snip]
