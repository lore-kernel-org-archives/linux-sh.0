From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Dec 2014 06:47:31 +0000
Subject: Re: [PATCH 0/5] R-Car Gen2 removal and cleanups
Message-Id: <20141204064731.GA25651@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1417538146-23350-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Dec 02, 2014 at 11:44:29PM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> On Tuesday 02 December 2014 22:06:49 Geert Uytterhoeven wrote:
> > On Tue, Dec 2, 2014 at 5:35 PM, Laurent Pinchart wrote:
> > > This patch series remove the Lager legacy and reference board files from
> > > the kernel. It builds upon two patches previously posted by Magnus and
> > > updated to removal left-overs.
> > > 
> > > The rationale for the change, beside keeping the ARM SoC maintainers
> > > happy, is that the Lager board is now correctly supported using DT boot
> > > and generic code only, so there's no reason to keep board files along.
> > 
> > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > 
> > > The second reason to repost the patches is to include a pet peeve of mine
> > > that I've been carrying in my local branches for too long. The last two
> > > patches update the Lager and Koelsch DT files to finally rename the two
> > > serial ports to ttySC0 and ttySC1.
> > 
> > I'm not opposed to this change.

IIRC, this has been a contentious issue in the past.
I will confer with Magnus to make sure we are all happy with this change.

> > > The patches are targeted at v3.20, as they depend on the "ARM: shmobile:
> > > lager: Remove DU platform device" patch scheduled for merge in v3.19-rc1
> > > through the DRM tree.
> > 
> > Given the issues with armadillo-legacy (and perhaps some other -legacy
> > platform(s)?) in -next (https://lkml.org/lkml/2014/12/2/339), we may have to
> > accelerate kicking out -legacy...
> 
> We've known for a long time that -legacy is doomed. Now it's a question of 
> priorities :-)

Zero argument there.
