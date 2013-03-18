From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 18 Mar 2013 01:34:19 +0000
Subject: Re: [PATCH 0/5] ARM: shmobile: Add R-Car M1A Bock-W support
Message-Id: <87zjy17ap6.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87y5e3pra9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y5e3pra9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Sergei, Simon

> > On 03/04/2013 10:17 AM, Kuninori Morimoto wrote:
> > 
> > >These are R-Car M1A chip and Bock-W board support
> > >
> > >Bock-W board needs ${LINUX}/arch/arm/tools/mach-types
> > >
> > >bockw                  MACH_BOCKW              BOCKW                   3386
> > >
> > >ARM Web site already has Bock-W, mach-types will be updated
> > >if upstream kernel has it.
> > >
> > >This series doesn't support DT yet.
> > >I'm working for it, but still doesn't work.
> > >I will send my current DT support work for R-Car M1,
> > >it is very helpful for me if you give feedback.
> > >
> > >These patches are based on simon/next branch
> > >
> > >Kuninori Morimoto (5):
> > >       ARM: shmobile: add R8A7778 setup support
> > >       ARM: shmobile: add R8A7778 clock support
> > >       ARM: shmobile: add R8A7778 intc support
> > >       ARM: shmobile: add r8a7778 GPIO/PFC support
> > 
> >    I can't find patch 4 of this series anywhere, and it seems I
> > can't build board-bockw.c without it. Was it ever posted?
> 
> For the record, I can't locate it either.

I didn't notice,
but maybe it is upstream ML size issue.
(GPIO/PFC patch is very large size)

Anyway, I sent R-Car M1 v2 patch last week (?)
and, will send v3 patch
(it doesn't include GPIO support though)

Best regards
---
Kuninori Morimoto
