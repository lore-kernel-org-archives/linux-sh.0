From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Aug 2012 07:40:37 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <20120820074036.GH25767@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 20, 2012 at 04:18:48PM +0900, Magnus Damm wrote:
> On Mon, Aug 20, 2012 at 2:24 PM, Paul Mundt <lethal@linux-sh.org> wrote:
> > On Sun, Aug 19, 2012 at 09:45:33PM -0700, Kuninori Morimoto wrote:
> >> > > irq: irq_domain_associate_many(<no-node>, irqbaseT5, hwbaseT5, count=1)
> >> > > irq: irq_domain_associate_many(<no-node>, irqbaseT6, hwbaseT6, count=1)
> >> > > irq: irq_domain_associate_many(<no-node>, irqbaseT7, hwbaseT7, count=1)
> >> > > irq: irq_domain_associate_many(<no-node>, irqbaseT8, hwbaseT8, count=1)
> >> > > irq: irq_domain_associate_many(<no-node>, irqbaseT9, hwbaseT9, count=1)
> >> > > irq: irq_domain_associate_many(<no-node>, irqbaseU0, hwbaseU0, count=1)
> >> > > irq: irq_domain_associate_many(<no-node>, irqbaseU1, hwbaseU1, count=1)
> >> > > irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=1)
> >> > > ------------[ cut here ]------------
> >> > > WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
> >> > > error: irq_desc already associated; irqU2 hwirq=0x228
> >> >
> >> > Well, that's certainly a valid bug. hwirq 552 is already bound to the
> >> > previous controller, and the vector in question is being registered a
> >> > second time under another controller. This looks to be RTDMAC_2_DEI6 (0x1300),
> >> > but the rest descends in to macro hell, so it's not obvious why the same
> >> > vector is being registered in multiple places.
> >>
> >>
> >> I'm not sure why, but this patch solved problem ?
> >>
> > I'll let Magnus figure this one out, as it was his hack in the first
> > place. At least we know the irqdomain code isn't at fault anymore.
> 
> Well, I'm quite certain it didn't trigger before the INTC code got
> this recent upgrade. Or did it fail silently? I wonder why we have to
> bump up the relocation base all of a sudden?

It was broken before, the second controller was simply trampling the
first one by way of the -EEXIST case from irq_alloc_desc_at(). The
irqdomain code has simply tightened down the sanity checks and error
path.

I have no idea what you intend to do with the relocation base, but it's
certainly not valid to have the same IRQ for multiple controllers.

> Last time I checked I had to revert two of your most recent commits to
> get the sh73a0 based board to even boot with upstream. I believe this
> is the same issue that Kobayashi-san and Morimoto-san have been talking
> about.
> 
Which have subsequently all been fixed. This issue is unrelated.

> Anyway, as I'm sure you've noticed, I put a sh7273 based board next to
> the H1 board a few weeks ago. I can also provide you with a sh73a0
> board if that would help. Please let me know if there is anything else
> you need.
> 
I don't intend to wade through the macro hell that you and Rafael
introduced to figure out why a definition is being repeated. I prefer to
avoid macro hell largely because it makes debugging things like this a
complete and utter nightmare.

You're free to ignore the warning until that gets sorted out, as it's not
fatal. As it stands sh73a0 is doing something bogus with its registration
that needs to be identified and corrected, unrelated to irqdomains.
