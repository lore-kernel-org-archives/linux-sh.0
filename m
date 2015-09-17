From: Simon Horman <horms@verge.net.au>
Date: Thu, 17 Sep 2015 07:53:06 +0000
Subject: Re: [PATCH 00/14] SCI clocks cleanup
Message-Id: <20150917075305.GC5414@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1442232876-27629-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Sep 17, 2015 at 04:30:06PM +0900, Simon Horman wrote:
> On Mon, Sep 14, 2015 at 03:14:22PM +0300, Laurent Pinchart wrote:
> > Hello,
> > 
> > The SCI driver currently handles two clocks, an interface clock named sci_ick
> > and a functional clock named sci_fck. Studying the datasheets of the SH and
> > ARM SoCs that incorportate (H)SCI(F)([AB]) instances showed (un)surprisingly
> > that the hardware doesn't have a separate controllable interface clock.
> > 
> > All the platforms that declare an interface clock for the SCI set it to the
> > clock used as the SCI functional clock. The two clocks can thus be merged on
> > the driver side, which is what this patch series does. The resulting clock is
> > called "fck", and all SH and ARM users (both DT and non-DT) are fixed to name
> > their SCI clocks appropriately.
> > 
> > Support for the "sci_ick" name is kept in the sh-sci driver to ensure DT
> > backward compatibility, and support for the "peripheral_clk" clock to not
> > break SH platforms that don't declare device-specific SCI clocks. The later
> > can be removed when all SH platforms will declare their SCI clocks properly.
> > 
> > The patches have been developed for an ancien (v3.x for those who were born)
> > kernel and rebased on top of Simon's master branch. I've only compile-tested
> > them after the rebase. Geert, I believe this series is a good preliminary
> > cleanup for the SCI baud rate generator clock support. Could you give it a try
> > as part of your work on that ?
> 
> FWIW, given the explanation above, particularly that regarding backwards
> compatibility for DT, I am comfortable with these changes.

I have now looked over the code and it looks good to me:

Acked-by: Simon Horman <horms+renesas@verge.net.au>

