From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 08 Jul 2013 23:21:50 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790 SMP prototype v2
Message-Id: <201307090121.50685.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20130626235837.11576.86389.sendpatchset@w520>
 <201306271401.13198.arnd@arndb.de>
 <CANqRtoRR-pyCpXYwKXRYSfVOewv+dXf=ntofJJsKQ0defF5-MQ@mail.gmail.com>
In-Reply-To: <CANqRtoRR-pyCpXYwKXRYSfVOewv+dXf=ntofJJsKQ0defF5-MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Monday 08 July 2013, Magnus Damm wrote:
> >> +static void __init r8a7790_smp_prepare_cpus(unsigned int max_cpus)
> >> +{
> >> +     void __iomem *p;
> >> +     unsigned int k;
> >> +
> >> +     shmobile_boot_fn = virt_to_phys(shmobile_invalidate_start);
> >> +
> >> +     /* MERAM for jump stub, because BAR requires 256KB aligned address */
> >> +     p = ioremap_nocache(MERAM, 16);
> >> +     memcpy(p, shmobile_boot_vector, 16);
> >> +     iounmap(p);
> >
> > On the other hand here you have to use __raw_writel() or
> > memcpy_toio() because memcpy cannot operate on __iomem tokens.
> >
> > Also, if this is actually memory, you probably want to use ioremap_cached
> > or ioremap_writecombine.
> 
> Yeah, I realize this may be a bit of a mess. So say that I used
> ioremap_cached() here, I think I still need to flush the cache to make
> sure the secondary processors have valid code available then they
> boot. I suppose you're fine with that?

Is that required to get the data from dcache to icache? If so, that
sounds right.

	Arnd
