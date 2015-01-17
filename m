From: Simon Horman <horms@verge.net.au>
Date: Sat, 17 Jan 2015 00:32:18 +0000
Subject: Re: ARM: shmobile: r8a7778: Instantiate GIC from C board code in legacy builds
Message-Id: <20150117003215.GA15403@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150116011710.12605.71607.sendpatchset@little-apple>
In-Reply-To: <20150116011710.12605.71607.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Jan 16, 2015 at 10:20:38AM +0100, Geert Uytterhoeven wrote:
> On Fri, Jan 16, 2015 at 2:17 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> > From: Magnus Damm <damm+renesas@opensource.se>
> >
> > As of commit 9a1091ef0017c40a ("irqchip: gic: Support hierarchy irq
> > domain."), Bock-W legacy hangs during boot with:
> >
> > Unable to handle kernel paging request at virtual address cf86a128
> > pgd = c0004000
> > [cf86a128] *pgdo80041e(bad)
> > Internal error: Oops: 8000000d [#1] SMP ARM
> > CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.19.0-rc4 #1
> > Hardware name: bockw
> > task: cf823b40 ti: cf824000 task.ti: cf824000
> > PC is at 0xcf86a128
> > LR is at request_threaded_irq+0xbc/0x124
> >
> > This happens because the IRQ numbers of the GIC are now virtual, and no
> > longer match the hardcoded hardware IRQ numbers in the platform board
> > code.
> >
> > To fix this, instantiate the GIC from platform board code when compiling
> > a legacy kernel, like is done for the sh73a0 and r8a7740 legacy code.
> >
> > Follows same style as the r8a7740 legacy GIC fix by Geert Uytterhoeven,
> > thanks to him for the initial work.
> >
> > Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
> 
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks, its nice to see this fixed :)

I have queued up this and the similar patch for the r8a7779 as fixes for
v3.19.

I believe that now it is only the r8a73a4 that is left needing this problem
resolved. As I have access to that hardware I'm happy to help with any
work in that area.
