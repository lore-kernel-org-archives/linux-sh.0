From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 May 2014 04:06:12 +0000
Subject: Re: [RFC/PATCH 2/6] serial: sh-sci: Drop the interface clock
Message-Id: <20140513040611.GD29336@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398817906-6023-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398817906-6023-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, May 13, 2014 at 10:06:57AM +0900, Simon Horman wrote:
> On Mon, May 12, 2014 at 10:23:31PM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Wednesday 30 April 2014 15:43:04 Simon Horman wrote:
> > > On Wed, Apr 30, 2014 at 02:31:42AM +0200, Laurent Pinchart wrote:
> > > > As no platform defines an interface clock the SCI driver always fall
> > > > back to a clock named "peripheral_clk". On SH platform that clock is the
> > > > base clock for the SCI functional clock and has the same frequency. On
> > > > ARM platforms that clock doesn't exist, and clk_get() will return the
> > > > default clock for the device. We can thus make the functional clock
> > > > mandatory and drop the interface clock.
> > > > 
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > ---
> > > > 
> > > >  .../bindings/serial/renesas,sci-serial.txt         |  4 +-
> > > >  drivers/tty/serial/sh-sci.c                        | 52 +++++++++--------
> > > >  2 files changed, 31 insertions(+), 25 deletions(-)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > > > b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt index
> > > > 53e6c17..efc9eda 100644
> > > > --- a/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > > > +++ b/Documentation/devicetree/bindings/serial/renesas,sci-serial.txt
> > > > 
> > > > @@ -26,7 +26,7 @@ Required properties:
> > > >    - clocks: Must contain a phandle and clock-specifier pair for each
> > > >      entry in clock-names.
> > > > -  - clock-names: Must contain "sci_ick" for the SCIx UART interface
> > > > clock.
> > > > +  - clock-names: Must contain "fck" for the SCIx UART functional clock.
> > > 
> > > I have tested that this patch works on the Koelsch and Lager boards with the
> > > remainder of the series applied and a fixup for the Lager patch, as noted in
> > > a response to that patch.
> > > 
> > > I have also tested that this patch works on the Marzen board with a modified
> > > version of my series to enable SCI via DT on that board.
> > > 
> > > 
> > > It was my understanding that this patch would not break existing bindings.
> > > However, if my reading and testing of this patch correct this patch modifies
> > > an existing binding, included in v3.14, in an incompatible way. Requiring
> > > all users of "sci_ick" to be updated to "fck".
> > 
> > You're right. Lack of testing mixed with coding during a 12h flight makes it 
> > easy to overlook basic issues :-)
> > 
> > > This includes the DT nodes provided for the r8a7790 and r8a7791 which are
> > > present in v3.15-rc1 and will also be included in v3.15 unless this patch,
> > > its dependencies and the patches in this series that update the dtsi for
> > > those SoCs are submitted as fixes for v3.15. (I am aware the nodes in
> > > question are "disabled" :)
> > > 
> > > I would prefer if this change it was done in a way that maintains
> > > compatibility with the published binding.
> > 
> > I have mixed feelings here. On one hand you're right from a theoretical point 
> > of view. On the other hand, the bindings are so recent, and the DT nodes are 
> > marked as "disabled", so I'm pretty sure nobody uses them. It would be a shame 
> > to have to keep compatibility code around forever in the sh-sci driver, even 
> > if the code itself wouldn't be too complex. How much do you insist on this ? 
> > :-)
> 
> I am prepared to negotiate :)
> 
> As you point out the only users in mainline are marked as disabled.
> And I am not aware of anyone using them in the wild (which is not to
> say that they aren't).
> 
> So I am inclined, as you seem to feel strongly about this, to make an
> exception and allow a non-compatible change.

I have subsequently noticed that DT files for the r8a7791/henninger,
which are already queued up for v3.16, use the existing binding.
So, contrary to what I said immediately above, I really feel that
compatibility has to be maintained.

> > > Apart from addressing my concern above such an approach would also allow
> > > patches that enable SCI via DT (using "sci_ick") to be merged independently
> > > of this driver change. Although I am happy to wait on those if you have a
> > > strong preference for them to use the updated binding.
> > 
> > I don't have a strong preference here, except that I'd like to drop support 
> > for the sci_ick clock name completely, which wouldn't play very well with 
> > adding new users right now :-)
> 
> I am quite happy to delay accepting (new) users of the bindings until this
> is resolved. But I would like to point out that I think that will result in
> one of the two:
> 
> 1. A negotiation with Greg such that I can take the driver change
>    through the shmobile tree, or;
> 2. Some delay in accepting (new) users of the binding as I would need
>    to wait for the binding change to appear in a branch I can use as a base
>    before taking the patches to add new users.
> 
> > > >  Note: Each enabled SCIx UART should have an alias correctly numbered in
> > > >  the "aliases" node.
> > > > 
> > > > @@ -42,5 +42,5 @@ Example:
> > > >  		interrupt-parent = <&gic>;
> > > >  		interrupts = <0 144 IRQ_TYPE_LEVEL_HIGH>;
> > > >  		clocks = <&mstp2_clks R8A7790_CLK_SCIFA0>;
> > > > -		clock-names = "sci_ick";
> > > > +		clock-names = "fck";
> > > >  	};
> > 
> > -- 
> > Regards,
> > 
> > Laurent Pinchart
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
