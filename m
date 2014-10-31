From: Simon Horman <horms@verge.net.au>
Date: Fri, 31 Oct 2014 08:18:07 +0000
Subject: Re: [PATCH v3 0/9] Renesas R-Car DU HDMI support
Message-Id: <20141031081803.GA23848@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1414337068-28664-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <11054192.lJRMYJX3F4@avalon>
 <CAGv-rZm=0rvvnO1cgBp0ZNdu0PvA-nwh6Nk05LSyTE=0vg0ipA@mail.gmail.com>
 <2727864.n2TjKgUQyN@avalon>
In-Reply-To: <2727864.n2TjKgUQyN@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, dri-devel@lists.freedesktop.org, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Dave Airlie <airlied@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-sh@vger.kernel.org

On Thu, Oct 30, 2014 at 01:40:34PM +0200, Laurent Pinchart wrote:
> Hi Simon,
> 
> On Thursday 30 October 2014 20:29:22 Simon Horman wrote:
> > 2014/10/30 20:05 "Laurent Pinchart" <laurent.pinchart@ideasonboard.com>:
> > > On Tuesday 28 October 2014 15:30:05 Dave Airlie wrote:
> > >>> The last patch instantiates the HDMI encoder in the Koelsch board DT
> > >>> file and connects it to the DU output.
> > >>> 
> > >>> The patch series depends on Koelsch DU DT enablement (scheduled for
> > >>> merge in v3.19-rc1). Dave, I'd like to get this merged in v3.19-rc1, how
> > >>> would you like to proceed ? Could it go through Simon's Renesas tree ?
> > >>> There's a small risk of conflict in drivers/gpu/drm/drm_edid.c,
> > >>> include/drm/drm_edid.h, drivers/gpu/drm/i2c/Kconfig and
> > >>> drivers/gpu/drm/i2c/Makefile. Simon, could you alternatively provide a
> > >>> stable branch with the required dependencies ?
> > >> 
> > >> I'd probably like to take the drm patches into drm-next first, then
> > >> maybe get a stable branch from Simon I could use to base the rest on.
> > > 
> > > Simon, I believe that would be the dt-du-for-v3.19 branch of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git
> > > 
> > > Is it correct ?
> > 
> > Sorry I shuffled things around a bit and what you need should now be in the
> > dt-for-v3.19 branch. I hope what is there now is stable. But I'd appreciate
> > it if you could wait a few more days.
> 
> Sure, no problem. Could you please let me know when I can use it ?

Of course, will do.
