From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 13 Nov 2013 15:15:16 +0000
Subject: Re: [PATCH 2/2] ARM: shmobile: r8a7790: Wait for status on all MSTP clocks
Message-Id: <6611276.atjdFHQudq@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1383066834-25956-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383066834-25956-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thursday 31 October 2013 13:35:07 Laurent Pinchart wrote:
> On Thursday 31 October 2013 14:36:06 Simon Horman wrote:
> > On Tue, Oct 29, 2013 at 06:13:54PM +0100, Laurent Pinchart wrote:
> > > From: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > > 
> > > When enabling a module clock by clearing its bit in the MSTP control
> > > register, the CPG requires waiting for the status register to signal
> > > that the clock has started. Failure to do so will result in returning
> > > from the clk_enable() call with the clock potientially still disabled,
> > > leading to various race conditions and difficult to debug errors.
> > > 
> > > Enable status wait for all MSTP clocks on the r8a7790.
> > 
> > Is this patch independent of patch 1 of this series?
> 
> Yes it is. The SH_CLK_MSTP32_STS macro is defined in patch 1/2.

I had obviously read "Is this patch dependent".

I'll submit a v2 with support for the r8a7779.

Have you had a chance to chat with Paul about this ? Patch 1/2 introduces a 
feature that is disabled by default so it should have no influence at all on 
arch/sh.

> > > Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi.px@renesas.com>
> > > Signed-off-by: Laurent Pinchart
> > > <laurent.pinchart+renesas@ideasonboard.com>
> > > ---
> > > 
> > >  arch/arm/mach-shmobile/clock-r8a7790.c | 86 ++++++++++++++-------------
> > >  1 file changed, 47 insertions(+), 39 deletions(-)
-- 
Regards,

Laurent Pinchart

