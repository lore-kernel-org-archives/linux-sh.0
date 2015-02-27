From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 27 Feb 2015 10:43:55 +0000
Subject: Re: [PATCH 00/38] Renesas R-Car DU atomic updates support
Message-Id: <2020647.HvFfSmduLT@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1424901298-6829-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1727387.UhDgAYUN9X@avalon> <CANqRtoRr1WN87BZEO=2LLSpXrVuJHFic3SJ1THy3NWw6C6-1Tg@mail.gmail.com>
In-Reply-To: <CANqRtoRr1WN87BZEO=2LLSpXrVuJHFic3SJ1THy3NWw6C6-1Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>, Dave Airlie <airlied@linux.ie>

Hi Magnus,

(CC'ing Dave)

On Thursday 26 February 2015 16:14:09 Magnus Damm wrote:
> On Thu, Feb 26, 2015 at 1:23 AM, Laurent Pinchart wrote:
> > On Wednesday 25 February 2015 16:43:53 Magnus Damm wrote:
> >> On Wed, Feb 25, 2015 at 1:54 PM, Laurent Pinchart wrote:
> >>> Hello,
> >>> 
> >>> This patch series implements atomic updates support for the rcar-du
> >>> driver.
> >>> 
> >>> The series starts with four core atomic helpers fixes/cleanups (two
> >>> from Daniel that I have included here for completeness). It then
> >>> follows with two fixes for the adv7511 driver and height fixes for the
> >>> rcar-du driver. It finally gets to work by slowly reworking rcar-du
> >>> until atomic updates are fully implemented and the transitional helpers
> >>> gone.
> >>> 
> >>> The patches are based on Dave's 'next' branch and available at
> >>> 
> >>>         git://linuxtv.org/pinchartl/fbdev.git drm/next/atomic
> >>> 
> >>> The last patch contains a hardware plane allocator based solely on
> >>> state objects, which could be useful as a base implementation should
> >>> other drivers experience similar needs.
> >> 
> >> Many thanks for your efforts on this!
> >> 
> >> It looks to me like the adv7511 fixes would be useful as-is
> >> independently of the atomic update changes.
> >> 
> >> [PATCH 05/38] drm: adv7511: Fix DDC error interrupt handling
> >> [PATCH 06/38] drm: adv7511: Fix nested sleep when reading EDID
> >> 
> >> Is it possible to fast track just the fixes somehow? I believe that
> >> several hardware platforms with adv7511 chips would benefit from these
> >> fixes.
> > 
> > Do you mean fast track them to v4.0 or v4.1 ? I certainly want to see them
> > in v4.1 (hopefully with the rest of the series as well) and I can mark
> > them as stable candidates.
> 
> The earlier the better IMO, so v4.0 is of course very nice if possible
> however v4.1 is also just fine.

The above two patches are not regression fixes, so I doubt getting them merged 
in v4.0-rc would be possible. I'll let Dave decide.

-- 
Regards,

Laurent Pinchart

