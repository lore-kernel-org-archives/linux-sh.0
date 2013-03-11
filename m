From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 11 Mar 2013 20:14:53 +0000
Subject: Re: [PATCH v4 00/29] SH pinctrl and pinmux implementation
Message-Id: <1414889.WPzFUJXkjh@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1362740170-19073-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362740170-19073-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Saturday 09 March 2013 05:28:27 Simon Horman wrote:
> On Fri, Mar 08, 2013 at 04:43:11PM +0100, Laurent Pinchart wrote:
> > On Friday 08 March 2013 16:25:53 Simon Horman wrote:
> > > On Fri, Mar 08, 2013 at 11:55:41AM +0100, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > Here's the fourth version of the SuperH and SH Mobile pin controllers
> > > > (PFC) pinctrl and pinmux support patches. The patches are available
> > > > from my git tree at
> > > > 
> > > >         git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/pinctrl
> > > > 
> > > > The patches are based on top of the following two commits from Linus'
> > > > pinctrl tree:
> > > > 
> > > > 022ab148d28e8 "pinctrl: Declare operation structures as const"
> > > > a72149e82b65b "pinctrl: core: use devres_release() instead of
> > > > devres_destroy()"
> > > 
> > > I assume that I should make a branch based on a branch which includes
> > > those commits.
> > > 
> > > Linus, is there a stable branch that includes those commits at this
> > > time?
> > 
> > 022ab148d28e8 is in Linus' for-next branch, so I think it should be
> > stable.
> > 
> > > > merged into the pinmux/3.9/base branch in my tree, as well as the
> > > > "ARM: shmobile: marzen: Include mmc/host.h" patch hand-picked from the
> > > > mailing list to fix a compilation breakage.
> > > 
> > > Thanks, I'll send that as a fix inclusion in 3.9.
> > 
> > Could you create a branch based on v3.9-rc1 + the mmc fix + anything you
> > deem appropriate and merge 022ab148d28e8 from
> > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
> > into it ? I'll then rebase my patches on top of that (I won't repost them
> > as that shouldn't make any difference in the patches themselves).
> 
> Sure.
> 
> I have made a merge of the fixes branch with Linus's for-next branch
> and pushed the result as a new pinmux-base branch.

Thank you. I've rebased my tree on top of that. You can pull the 
pinmux/3.9/pfc-funcs branch (based on top of pinmux/3.9/pinctrl, so you will 
get this patch set as well as "[PATCH v3 00/64] PFC pinctrl functions for 
sh7372, sh73a0, r8a7740 and r8a7779") directly.

> I am still a little undecided about what to do about handling
> pinmux changes for kzm9g-reference. But I think the best option
> may be to base them on top of pinmux-base.

Or on top of my patches ?

> I agree there is no need to repost your patches at this stage.

-- 
Regards,

Laurent Pinchart

