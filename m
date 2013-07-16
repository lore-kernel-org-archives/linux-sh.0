From: Simon Horman <horms@verge.net.au>
Date: Tue, 16 Jul 2013 05:08:19 +0000
Subject: Re: [PATCH v2 0/7] Backlight drivers for SH and ARM SH-Mobile boards
Message-Id: <20130716050818.GB8431@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1372965210-10024-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1372965210-10024-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 10, 2013 at 09:21:39PM +0900, Simon Horman wrote:
> On Wed, Jul 10, 2013 at 11:17:20AM +0200, Laurent Pinchart wrote:
> > Hi Simon,
> > 
> > On Wednesday 10 July 2013 10:22:34 Simon Horman wrote:
> > > On Wed, Jul 10, 2013 at 10:07:45AM +0900, Jingoo Han wrote:
> > > > On Friday, July 05, 2013 4:13 AM, Laurent Pinchart wrote:
> > > > > Hello,
> > > > > 
> > > > > Here are three backlight drivers used by SH and ARM SH-Mobile boards.
> > > > > 
> > > > > The first driver supports simple GPIO-controlled backlights that are
> > > > > turned on or off by a single GPIO (either active high or active low).
> > > > > 
> > > > > The second driver supports the Sanyo LV5207LP LED driver
> > > > > (http://www.onsemi.com/pub_link/Collateral/ENA0943-D.PDF) and exposes
> > > > > the main LED only as a backlight device, as that's all the board I need
> > > > > to driver for uses.
> > > > > 
> > > > > The third driver supports the ROHM Semiconductor BD6107 LED driver (no
> > > > > datasheet publicly available I'm afraid). Similarly to the LV5207LP
> > > > > driver, it exposes the main LED only as a backlight device.
> > > > > 
> > > > > The last four patches port the ARM SH-Mobile Mackerel and AG5EVM and the
> > > > > SH Ecovec24 and KFR2R09 boards to use the new backlight drivers. The
> > > > > code has been compile tested on all four platforms and runtime tested on
> > > > > Mackerel only as I don't have access to the other boards.
> > > > > 
> > > > > As the board code patches depend on the backlight drivers, the drivers
> > > > > should get merged first. Richard, Jingoo, would you like to take them
> > > > > through your tree, or would it be easier to merge them with the ARM and
> > > > > SH patches ?
> > > >
> > > > Hi Laurent,
> > > > 
> > > > Currently, I cannot use my git tree for backlight subsystem.
> > > > Also, your patches cannot affect other backlight drivers.
> > > > 
> > > > I think that these 7 patches would go through SH tree with my Acked-by.
> > > > I will review your patches.
> > > 
> > > That is fine by me.
> > > 
> > > Laurent, can you please let me know what base - e.g. v3.11-rc1 -
> > > is required for the non-shmobile patches?
> > 
> > The patch series is based on v3.10.
> 
> Thanks. I will queue it up once I rebase the other branches
> on top of v3.11-rc1. I expect that to occur next week.

I have now rebased.  Accordingly, this series is now queued up for v3.12 in
the pinmux branch. That branch is based directly on  v3.11-rc1. This
is available in renesas-devel-20130716.
