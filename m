From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Nov 2013 07:37:32 +0000
Subject: Re: [PATCH 1/2 v2] ARM: shmobile: lager: add gpio/fixed regulator for SDHI
Message-Id: <87pppv8qx4.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<7870553.GWO3OgcztQ@avalon>
	<87bo1hdlcs.wl%kuninori.morimoto.gx@renesas.com>
	<9182336.4KdqZZkpGQ@avalon>
In-Reply-To: <9182336.4KdqZZkpGQ@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Laurent

> > > >  #include <linux/platform_data/rcar-du.h>
> > > >  #include <linux/platform_device.h>
> > > >  #include <linux/phy.h>
> > > > 
> > > > +#include <linux/regulator/driver.h>
> > > 
> > > I might be mistaken, but is this header really needed ?
> > 
> > Unfortunately, the compile will error without it.
> > regulator_xxx / REGULATOR_XXX need it
> 
> I believe you should include regulator/machine.h instead of 
> regulator/driver.h.

This is the result.
What is your opinion ?

--- with regulator/machine.h --------
  CC      arch/arm/mach-shmobile/board-lager.o
In file included from /opt/usr/src/WORK/morimoto/gitlinux/linux/arch/arm/mach-shmobile/board-lager.c:36:0:
/opt/usr/src/WORK/morimoto/gitlinux/linux/include/linux/regulator/gpio-regulator.h:83:22: error: field 'type' has incomplete type
/opt/usr/src/WORK/morimoto/gitlinux/linux/arch/arm/mach-shmobile/board-lager.c:208:1: error: 'REGULATOR_VOLTAGE' undeclared here (not in a function)

--- with regulator/driver.h ------
  CC      arch/arm/mach-shmobile/board-lager.o
(no error)
