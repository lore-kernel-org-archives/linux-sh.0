From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 06 Jun 2014 10:24:08 +0000
Subject: Re: [PATCH 00/08] ARM: shmobile: Rework include path (Try 2, Part 1)
Message-Id: <4635749.xI9zCngNoZ@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <20140520075949.13851.42995.sendpatchset@w520>
 <CAMuHMdWuaeZOAA-=k7nHQafxJh7h-jQqtfEGJKiEmraZXu2p+g@mail.gmail.com>
In-Reply-To: <CAMuHMdWuaeZOAA-=k7nHQafxJh7h-jQqtfEGJKiEmraZXu2p+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 06 June 2014 11:11:46 Geert Uytterhoeven wrote:
> 
> On Tue, May 20, 2014 at 9:59 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > ARM: shmobile: Rework include path (Try 2, Part 1)
> >
> > [PATCH 01/08] ARM: shmobile: Move intc.h, cleanup sh_intc.h usage
> > [PATCH 02/08] ARM: shmobile: Move dma-register.h
> > [PATCH 03/08] ARM: shmobile: Move clock.h
> > [PATCH 04/08] ARM: shmobile: Move most of irqs.h, keep some for pinctl
> > [PATCH 05/08] ARM: shmobile: Move common.h
> > [PATCH 06/08] ARM: shmobile: Move pm-rmobile.h, cleanup sh73xx.h
> > [PATCH 07/08] ARM: shmobile: Move pm-rcar.h, cleanup r8a7779 case
> > [PATCH 08/08] ARM: shmobile: Move rcar-gen2.h, cleanup r8a7790 case
> >
> > Olof, here my latest take on the header move that you requested earlier.
> >
> > This particular series hopefully follows your proposed way and moves the
> > most common shared header files for mach-shmobile from <mach/foobar.h>
> > to "foobar.h" without any workaround. Left are still per-SoC header files
> > that will be moved once I know you are comformatble with this format.
> 
> Olof didn't scream, so I guess he's comfortable with it? 
> Olof?
> 
> If the propagation part is an issue, what about Simon applying it to a separate
> branch, to be merged into both soc-for-v3.17 and boards-for-v3.17?

I certainly love it.

> > Please note that these are only lightly compile tested with a handful
> > of defconfigs, but any potential issue should be trivial to fix.
> 
> Indeed. And it touches arch/arm/mach-shmobile only.
> 
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
