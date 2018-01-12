From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 12 Jan 2018 10:35:42 +0000
Subject: Re: [PATCH v4 3/9] v4l: platform: Add Renesas CEU driver
Message-Id: <6661804.aHnDt5XQHf@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1515515131-13760-1-git-send-email-jacopo+renesas@jmondi.org> <4595365.GB5AfDQQ8V@avalon> <CAMuHMdVCa=mXBLjUpqUgg90=Yqj0_r0cmB5UsOYJvdxw3HSsmw@mail.gmail.com>
In-Reply-To: <CAMuHMdVCa=mXBLjUpqUgg90=Yqj0_r0cmB5UsOYJvdxw3HSsmw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Jacopo Mondi <jacopo+renesas-AW8dsiIh9cEdnm+yROfE0A@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sakari Ailus <sakari.ailus-X3B1VOXEql0@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Media Mailing List <linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Geert,

On Friday, 12 January 2018 11:01:18 EET Geert Uytterhoeven wrote:
> On Fri, Jan 12, 2018 at 12:12 AM, Laurent Pinchart wrote:
> > On Tuesday, 9 January 2018 18:25:25 EET Jacopo Mondi wrote:
> >> Add driver for Renesas Capture Engine Unit (CEU).
> >> 
> >> The CEU interface supports capturing 'data' (YUV422) and 'images'
> >> (NV[12|21|16|61]).
> >> 
> >> This driver aims to replace the soc_camera-based sh_mobile_ceu one.
> >> 
> >> Tested with ov7670 camera sensor, providing YUYV_2X8 data on Renesas RZ
> >> platform GR-Peach.
> >> 
> >> Tested with ov7725 camera sensor on SH4 platform Migo-R.
> >> 
> >> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> >> ---
> >> 
> >>  drivers/media/platform/Kconfig       |    9 +
> >>  drivers/media/platform/Makefile      |    1 +
> >>  drivers/media/platform/renesas-ceu.c | 1648 ++++++++++++++++++++++++++++
> >>  3 files changed, 1658 insertions(+)
> >> 
> >>  create mode 100644 drivers/media/platform/renesas-ceu.c
> > 
> > [snip]
> > 
> >> diff --git a/drivers/media/platform/renesas-ceu.c
> >> b/drivers/media/platform/renesas-ceu.c new file mode 100644
> >> index 0000000..d261704
> >> --- /dev/null
> >> +++ b/drivers/media/platform/renesas-ceu.c
> >> @@ -0,0 +1,1648 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> > 
> > It was recently brought to my attention that SPDX headers should use
> > either GPL-2.0-only or GPL-2.0-or-later, no the ambiguous GPL-2.0. Could
> > you please update all patches in this series ?
> 
> IMHO it's a bit premature to do that.
> As long as Documentation/process/license-rules.rst isn't updated, I wouldn't
> follow this change.
> 
> See also https://www.spinics.net/lists/linux-xfs/msg14536.html

Thank you for bringing this to my attention. I agree with you.

-- 
Regards,

Laurent Pinchart

