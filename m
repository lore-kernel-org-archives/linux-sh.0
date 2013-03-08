From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Mar 2013 15:43:11 +0000
Subject: Re: [PATCH v4 00/29] SH pinctrl and pinmux implementation
Message-Id: <2674501.droEzuIy7h@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1362740170-19073-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362740170-19073-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Friday 08 March 2013 16:25:53 Simon Horman wrote:
> On Fri, Mar 08, 2013 at 11:55:41AM +0100, Laurent Pinchart wrote:
> > Hello,
> > 
> > Here's the fourth version of the SuperH and SH Mobile pin controllers
> > (PFC) pinctrl and pinmux support patches. The patches are available from
> > my git tree at
> > 
> >         git://linuxtv.org/pinchartl/fbdev.git pinmux/3.9/pinctrl
> > 
> > The patches are based on top of the following two commits from Linus'
> > pinctrl tree:
> > 
> > 022ab148d28e8 "pinctrl: Declare operation structures as const"
> > a72149e82b65b "pinctrl: core: use devres_release() instead of
> > devres_destroy()"
>
> I assume that I should make a branch based on a branch which includes
> those commits.
>
> Linus, is there a stable branch that includes those commits at this time?

022ab148d28e8 is in Linus' for-next branch, so I think it should be stable.

> > merged into the pinmux/3.9/base branch in my tree, as well as the "ARM:
> > shmobile: marzen: Include mmc/host.h" patch hand-picked from the mailing
> > list to fix a compilation breakage.
> 
> Thanks, I'll send that as a fix inclusion in 3.9.

Could you create a branch based on v3.9-rc1 + the mmc fix + anything you deem 
appropriate and merge 022ab148d28e8 from 
git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git into it 
? I'll then rebase my patches on top of that (I won't repost them as that 
shouldn't make any difference in the patches themselves).

> > As previously, the series start with miscellaneous cleanup and rework
> > patches that slowly get the code in shape. Patches 14/29 and 15/29 then
> > rework the GPIO code to split real GPIOs and function GPIOS in two
> > gpio_chip instances. Patches 16/29 to 22/29 are more miscellaneous
> > cleanups to prepare for patch 23/29 that adds support for sparse GPIO
> > numbering (this was the major issue with v2). Patch 29/29 implements real
> > pinctrl and pinmux support.
> > 
> > This pinctrl and pinmux implementation simply replaces the existing one.
> > This should be safe as I've verified that the pinctrl and pinmux APIs are
> > not used by any SuperH or SH Mobile board code or driver.
> > 
> > I consider this set as ready to be queued for v3.10. As with the previous
> > PFC patch sets there are dependencies between board code changes and
> > sh-pfc changes, so it would be easier to merge everything through the ARM
> > tree.
> > 
> > Please note that patch "ARM: shmobile: sh73a0: Support sparse GPIO
> > numbers"
> > touches both board code and sh-pfc code. This would be hard to avoid.
> > 
> > Changes since v3:
> > 
> > - Drop pinctrl core fields constification patch
> > - Replace pinctrl_add_gpio_range() with gpiochip_add_pin_range()
> > 
> > Changes since v2:
> > 
> > - Rebased on v3.9-rc1
> > - Constify fields in the pinctrl core
> > - Support sparse GPIO numbers
> > - Drop LCD(C) pin groups and functions (moved to another patch set)
> > 
> > Changes since v1:
> > 
> > - Port the bonito board to the pinmux API
> > - Set the pins gpio_chip dev field correctly

-- 
Regards,

Laurent Pinchart

