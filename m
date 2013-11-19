From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 19 Nov 2013 12:45:26 +0000
Subject: Re: [PATCH 1/2 v2] ARM: shmobile: lager: add gpio/fixed regulator for SDHI
Message-Id: <9182336.4KdqZZkpGQ@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com> <7870553.GWO3OgcztQ@avalon> <87bo1hdlcs.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87bo1hdlcs.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org

Hi Morimoto-san,

On Monday 18 November 2013 21:14:15 Kuninori Morimoto wrote:
> Hi Laurent
> 
> > >  #include <linux/platform_data/rcar-du.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/phy.h>
> > > 
> > > +#include <linux/regulator/driver.h>
> > 
> > I might be mistaken, but is this header really needed ?
> 
> Unfortunately, the compile will error without it.
> regulator_xxx / REGULATOR_XXX need it

I believe you should include regulator/machine.h instead of 
regulator/driver.h.

> > > +static struct fixed_voltage_config vcc_sdhi##idx##_info = {		\
> > 
> > You can make this structure const.
> 
> (snip)
> 
> > > +static struct gpio_regulator_config vccq_sdhi##idx##_info = {		\
> > 
> > You can make this structure const.
> 
> I see.
> Thank you

-- 
Regards,

Laurent Pinchart

