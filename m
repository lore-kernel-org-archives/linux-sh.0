From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Aug 2012 05:24:59 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <20120820052459.GE25767@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Aug 19, 2012 at 09:45:33PM -0700, Kuninori Morimoto wrote:
> 
> Hi Paul
> Cc Magnus, Kobayashi-san
> 
> > > irq: irq_domain_associate_many(<no-node>, irqbaseT5, hwbaseT5, count=1)     
> > > irq: irq_domain_associate_many(<no-node>, irqbaseT6, hwbaseT6, count=1)     
> > > irq: irq_domain_associate_many(<no-node>, irqbaseT7, hwbaseT7, count=1)     
> > > irq: irq_domain_associate_many(<no-node>, irqbaseT8, hwbaseT8, count=1)     
> > > irq: irq_domain_associate_many(<no-node>, irqbaseT9, hwbaseT9, count=1)     
> > > irq: irq_domain_associate_many(<no-node>, irqbaseU0, hwbaseU0, count=1)     
> > > irq: irq_domain_associate_many(<no-node>, irqbaseU1, hwbaseU1, count=1)     
> > > irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=1)     
> > > ------------[ cut here ]------------                                            
> > > WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
> > > error: irq_desc already associated; irqU2 hwirq=0x228                         
> > 
> > Well, that's certainly a valid bug. hwirq 552 is already bound to the
> > previous controller, and the vector in question is being registered a
> > second time under another controller. This looks to be RTDMAC_2_DEI6 (0x1300),
> > but the rest descends in to macro hell, so it's not obvious why the same
> > vector is being registered in multiple places.
> 
> 
> I'm not sure why, but this patch solved problem ?
> 
I'll let Magnus figure this one out, as it was his hack in the first
place. At least we know the irqdomain code isn't at fault anymore.
