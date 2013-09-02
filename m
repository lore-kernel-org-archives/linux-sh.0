From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 02 Sep 2013 14:18:41 +0000
Subject: Re: [PATCH 1/4] ARM: shmobile: r8a7778: add Ether DT support
Message-Id: <1738124.5rApJWhXUN@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87ehb8th3c.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Monday 02 September 2013 18:05:10 Sergei Shtylyov wrote:
> On 09/02/2013 05:14 PM, Laurent Pinchart wrote:
> >> Define the generic R8A777x part of the Ether device node.
> >> 
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >> 
> >> ---
> >> 
> >>   arch/arm/boot/dts/r8a7778.dtsi |   11 +++++++++++
> >>   1 file changed, 11 insertions(+)
> >> 
> >> Index: renesas/arch/arm/boot/dts/r8a7778.dtsi
> >> =================================> >> --- renesas.orig/arch/arm/boot/dts/r8a7778.dtsi
> >> +++ renesas/arch/arm/boot/dts/r8a7778.dtsi
> >> @@ -98,4 +98,15 @@
> >> 
> >>   		reg = <0xfffc000 0x118>;
> >>   		#gpio-range-cells = <3>;
> >>   	
> >>   	};
> >> 
> >> +
> >> +	ether: ethernet@fde00000 {
> >> +		device_type = "network";
> > 
> > Documentation/devicetree/bindings/net/sh_eth.txt from "[PATCH 2/2] sh_eth:
> > add device tree support" doesn't document this property, should you
> > update it ?
>     It's a standard property but completely optional for non-OF systems.
> I've not seen anybody document it but I should grep for it...

Documentation/devicetree/booting-without-of.txt mentions it, as well as a 
couple of other DT bindings document, but there's no clear documentation of 
what device_type should be for network device, and whether the property is 
mandatory or optional. Clarifying the documentation would be great.

-- 
Regards,

Laurent Pinchart

