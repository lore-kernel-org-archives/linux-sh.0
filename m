From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 14 Sep 2015 12:37:39 +0000
Subject: Re: [PATCH 00/14] SCI clocks cleanup
Message-Id: <2491383.5EDJqtVhZg@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Monday 14 September 2015 14:26:45 Geert Uytterhoeven wrote:
> On Mon, Sep 14, 2015 at 2:14 PM, Laurent Pinchart wrote:
> > The SCI driver currently handles two clocks, an interface clock named
> > sci_ick and a functional clock named sci_fck. Studying the datasheets of
> > the SH and ARM SoCs that incorportate (H)SCI(F)([AB]) instances showed
> > (un)surprisingly that the hardware doesn't have a separate controllable
> > interface clock.
> > 
> > All the platforms that declare an interface clock for the SCI set it to
> > the clock used as the SCI functional clock. The two clocks can thus be
> > merged on the driver side, which is what this patch series does. The
> > resulting clock is called "fck", and all SH and ARM users (both DT and
> > non-DT) are fixed to name their SCI clocks appropriately.
> > 
> > Support for the "sci_ick" name is kept in the sh-sci driver to ensure DT
> > backward compatibility, and support for the "peripheral_clk" clock to not
> > break SH platforms that don't declare device-specific SCI clocks. The
> > later can be removed when all SH platforms will declare their SCI clocks
> > properly.
> > 
> > The patches have been developed for an ancien (v3.x for those who were
> > born) kernel and rebased on top of Simon's master branch. I've only
> > compile-tested them after the rebase. Geert, I believe this series is a
> > good preliminary cleanup for the SCI baud rate generator clock support.
> > Could you give it a try as part of your work on that ?
> 
> Thanks a lot!

You're welcome.

> There are a few more to fix up:
>   - The example in new
>     Documentation/devicetree/bindings/clock/renesas,rcar-gen3-cpg-clocks.txt
>   - New arch/arm64/boot/dts/renesas/r8a7795.dtsi

I haven't included these in the patch series as they're not present in Simon's 
devel branch.

>   - The new old kid on the block: arch/h8300/boot/dts

And I have missed that one. If you take the series in your tree for SCI BRG 
clock development, could you add a patch to handle h8300 ?

> I believe we can easily handle those.

-- 
Regards,

Laurent Pinchart

