From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Fri, 05 Sep 2008 09:01:36 +0000
Subject: Re: [PATCH] support for edosk7760 board
Message-Id: <20080905090136.GB22135@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <48B52DC8.1020208@spesonline.com>
In-Reply-To: <48B52DC8.1020208@spesonline.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Sep 05, 2008 at 05:46:08PM +0900, Magnus Damm wrote:
> On Fri, Sep 5, 2008 at 5:33 PM, Manuel Lauss
> <mano@roarinelk.homelinux.net> wrote:
> > Hi Magnus,
> >
> > On Fri, Sep 05, 2008 at 05:14:34PM +0900, Magnus Damm wrote:
> >> On Mon, Sep 1, 2008 at 5:11 PM, Luca Santini
> >> <luca.santini@spesonline.com> wrote:
> >> > thanks for reply Magnus,
> >> > in 2.6.26 everything works fine with irq 9;
> >>
> >> I see that you install imask handlers for the flash and the ethernet:
> >>
> >> +static int __init init_edosk7760_devices(void){
> >> +       int ret = -1;
> >> +
> >> +       /* This is the Ethernet interrupt */
> >> +       make_imask_irq(ETHERNET_IRQ);
> >> +
> >> +       /* This is the IntelStrata Flash interrupt */
> >> +       make_imask_irq(0x0A);
> >>
> >> Is the flash interrupt tested?
> >>
> >> I suspect that the chips are connected straight to the IRL pins of the
> >> processor. Using "individual interrupt mode" would make sense then. Do
> >> you have access to schematics?
> >
> > According to the schematics, 15 irqs are connected to a CPLD which creates
> > the 4bit IRL value. Unfortunately there is no way to individually mask them
> > in the CPLD itself (it has no databus connection).
> 
> Ok, thank you. That's disgusting.

Yes, yes it is...

 
> Are all 15 irqs in use? If we only plan on using the ethernet and the
> flash, then maybe we can use "individual interrupt mode". Then we can
> mask using the cpu.

All except the ethernet and flash irqs are connected to "buffered expasion"
connectors for daughtercards.  So there's really only 1 interesting source.


> The code seems to use interrupt number 9 and 10, so maybe the ethernet
> controller can use IRL0 (interrupt number 2) and flash IRL1 (interrupt
> number 5). The interrupts may of course block each other but there's
> nothing we can do about that...
> 
> Or as a last resort we may have to fix up the imask controller. =)

Heh, I'd rather shame the board vendor into fixing this, but your idea
has a far greater chance of success ;-)

MfG,
	Manuel Lauss
