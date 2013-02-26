From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 26 Feb 2013 03:10:44 +0000
Subject: Re: [PATCH v2 0/4] R-Car SATA driver and platform data
Message-Id: <87r4k3db2o.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201302182327.46930.sergei.shtylyov@cogentembedded.com>
 <20130219034210.GA7701@verge.net.au>
 <512B6243.9060808@cogentembedded.com>
 <20130226000709.GB16202@verge.net.au>
In-Reply-To: <20130226000709.GB16202@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


Hi Simon, Sergei

> > >>[1/4] libata: add R-Car SATA driver
> > >>[2/4] ARM: mach-shmobile: r8a7779: SATA DT configuration
> > >>[3/4] ARM: mach-shmobile: r8a7779: add SATA support
> > >>[4/4] ARM: mach-shmobile: marzen: add SATA support
> > 
> > >>Patch 1 also applies to the 'upstream' branch of Jeff Garzik's libata-dev.git
> > >>repo.
> > 
> > >>Patch changes since the initial posting are reported in the individual patches.
> > 
> > >Thanks, I have updated topic/r-car-sata and verified
> > >that the SATA driver is successfully initialised for both
> > >non-DT and DT boot.
> > 
> >    The SATA driver have been already merged by Linus:
> > 
> > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux.git;a=commit;h3cf81d266f017d718ef786fbbb6b2513ce7ec3
> > 
> > Can we merge the rest of the patches in this merge window?
> 
> Unfortunately the path for patches for shmobile is long, arduous and
> out of my control.
> 
> I will merge the remaining patches into the renesas tree ASAP
> and push them to arm-soc for v3.10.

I guess this patch is using gic_spi() on setup-r8a7779.c

Could you please send additional patch (or v2) to use gic_iid()
instead of gic_spi() if Simon accepts my gic_iid() macro patch ?
[ARM: shmobile: add gic_iid macro for ICCIAR / interrupt ID]


Best regards
---
Kuninori Morimoto
