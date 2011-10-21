From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 21 Oct 2011 01:53:33 +0000
Subject: Re: Ecovec in current sh-latest
Message-Id: <87fwin3yat.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1109020025350.15166@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1109020025350.15166@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Magnus, Paul

> > > To get ecovec to run with today's sh-latest (pretty much the same with 
> > > Linux' tree) the following patches have to be reverted:
> > > 
> > > commit 794d78fea51504bad3880d14f354a9847f318f25
> > > Author: Magnus Damm <damm@opensource.se>
> > > Date:   Tue Jun 21 07:55:12 2011 +0000
> > > 
> > >     drivers: sh: late disabling of clocks V2
> > > 
> > Do we know which driver that's the problem for the ecovec case?
> 
> I see at least two drivers misbehaving: ethernet is failing to perform 
> dhcp for nfs root-mount, and LCD gets an image at boot and then slowly 
> fade out.

My renesas_usbhs driver breaks too in SH7724 ecovec board.
So I debuged it.

when my driver call pm_runtime_get_sync(),
then, arch/sh/kernel/cpu/hwblk.c :: hwblk_enable() are called,
and it enabled my driver's MSTP bit.

But clk_late_init() disabled it.

Does hwblk/pm_runtime (?) didn't care clk->usecount ?

Best regards
---
Kuninori Morimoto
