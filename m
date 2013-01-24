From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 24 Jan 2013 11:28:19 +0000
Subject: Re: [PATCH v2 1/8] sh-pfc: Add OF support
Message-Id: <13196828.FzACPZxly1@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1357693395-1653-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <1357693395-1653-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com> <Pine.LNX.4.64.1301121745320.14443@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1301121745320.14443@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org
Cc: Paul Mundt <lethal@linux-sh.org>, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>, Linus Walleij <linus.walleij@linaro.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Phil Edworthy <phil.edworthy@renesas.com>, Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, devicetree-discuss@lists.ozlabs.org

Hi Guennadi,

On Saturday 12 January 2013 18:18:54 Guennadi Liakhovetski wrote:
> On Wed, 9 Jan 2013, Laurent Pinchart wrote:
> > Support device instantiation through the device tree. The compatible
> > property is used to select the SoC pinmux information.
> > 
> > Set the gpio_chip device field to the PFC device to enable automatic
> > GPIO OF support.
> > 
> > Signed-off-by: Laurent Pinchart
> > <laurent.pinchart+renesas@ideasonboard.com>
> > Cc: devicetree-discuss@lists.ozlabs.org
> 
> This whole pinctrl mega-series is a very welcome improvement to the
> sh-/r-mobile GPIO framework, and is very well done IMHO! But,
> unfortunately, as discussed with you privately yesterday, there is still a
> problem with pinctrl DT support on sh73a0, which will, probably, enforce
> an update to one or several of patches from this lot. To explain to other
> readers, on sh73a0 pin numbers are not contiguous, they are sparse.
> When pins are referred to from C code, macro names are used, which are
> then correctly decoded to respective positions in pin descriptor tables.
> Whereas with DT, pins are referred to from .dts files using their physical
> numbers, which then refer to either wrong or missing entries in those
> tables.
> 
> I do not know where this problem should be solved best - either in
> descriptor tables, or in DT handling code, so, I don't know which patches
> would be affected. Don't think you'll want to keep the one-to-one
> index-to-pin mapping by also making pin-descriptor arrays sparse, so, so
> far I only see one possibility to fix this - by using the .enum_id field
> from struct sh_pfc_pin instead of just the index - both in  C and in DT
> case, and those .enum_id values will have to provide physical pin numbers
> instead of plane indices.

I was thinking about something similar as well. I will use physical pin 
numbers, but I then need to find a way to number the pins, as they're not 
numbered in the documentation. Opinions on possible numbering schemes from 
anyone familiar with several SoCs both in SH Mobile and SuperH will be 
appreciated.

> That way you'd have to update at least drivers/pinctrl/sh-pfc/pfc-sh73a0.c
> and the sh_pfc_map_gpios() function in drivers/pinctrl/sh-pfc/pinctrl.c.
> 
> Anyway, I'm sure you'll find a suitable solution of this problem and for
> now I'll let Simon decide which patches he wants to apply and which ones
> he'd prefer to hold back;-)

-- 
Regards,

Laurent Pinchart

