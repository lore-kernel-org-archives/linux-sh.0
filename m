From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 24 Feb 2015 15:23:29 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a73a4: Remove legacy code
Message-Id: <1712555.MOqtjS5RND@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418771008-5676-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Tuesday 24 February 2015 08:44:18 Simon Horman wrote:
> On Thu, Feb 19, 2015 at 01:08:15PM -0500, Simon Horman wrote:
> > On Thu, Feb 19, 2015 at 01:02:09PM -0500, Simon Horman wrote:
> > > On Thu, Feb 19, 2015 at 06:48:03PM +0100, Geert Uytterhoeven wrote:
> > > > From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > > > 
> > > > All r8a73a4 boards are now used with multiplatform kernels only. We
> > > > can remove all the unused r8a73a4 legacy device and clock registration
> > > > code.
> > > > 
> > > > Signed-off-by: Laurent Pinchart
> > > > <laurent.pinchart+renesas@ideasonboard.com>
> > > > Acked-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
> > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > ---
> > > > Forgot to include this in the ape6evm multiplatform series.
> > > 
> > > I think that I would rather hold off on this until ape6evm is
> > > working in renesas-devel.
> > > 
> > > In particular I am referring to the mmc problem which you indicate
> > > has been fixed in next but not in mainline. It is the latter that
> > > renesas-devel is based on.
> > 
> > It seems that v3.20-rc1 should have the required mmc changes.  Assuming
> > the above statement is correct could you repost this patch once rc1 has
> > been released?
> > 
> > As usual I plan to rebase the branches in renesas-devel on -rc1 once it
> > has been released. And to push the result into next. Due to travel and
> > other commitments this may not happen until a few days after -rc1 is
> > released.
> 
> The mmc problems seem to be resolved in v4.0-rc1 and I have queued
> this patch up as part of rebasing renesas-devel/next on top of that rc
> release.

I can't find the patch in your next or devel branches. Am I looking at the 
wrong tree ?

-- 
Regards,

Laurent Pinchart

