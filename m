From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 11 May 2009 09:56:56 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <20090511095655.GA11860@linux-sh.org>
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
> 
Yeah, I noticed these earlier in Manuel's boot log:

intc: missing unique irq mask for irq 34 (vect 0x0640)
intc: missing unique irq mask for irq 35 (vect 0x0660)
intc: missing unique irq mask for irq 36 (vect 0x0680)
intc: missing unique irq mask for irq 37 (vect 0x06a0)
intc: missing unique irq mask for irq 44 (vect 0x0780)
intc: missing unique irq mask for irq 45 (vect 0x07a0)
intc: missing unique irq mask for irq 46 (vect 0x07c0)
intc: missing unique irq mask for irq 47 (vect 0x07e0)
intc: missing unique irq mask for irq 38 (vect 0x06c0)
intc: missing unique irq mask for irq 18 (vect 0x0440)
intc: missing unique irq mask for irq 19 (vect 0x0460)
intc: missing unique irq mask for irq 28 (vect 0x0580)
intc: missing unique irq mask for irq 29 (vect 0x05a0)

http://marc.info/?l=linux-sh&m4144524704881&w=2
