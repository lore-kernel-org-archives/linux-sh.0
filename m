From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 01 Feb 2016 22:52:05 +0000
Subject: Re: [PATCH v2 0/3] drm: adv7511: edid read fixes
Message-Id: <1527016.aZOMcpLiHL@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1452290210-20629-1-git-send-email-wsa@the-dreams.de>
 <20160201133119.GB10607@tetsubishi>
In-Reply-To: <20160201133119.GB10607@tetsubishi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-sh@vger.kernel.org, Daniel Vetter <daniel.vetter@ffwll.ch>, Magnus Damm <magnus.damm@gmail.com>, dri-devel@lists.freedesktop.org, Hans Verkuil <hans.verkuil@cisco.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>

Hi Wolfram,

On Monday 01 February 2016 14:31:20 Wolfram Sang wrote:
> On Fri, Jan 08, 2016 at 10:56:47PM +0100, Wolfram Sang wrote:
> > So, here is my V2 of this series. Changes:
> > 
> > * Added tags. Thanks to Laurent and Lars-Peter for review and to Archit
> > for
> > 
> >   testing. Much appreciated!
> > 
> > * rephrased the comment and commit message in patch 1 to be hopefully less
> > 
> >   confusing :)
> > 
> > No code changes!
> > 
> > Thanks,
> > 
> >    Wolfram
> > 
> > Wolfram Sang (3):
> >   drm: adv7511: really enable interrupts for EDID detection
> >   drm: adv7511: mark ADV7511_REG_EDID_READ_CTRL volatile
> >   drm: adv7511: it's HPD, not HDP
> >  
> >  drivers/gpu/drm/i2c/adv7511.c | 48 ++++++++++++++++++++++----------------
> >  drivers/gpu/drm/i2c/adv7511.h | 12 +++++------
> >  2 files changed, 35 insertions(+), 25 deletions(-)
> 
> Adding Hans to CC of the proper mail, not patch 1. Sorry for the noise!

My bad, I got the drivers mistaken when we talked about it, I thought you 
meant the V4L2 driver, not the DRM driver. This series should be merged by 
Dave Airlie. The easiest is to send him a pull request.

-- 
Regards,

Laurent Pinchart

