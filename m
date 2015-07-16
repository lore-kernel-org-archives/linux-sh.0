From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 16 Jul 2015 09:45:37 +0000
Subject: Re: [PATCH] drm: rcar-du: Add dependency to OF
Message-Id: <2342447.RbfaOUNm08@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1437036247-30168-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <CAMuHMdUTTkSqSZx1Gmvp7hznyecy7SV625b2by=VR-KUipUA7w@mail.gmail.com>
In-Reply-To: <CAMuHMdUTTkSqSZx1Gmvp7hznyecy7SV625b2by=VR-KUipUA7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, DRI Development <dri-devel@lists.freedesktop.org>, Linux-sh list <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>

Hi Geert,

On Thursday 16 July 2015 11:08:58 Geert Uytterhoeven wrote:
> On Thu, Jul 16, 2015 at 10:44 AM, Laurent Pinchart wrote:
> > The driver requires OF support, add a dependency in Kconfig and remove
> > the platform_device_id table that isn't used anymore.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> Once Simon has queued up the removal of board-marzen.c:
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thank you.

Note that support for platform data in the rcar-du driver has been dropped in 
v3.19, so I don't think we need to wait until Simon queues up the removal of 
board-marzen.c.

-- 
Regards,

Laurent Pinchart

