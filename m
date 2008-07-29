From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Tue, 29 Jul 2008 16:24:15 +0000
Subject: Re: SH7760: early_printk build broken
Message-Id: <20080729162415.GA8409@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <20080729142743.GA7017@roarinelk.homelinux.net>
In-Reply-To: <20080729142743.GA7017@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


> > > > Commit c63847a3621d2bac054f5709783860ecabd0ee7e ("sh: Add SCIF2 support for SH7763.")
> > > > broke build with CONFIG_EARLY_PRINTK enabled for me (SH7760):
> > > > 
> > > >   CC      arch/sh/kernel/early_printk.o
> > > > /mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c: In function 'scif_sercon_putc':
> > > > /mnt/work/sh7760/kernel/linux-2.6.git/arch/sh/kernel/early_printk.c:84: error: implicit declaration of function 'sci_SCFDR_in'
> > > > 
> > > > I don't know immediately how to fix it though, could you please take a look?
> > > > 
> > > I see what happened. Proof that this file is such a ridiculous
> > > clusterfuck it's hard to know where to even begin.
> > >

Heh, it's an interesting maze of Hitachi serial port silicon history... ;-)


> > With the generic kgdbts stuff in now and the sh-bios users falling by the
> > way side, sh-sci is long overdue for a total rewrite anyways. It's only
> > been 6+ years since the last time I rewrote it anyways, when I had
> > planned to get rid of sh-sci.h also.

Have fun ;-)  If you are busy with more interesting stuff, I may be able
to take a shot at it next week.

Thank you.
	Manuel Lauss
