From: Simon Horman <horms@verge.net.au>
Date: Wed, 02 Sep 2015 02:13:02 +0000
Subject: Re: [PATCH/RFC 04/10] ravb: Add support for r8a7795 SoC
Message-Id: <20150902021300.GC12080@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1440667450-3513-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 28, 2015 at 02:46:30PM +0300, Sergei Shtylyov wrote:
> On 8/28/2015 11:27 AM, Simon Horman wrote:
> 
> >>>>--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> >>>>+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> >>>>@@ -6,8 +6,12 @@ interface contains.
> >>>>  Required properties:
> >>>>  - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
> >>>>               "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
> >>>>+             "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
> >>>>  - reg: offset and length of (1) the register block and (2) the stream buffer.
> >>>>-- interrupts: interrupt specifier for the sole interrupt.
> >>>>+- interrupts: if the device is a part of R8A7790/R8A7794 SoC
> >>>>+              interrupt specifier for the sole interrupt.
> >>>>+              if the device is a part of R8A7795 SoC
> >>>>+              interrupt specifier for the two interrupts.
> >>>
> >>>If there are multiple interrupts, you best make them named interrupts,
> >>>i.e. requiring "interrupt-names", too.
> >>
> >>Thanks, I will look into that.
> >>
> >>>Why are there only 2 interrupts? The datasheet mentions 25, for ch0-ch24.
> >>
> >>Thanks for bringing that up. I think it has also come up elsewhere in this
> >>thread. I'd like to focus on addressing it here rather than spreading the
> >>discussion around any further.
> >>
> >>My understanding is that on the R-Car Gen3 r8a7795 SoC
> >>the EthernetAVB hardware may function in one of two modes.
> >>
> >>1. A mode which is "mostly" compatible with R-Car Gen2
> >>    (e.g. r8a7790, r8a7790).
> >>
> >>    In this mode only ch22 and ch24 are used.
> 
>    But this is *not* really compatible!

Compatible may not have been the wisest choice of wording.
Regardless, the point is that there are two modes. I will describe
them more fully in a separate sub-thread.

> >>    I note that the emac interrupt also appears to be documented for Gen-2.
> 
>    Where? I'm looking at the common h/w manual rev1.02 and only seeing IRQ
> 162 for the normal Ether and IRQ163 for the EtherAVB...
> 
> >>    Its not clear to me at this time why it isn't appropriate to use it
> >>    on those SoCs.
> 
>    I just never saw it in the manual.

Sorry, I was mistaken.
On closer inspection I don't see it either.

> >I have confirmed with that the emac interrupt shouldn't be used
> >on Gen2 SoCs.
> 
>    Hm... It seems to me from re-reading the driver code, that the current
> driver only uses the *E-MAC* interrupts and doesn't use the AVB-DMAC
> interrupts. Maybe I'm over-simplifying though...

I'm not sure that I understand the distinction that you are making there.

> >>2. A mode which is new in Gen 3.
> >>
> >>    In this mode ch0 - ch24 are used.
> >>    I believe that in this mode there are per DMA queue interrupts.
> >
> >With regards to named interrupts, and indeed most of the other feedback I
> >have received for this patch, how about the following?
> >
> >I also confirmed with Mizuguchi-san that it is intentional that the same
> >handler is used for both interrupts.
> 
>    I don't doubt it was intentional, I just very much doubt that it's correct.

As mentioned above, I have will describe more fully the interrupts in
another sub-thread.  I hope that helps clear things up.

My position on using a shared handler is that it is a simple step
to create a correct implementation. I believe it is correct because
the existing handler handles a superset of the interrupts from each of the
two lines hooked up to it will generate.

I believe that it in the longer term it will make for a nicer
implementation to have specific handlers for each interrupt.
But it that it makes sense to handle that as incremental updates
as the driver matures.

> 
> >From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >Subject: [PATCH/RFC v1.1] ravb: Add support for r8a7795 SoC
> >
> >This patch supports the r8a7795 SoC by:
> >- Adding a compat string for the new hardware
> >- Support named-interrupts
> >- Support the E-DMAC interrupt on the new hardware.
> >   Although also present on Gen2 SoCs my understanding is
> >   that it can't be used on those SoCs.
> 
>    No, I don't agree with this description, I don't know where you got this info.

Thanks, I withdraw that description.

> >Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >[horms: updated changelog and cleaned up]
> >Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> >
> >---
> >
> >v0 [Kazuya Mizuguchi]
> >
> >v1 [Simon Horman]
> >* Updated patch subject
> >
> >v1.1 [Simon Horman]
> >* As suggested by Sergei Shtylyov
> >   - Updated changelog
> >   - Corrected capitalisation in documentation
> >   - Removed pdev variable from ravb_open()
> >   - Corrected indentation
> >   - Leave initialisation and freeing of existing interrupt in common code
> >* As suggested by Geert Uytterhoeven and Sergei Shtylyov
> >   - support named interrupts
> >
> >TODO:
> >* Consider propagating error for both new and existing call to
> >   platform_get_irq().
> >---
> >  .../devicetree/bindings/net/renesas,ravb.txt       | 12 ++++++-
> >  drivers/net/ethernet/renesas/ravb.h                |  1 +
> >  drivers/net/ethernet/renesas/ravb_main.c           | 38 +++++++++++++++++++---
> >  3 files changed, 46 insertions(+), 5 deletions(-)
> >
> >diff --git a/Documentation/devicetree/bindings/net/renesas,ravb.txt b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> >index 1fd8831437bf..e2b2a551813a 100644
> >--- a/Documentation/devicetree/bindings/net/renesas,ravb.txt
> >+++ b/Documentation/devicetree/bindings/net/renesas,ravb.txt
> >@@ -6,8 +6,12 @@ interface contains.
> >  Required properties:
> >  - compatible: "renesas,etheravb-r8a7790" if the device is a part of R8A7790 SoC.
> >  	      "renesas,etheravb-r8a7794" if the device is a part of R8A7794 SoC.
> >+	      "renesas,etheravb-r8a7795" if the device is a part of R8A7795 SoC.
> >  - reg: offset and length of (1) the register block and (2) the stream buffer.
> >-- interrupts: interrupt specifier for the sole interrupt.
> >+- interrupts: interrupt specifiers.
> >+	      One data and one emac interrupt for the R8A7795 SoC;
> 
>    No, the "data" doesn't seem a correct name...

I will respond more fully  with regards to the bindings in another
sub-thread.

> >+	      these interrupts must be named.
> >+              One named or unnamed data interrupt otherwise.
> >  - phy-mode: see ethernet.txt file in the same directory.
> >  - phy-handle: see ethernet.txt file in the same directory.
> >  - #address-cells: number of address cells for the MDIO bus, must be equal to 1.
> [...]
> >diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
> >index a157aaaaff6a..1832737063f3 100644
> >--- a/drivers/net/ethernet/renesas/ravb.h
> >+++ b/drivers/net/ethernet/renesas/ravb.h
> >@@ -809,6 +809,7 @@ struct ravb_private {
> >
> >  	unsigned no_avb_link:1;
> >  	unsigned avb_link_active_low:1;
> >+	int emac_irq;
> 
>    Please place this somewhere before the bit fields.

Will do.

> [...]
> >diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> >index 026d98435d87..0276707089a5 100644
> >--- a/drivers/net/ethernet/renesas/ravb_main.c
> >+++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
> >@@ -1197,6 +1198,16 @@ static int ravb_open(struct net_device *ndev)
> >  		goto out_napi_off;
> >  	}
> >
> >+	if (of_device_is_compatible(dev->of_node, "renesas,etheravb-r8a7795")) {
> >+		error = request_irq(priv->emac_irq, ravb_interrupt,
> 
>    No, I can't agree to that. You need to clearly separate the interrupt
> handlers.
> 
> >+				    IRQF_SHARED, ndev->name, ndev);
> >+		if (error) {
> >+			netdev_err(ndev, "cannot request IRQ\n");
> >+			free_irq(ndev->irq, ndev);
> 
>    No, please just add a new label below instead, we already have free_irq()
> call there.

Sure, will do.

> [...]
> >@@ -1220,6 +1231,8 @@ out_ptp_stop:
> >  	ravb_ptp_stop(ndev);
> >  out_free_irq:
> >  	free_irq(ndev->irq, ndev);
> >+	if (of_device_is_compatible(dev->of_node, "renesas,etheravb-r8a7795"))
> 
>    Repeating this check all over again doesn't look good to me... can you
> see about adding some data to the 'struct of_device_id' initalizers?

Good idea, I'll look into it.
