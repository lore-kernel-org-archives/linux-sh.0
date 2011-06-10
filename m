From: Simon Horman <horms@verge.net.au>
Date: Fri, 10 Jun 2011 06:00:02 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 gic_arch_extn.irq_set_wake()
Message-Id: <20110610055956.GB22411@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110609062003.383.67447.sendpatchset@t400s>
In-Reply-To: <20110609062003.383.67447.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Fri, Jun 10, 2011 at 02:03:43PM +0900, Magnus Damm wrote:
> On Fri, Jun 10, 2011 at 11:20 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Jun 09, 2011 at 03:20:03PM +0900, Magnus Damm wrote:
> >> From: Magnus Damm <damm@opensource.se>
> >>
> >> Initialize ->irq_set_wake() in gic_arch_extn to unbreak wake
> >> up from the KEYSC device on AG5EVM in case of Suspend-to-RAM.
> >>
> >> Without this patch "echo mem > /sys/power/state" and a key
> >> press results in the following message on resume:
> >>
> >> WARNING: at kernel/irq/manage.c:507 irq_set_irq_wake+0x7c/0xd8()
> >> Unbalanced IRQ 103 wake disable
> >>
> >> Signed-off-by: Magnus Damm <damm@opensource.se>
> >> ---
> >>
> >>  arch/arm/mach-shmobile/intc-sh73a0.c |    6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> --- 0001/arch/arm/mach-shmobile/intc-sh73a0.c
> >> +++ work/arch/arm/mach-shmobile/intc-sh73a0.c 2011-06-08 18:42:14.000000000 +0900
> >> @@ -250,6 +250,11 @@ static irqreturn_t sh73a0_intcs_demux(in
> >>       return IRQ_HANDLED;
> >>  }
> >>
> >> +static int sh73a0_set_wake(struct irq_data *data, unsigned int on)
> >> +{
> >> +     return 0; /* always allow wakeup */
> >> +}
> >> +
> >
> > I wonder if a more generic location and name for this would be worthwhile.
> > It seems to me that that other hardware may also want to do this.
> 
> Not so sure about that. It all depends on what other hardware
> platforms need to do in their sleep code. Do you have any particular
> hardware platform in mind?

No, I don't have any other hardware in mind.
