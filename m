From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 22 Sep 2015 10:56:55 +0000
Subject: Re: [PATCH 00/03] irqchip: renesas-irqc: r8a7795 and generic chip update
Message-Id: <alpine.DEB.2.11.1509221256100.5606@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917071230.29299.32326.sendpatchset@little-apple> <20150917075721.GD5414@verge.net.au> <CAMuHMdUdcTGTtkiJhuqiMy_jk9qohyJmQ_y=-JhgoceqgFfdpQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUdcTGTtkiJhuqiMy_jk9qohyJmQ_y=-JhgoceqgFfdpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 17 Sep 2015, Geert Uytterhoeven wrote:
> On Thu, Sep 17, 2015 at 9:57 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Sep 17, 2015 at 04:12:30PM +0900, Magnus Damm wrote:
> >> irqchip: renesas-irqc: r8a7795 and generic chip update
> >>
> >> [PATCH 01/03] irqchip: renesas-irqc: Add r8a7795 IRQC DT documentation
> >> [PATCH 02/03] irqchip: renesas-irqc: Move over to generic chip
> >> [PATCH 03/03] irqchip: renesas-irqc: Enable nested lock
> >>
> >> This series updates the IRQC driver with generic chip support including
> >> nested locking. Also the DT documentation is extended with r8a7795
> >> support.
> >
> > Its not entirely clear what the relationship is between these patches
> > nor what the motivation is for the last two patches.
> 
> Patch 2 is a cleanup/consolidation.
> 
> Note that patch 2 will no longer apply, as linux-next now has
>   - b92f865703e22b42 irqchip: renesas-irqc: Use a separate lockdep class
>   - 72e56742f6baff5d irqchip: renesas-irqc: Propagate wake-up settings to parent
> 
> Patch 3 is the irq_chip_generic way of b92f865703e22b42.

Magnus,

can you please rebase that series to 4.3-rc2, which has the above
commits.

Thanks,

	tglx
