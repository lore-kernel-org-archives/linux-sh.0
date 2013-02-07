From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 07 Feb 2013 12:53:13 +0000
Subject: Re: [PATCH 2/3] drm: Renesas R-Car Display Unit DRM driver
Message-Id: <2347648.XJfvtpGXnM@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1359596703-17556-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1359596703-17556-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <20130207021551.GA29824@verge.net.au>
In-Reply-To: <20130207021551.GA29824@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, linux-sh@vger.kernel.org, dri-devel@lists.freedesktop.org, magnus.damm@gmail.com

Hi Simon,

On Thursday 07 February 2013 11:15:52 Simon Horman wrote:
> On Thu, Jan 31, 2013 at 02:45:02AM +0100, Laurent Pinchart wrote:
> > The R-Car Display Unit (DU) DRM driver supports both superposition
> > processors and all eight planes in RGB and YUV formats without alpha
> > blending.
> > 
> > Only VGA and LVDS encoders and connectors are currently supported.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> 
> [snip]
> 
> > diff --git a/drivers/gpu/drm/rcar-du/Kconfig
> > b/drivers/gpu/drm/rcar-du/Kconfig new file mode 100644
> > index 0000000..686486d
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rcar-du/Kconfig
> > @@ -0,0 +1,11 @@
> > +config DRM_RCAR_DU
> > +	tristate "DRM Support for R-Car Display Unit"
> > +	depends on DRM && ARCH_SHMOBILE
> > +	select DRM_KMS_HELPER
> > +	select DRM_KMS_CMA_HELPER
> > +	select DRM_GEM_CMA_HELPER
> > +	select OF
> > +	help
> > +	  Choose this option if you have an R-Car chipset.
> > +	  If M is selected the module will be called rcar-du-drm.
> > +
> 
> Git tells me there is a blank line at EOF here.

And git is right :-) I will fix these blank lines at EOF issues.

> [snip]
> 
> > diff --git a/drivers/gpu/drm/rcar-du/rcar_du_kms.h
> > b/drivers/gpu/drm/rcar-du/rcar_du_kms.h new file mode 100644
> > index 0000000..363ed0b
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rcar-du/rcar_du_kms.h
> > @@ -0,0 +1,34 @@
> > +/*
> > + * rcar_du_kms.h  --  R-Car Display Unit Mode Setting
> > + *
> > + * Copyright (C) 2013 Renesas Corporation
> > + *
> > + * Contact: Laurent Pinchart (laurent.pinchart@ideasonboard.com)
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#ifndef __RCAR_DU_KMS_H__
> > +#define __RCAR_DU_KMS_H__
> > +
> > +#include <linux/types.h>
> > +
> > +struct rcar_du_device;
> > +
> > +struct rcar_du_format_info {
> > +	u32 fourcc;
> > +	unsigned int bpp;
> > +	unsigned int planes;
> > +	unsigned int dddf;
> > +	unsigned int edf;
> > +};
> > +
> > +const struct rcar_du_format_info *rcar_du_format_info(u32 fourcc);
> > +
> > +int rcar_du_modeset_init(struct rcar_du_device *rcdu);
> > +
> > +#endif /* __RCAR_DU_KMS_H__ */
> > +
> 
> And here
> 
> [snip]

-- 
Regards,

Laurent Pinchart

