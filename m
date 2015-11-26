From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 26 Nov 2015 18:59:14 +0000
Subject: Re: renesas-drivers-2015-11-24-v4.4-rc2
Message-Id: <3056560.PFX0WsqxDX@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1448372293-28024-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1448372293-28024-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thursday 26 November 2015 16:08:15 Geert Uytterhoeven wrote:
> On Thu, Nov 26, 2015 at 3:24 PM, Laurent Pinchart wrote:
> > On Wednesday 25 November 2015 10:37:45 Geert Uytterhoeven wrote:
> >> On Wed, Nov 25, 2015 at 2:47 AM, Laurent Pinchart wrote:
> >>> On Tuesday 24 November 2015 14:39:50 Geert Uytterhoeven wrote:
> >>>> On Tue, Nov 24, 2015 at 2:38 PM, Geert Uytterhoeven wrote:
> >>>>> I've pushed renesas-drivers-2015-11-24-v4.4-rc2 to
> >>>>> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.gi
> >>>>> t
> >>>>> This tree is meant to ease development of platform support and
> >>>>> drivers for Renesas ARM ("shmobile") SoCs. It's created by merging
> >>>>> (a) the for- next branches of various subsystem trees and (b)
> >>>>> branches with driver code submitted or planned for submission to
> >>>>> maintainers into the development branch of Simon Horman's renesas.git
> >>>>> tree.
> >>>>> 
> >>>>> Today's version is based on renesas-devel-20151124-v4.4-rc2.
> >>>>> 
> >>>>> Included branches with driver code:
> >>>>>   - sh-pfc-for-v4.5
> >>>>>   - topic/rcar-dmac-residue-v1
> >>>>>   - topic/rcar-dmac-hamza-v3
> >>>>>   - topic/scif-iommu
> >>>>>   - topic/sci-clk-cleanup-v2
> >>>>>   - topic/pfc-scif-clk
> >>>>>   - topic/scif-brg
> >>>>>   - topic/cpg-mssr-v6
> >> >>>   - topic/r8a7795-drivers-sh-v1
> >>>>>   - topic/cs2000-v6
> >>>>>   - git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git#
> >>>>>   topic/r8a7795-sound-v6
> >>>>>   - git://linuxtv.org/pinchartl/media.git#vsp1-kms-20151112~4
> >>>> 
> >>>> When running "modetest -D rcar-du" on koelsch (shmobile_defconfig), it
> >>>> crashes with:
> >>>
> >>> I can't reproduce that. Which version (git commit ID if possible) of
> >>> modetest are you using ?
> >> 
> >> c745e541a9d8dfd3fb5e1ac57297e58d34d9328f
> >> 
> >> I've updated to c05049b4205e446a2e319ab620a5ca949c7a7380, same crash.
> > 
> > And neither crash for me :-/ The kernel commit ID is
> > cf8f2b9871677cd91ac23a8989d61f47bb6f97ce, right ?
> 
> No, you're testing renesas-devel-20151124-v4.4-rc2.
> 
> renesas-drivers-2015-11-24-v4.4-rc2 =
> 1f9e8ee5963d826af20c7bd70bc3fd997e6a4c7f

Of course. I should have read more than the last 10 characters of the tag... 
Sorry about that.

Crash reproduced, problem fixed, patch sent, you've been CC'ed. I've pushed 
the patch to 

	git://linuxtv.org/pinchartl/fbdev.git drm/next/du

Note that this is a v2 of an unmerged patch, not a fix on top of the drivers 
tree.

-- 
Regards,

Laurent Pinchart

