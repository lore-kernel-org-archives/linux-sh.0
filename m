From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 17 Sep 2015 22:15:35 +0000
Subject: Re: [PATCH 00/03] irqchip: renesas-irqc: r8a7795 and generic chip update
Message-Id: <alpine.DEB.2.11.1509180015050.3951@nanos>
List-Id: <linux-sh.vger.kernel.org>
References: <20150917071230.29299.32326.sendpatchset@little-apple> <20150917075721.GD5414@verge.net.au> <CAMuHMdUdcTGTtkiJhuqiMy_jk9qohyJmQ_y=-JhgoceqgFfdpQ@mail.gmail.com> <2709580.DITq5O9gyt@avalon>
In-Reply-To: <2709580.DITq5O9gyt@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Linux-sh list <linux-sh@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Geert Uytterhoeven <geert+renesas@glider.be>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 17 Sep 2015, Laurent Pinchart wrote:
> Hi Geert,
> 
> On Thursday 17 September 2015 10:31:59 Geert Uytterhoeven wrote:
> > On Thu, Sep 17, 2015 at 9:57 AM, Simon Horman <horms@verge.net.au> wrote:
> > > On Thu, Sep 17, 2015 at 04:12:30PM +0900, Magnus Damm wrote:
> > >> irqchip: renesas-irqc: r8a7795 and generic chip update
> > >> 
> > >> [PATCH 01/03] irqchip: renesas-irqc: Add r8a7795 IRQC DT documentation
> > >> [PATCH 02/03] irqchip: renesas-irqc: Move over to generic chip
> > >> [PATCH 03/03] irqchip: renesas-irqc: Enable nested lock
> > >> 
> > >> This series updates the IRQC driver with generic chip support including
> > >> nested locking. Also the DT documentation is extended with r8a7795
> > >> support.
> > > 
> > > Its not entirely clear what the relationship is between these patches
> > > nor what the motivation is for the last two patches.
> > 
> > Patch 2 is a cleanup/consolidation.
> 
> In just a few lines, and just for my information, what does generic IRQ chip 
> offers compared to the current implementatoin ?

Common, i.e. less duplicated code.

Thanks,

	tglx
