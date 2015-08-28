From: Simon Horman <horms@verge.net.au>
Date: Fri, 28 Aug 2015 05:30:33 +0000
Subject: Re: [PATCH/RFC 07/10] arm64: dts: r8a7795: enable EthernetAVB on Salvator-X
Message-Id: <20150828053032.GE6298@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-8-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 27, 2015 at 03:16:43PM +0300, Sergei Shtylyov wrote:
> On 8/27/2015 2:14 PM, Geert Uytterhoeven wrote:
> 
> >>>+       phy0: ethernet-phy@0 {
> >>>+               rxc-skew-ps = <900>;
> >>>+               rxdv-skew-ps = <0>;
> >>>+               rxd0-skew-ps = <0>;
> >>>+               rxd1-skew-ps = <0>;
> >>>+               rxd2-skew-ps = <0>;
> >>>+               rxd3-skew-ps = <0>;
> >>>+               txc-skew-ps = <900>;
> >>>+               txen-skew-ps = <0>;
> >>>+               txd0-skew-ps = <0>;
> >>>+               txd1-skew-ps = <0>;
> >>>+               txd2-skew-ps = <0>;
> >>>+               txd3-skew-ps = <0>;
> >>
> >>
> >>    Hm, and the PHY driver can parse all this?
> 
> >Please see drivers/net/phy/micrel.c:ksz9021_config_init().
> 
>    OK, but don't we need to specify some kind of "compatible" prop?

Not according to my reading of
Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
