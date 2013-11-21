From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 21 Nov 2013 01:53:10 +0000
Subject: Re: [PATCH 1/2 v2] ARM: shmobile: lager: add gpio/fixed regulator for SDHI
Message-Id: <87wqk2y0zh.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87li0rz3to.wl%kuninori.morimoto.gx@renesas.com>
	<9182336.4KdqZZkpGQ@avalon>
	<87pppv8qx4.wl%kuninori.morimoto.gx@renesas.com>
	<1745725.K7bPWgBA4v@avalon>
In-Reply-To: <1745725.K7bPWgBA4v@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Simon <horms@verge.net.au>, Chris Ball <cjb@laptop.org>, Magnus <magnus.damm@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, linux-mmc@vger.kernel.org


Hi Laurent

> > --- with regulator/machine.h --------
> >   CC      arch/arm/mach-shmobile/board-lager.o
> > In file included from
> > /opt/usr/src/WORK/morimoto/gitlinux/linux/arch/arm/mach-shmobile/board-lage
> > r.c:36:0:
> > /opt/usr/src/WORK/morimoto/gitlinux/linux/include/linux/regulator/gpio-regu
> > lator.h:83:22: error: field 'type' has incomplete type
> > /opt/usr/src/WORK/morimoto/gitlinux/linux/arch/arm/mach-shmobile/board-lage
> > r.c:208:1: error: 'REGULATOR_VOLTAGE' undeclared here (not in a function)
> > 
> > --- with regulator/driver.h ------
> >   CC      arch/arm/mach-shmobile/board-lager.o
> > (no error)
> 
> I believe the enum regulator_type definition should be moved out of 
> regulator/driver.h, but that's out of scope of this patch set, so I'm fine 
> with including regulator/driver.h for now.

Thank you

Best regards
---
Kuninori Morimoto
