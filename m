From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 19 Aug 2011 06:24:16 +0000
Subject: Re: LCDC problem after commit 794d78fea51504bad3880d14f354a9847f318f25
Message-Id: <201108190824.16421.laurent.pinchart@ideasonboard.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201108080125.34329.rjw@sisk.pl>
In-Reply-To: <201108080125.34329.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Damian,

On Friday 12 August 2011 11:59:10 Laurent Pinchart wrote:
> On Thursday 11 August 2011 21:37:04 Rafael J. Wysocki wrote:
> > On Thursday, August 11, 2011, Laurent Pinchart wrote:
> > > On Tuesday 09 August 2011 12:48:44 Magnus Damm wrote:
> > > > On Mon, Aug 8, 2011 at 10:46 AM, Magnus Damm wrote:
> > > > > On Mon, Aug 8, 2011 at 8:25 AM, Rafael J. Wysocki wrote:
> > > > >> Unfortunately, after commit
> > > > >> 794d78fea51504bad3880d14f354a9847f318f25 (drivers: sh: late
> > > > >> disabling of clocks V2) the LCDC screen on my Mackerel board goes
> > > > >> off (late) during boot and cannot be turned on by any way AFAICS
> > > > >> (the backlight remains on, though).
> > > > >> 
> > > > >> It looks like the late disabling of clocks interacts badly with
> > > > >> the clock management done by PM domains.
> > > > > 
> > > > > This is most likely showing a so-far-not-handled clock dependency
> > > > > for the LCDC hardware. I'll have a look.
> > > > 
> > > > Further investigation shows that this only triggers when the MERAM is
> > > > enabled in the kernel configuration using
> > > > CONFIG_FB_SH_MOBILE_MERAM=y. So this seems more related to MERAM
> > > > power management than LCDC.
> > > > 
> > > > Digging a bit deeper makes it clear that the sh_mobile_meram.c driver
> > > > in upstream doesn't seem to include any Runtime PM code. I recall
> > > > seeing various versions posted to the mailing list.
> > > > 
> > > > Laurent [CC], can you please provide us with a list of outstanding
> > > > LCDC/MERAM patches to make this work as expected? I realize there are
> > > > quite a few outstanding LCDC patches, but if possible please provide
> > > > a list of the bare minimum to make this work with 3.1-rc.
> > > 
> > > I've pushed my pending patches to
> > > http://git.linuxtv.org/pinchartl/fbdev.git in the pm-domains branch.
> > > The first 19 patches have been picked from mailing lists. Hopefully
> > > they're the latest versions that have been posted. The next 11 patches
> > > shouldn't be required to enable runtime PM with the MERAM, but they
> > > provide code cleanup and bug fixes.
> > > 
> > > Are Rafael' and Damian's patches ready for mainline ? If so, when will
> > > they be pulled ? They're more than one month old, I was expecting them
> > > to hit v3.1- rc1. The backlog is growing, which makes collaboration
> > > more difficult.
> > 
> > Which of my patches are you referring to in particular?
> 
> My bad, your patches are in v3.1-rc1. I had rebased my branch on top of the
> wrong tag. We still need to push Damian's MERAM runtime PM patches, as well
> as mine.

Do you plan to push your MERAM runtime PM patches (available at 
http://git.linuxtv.org/pinchartl/fbdev.git/shortlog/refs/heads/pm-domains 
rebased on top of v3.1-rc2) ?

-- 
Regards,

Laurent Pinchart
