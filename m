From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 11 May 2009 10:15:17 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <20090511101517.GA25889@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 06:59:37PM +0900, Magnus Damm wrote:
> On Mon, May 11, 2009 at 6:44 PM, Manuel Lauss
> <mano@roarinelk.homelinux.net> wrote:
> > On Mon, May 11, 2009 at 06:01:08PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@igel.co.jp>
> >>
> >> Update intc tables and platform data to use one linux irq
> >> per maskable interrupt source instead of keeping the one-to-one
> >> mapping between vectors and linux irqs.
> >>
> >> This fixes potential irq masking issues for sh7760 hardware
> >> blocks such as DMAC/TMU2/REF.
> >
> > With this patch applied, my 7760 system no longer boots. ?I'll
> > try to figure out why as soon as I get my JTAG probe back.
> 
> Oops, that's no good. I'm converting sh7760 to make use of the new
> timer driver, and while at it I wanted to fix the vectors because they
> looked like they will generate warnings...
> 
> Without this patch, do you see intc warning printouts like "intc:
> missing unique irq mask for..."?

In this particular instance, I see no outputs at all.  There are a
few of those strings, but all for devices which I don't use.

 
> Are you using DMAC, TMU2 or REF on your system?

DMAC is built-in, but no users other than DMABRG, which requests DMAC0
on init.
 
> Thanks for your help!

My pleasure!


Manuel Lauss

