From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 12:18:46 +0000
Subject: Re: [PATCH 0/5] R-Car Gen2 removal and cleanups
Message-Id: <20141204121845.GB21778@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 04, 2014 at 11:12:25AM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 04 December 2014 16:44:39 Simon Horman wrote:
> > On Thu, Dec 04, 2014 at 09:32:49AM +0200, Laurent Pinchart wrote:
> > > On Thursday 04 December 2014 15:47:31 Simon Horman wrote:
> > > > On Tue, Dec 02, 2014 at 11:44:29PM +0200, Laurent Pinchart wrote:
> > > > > On Tuesday 02 December 2014 22:06:49 Geert Uytterhoeven wrote:
> > > > >> On Tue, Dec 2, 2014 at 5:35 PM, Laurent Pinchart wrote:
> > > > >>> This patch series remove the Lager legacy and reference board files
> > > > >>> from the kernel. It builds upon two patches previously posted by
> > > > >>> Magnus and updated to removal left-overs.
> > > > >>> 
> > > > >>> The rationale for the change, beside keeping the ARM SoC maintainers
> > > > >>> happy, is that the Lager board is now correctly supported using DT
> > > > >>> boot and generic code only, so there's no reason to keep board files
> > > > >>> along.
> > > > >> 
> > > > >> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > >> 
> > > > >>> The second reason to repost the patches is to include a pet peeve of
> > > > >>> mine that I've been carrying in my local branches for too long. The
> > > > >>> last two patches update the Lager and Koelsch DT files to finally
> > > > >>> rename the two serial ports to ttySC0 and ttySC1.
> > > > >> 
> > > > >> I'm not opposed to this change.
> > > > 
> > > > IIRC, this has been a contentious issue in the past.
> > > > I will confer with Magnus to make sure we are all happy with this
> > > > change.
> > > 
> > > If I recall correctly the major issue back then was synchronization of
> > > serial port names between legacy and DT boot. Now that Lager and Koelsch
> > > legacy have been removed, there should at least be no synchronization
> > > issue anymore. I'll wait for feedback from Magnus of course.
> > 
> > My recollection is the same as yours :)
> > 
> > BTW, do you want to the lager patch on top of Geert's patch
> > to remove console= from bootargs? If so feel free to repost the series
> > with his patch included.
> 
> I've rebased Geert's patch and applied it to my tree 
> (git://linuxtv.org/pinchartl/fbdev.git arch/next), but I'm also fine if you 
> prefer Geert's patch to go in first.

Thanks, I have picked up the patches from there.
