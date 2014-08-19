From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 19 Aug 2014 21:27:06 +0000
Subject: Re: [PATCH] MAINTAINERS: Add entry for Renesas DRM drivers
Message-Id: <2611827.LKZPApRdAB@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1408482271-7310-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <53F3BF23.2090202@cogentembedded.com>
In-Reply-To: <53F3BF23.2090202@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, dri-devel@lists.freedesktop.org, linux-sh@vger.kernel.org

Hi Sergei,

On Wednesday 20 August 2014 01:18:27 Sergei Shtylyov wrote:
> On 08/20/2014 01:04 AM, Laurent Pinchart wrote:
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > 
> >   MAINTAINERS | 11 +++++++++++
> >   1 file changed, 11 insertions(+)
> > 
> > Hi Dave,
> > 
> > Could you please pick this patch up, or let me know if you would like it
> > to go through a different tree ?
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 6813d0a..375c019 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -3046,6 +3046,17 @@ F:	include/linux/host1x.h
> > 
> >   F:	include/uapi/drm/tegra_drm.h
> >   F:	Documentation/devicetree/bindings/gpu/nvidia,tegra20-host1x.txt
> > 
> > +DRM DRIVERS FOR RENESAS
> > +M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > +L:	dri-devel@lists.freedesktop.org
> > +L:	linux-sh@vger.kernel.org
> > +T:	git git://people.freedesktop.org/~airlied/linux
> > +S:	Supported
> > +F:	drivers/gpu/drm/rcar-du/
> > +F:	drivers/gpu/drm/shmobile/
> > +F:	include/linux/platforma_data/rcar-du.h
> > +F:	include/linux/platforma_data/shmob_drm.h
> 
>     s/platforma/platform/

I'll pretend my brain was in Latin mode (and that platforma is a valid Latin 
word...). Dave, would you like a v2, or can you fix that when applying the 
patch ?

-- 
Regards,

Laurent Pinchart

