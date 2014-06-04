From: Ben Dooks <ben@trinity.fluff.org>
Date: Wed, 04 Jun 2014 09:38:18 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <20140604093818.GD19809@trinity.fluff.org>
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>
 <20140603214226.GA2520@sirena.org.uk>
 <87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>
 <538EE41D.3000500@codethink.co.uk>
 <CAMuHMdUKL7T0xmwz_Ji+ycLm3=S75V7tJD1wkB_wrud4gzLPBA@mail.gmail.com>
In-Reply-To: <CAMuHMdUKL7T0xmwz_Ji+ycLm3=S75V7tJD1wkB_wrud4gzLPBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>

On Wed, Jun 04, 2014 at 11:33:14AM +0200, Geert Uytterhoeven wrote:
> Hi Violeta,
> 
> On Wed, Jun 4, 2014 at 11:17 AM, Violeta Menendez Gonzalez
> <violeta.menendez@codethink.co.uk> wrote:
> >> - Which kernel are you using ?
> >
> > 3.15-rc1
> >
> >> - Does your kernel booted from legacy code (= using board-lager.c)
> >>    or from DT code (= using board-lager-referenct.c) ?
> >>
> > DT code
> 
> Does applying commit 3c90c55dcde745bed81f6447f24ba96bda43d984
> ("drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI")
> help?

We should have that in our tree (other things don't work). As a note,
we did include a debug output showing the clock driver is writing the
clock enables for these bits.

The system is also not showing any signs of external aborts, which is
indicative of trying to access an IP block when it is not clocked. I
will sit down and see if we can debug through this once we've had a
look at DMA.

-- 
Ben Dooks, ben@fluff.org, http://www.fluff.org/ben/

Large Hadron Colada: A large Pina Colada that makes the universe disappear.

