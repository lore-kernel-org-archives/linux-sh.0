From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 20 Aug 2012 04:38:53 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <20120820043853.GD25767@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Sun, Aug 19, 2012 at 09:19:34PM -0700, Kuninori Morimoto wrote:
> 
> Hi Paul
> 
> > Can you post a boot log with the pr_debug() output in the irqdomain code
> > enabled? You may need to add ignore_loglevel to your kernel command line.
> > 
> > If that doesn't produce any further clues I'll have to find one of these
> > boards to see what's going on.
> 
> This is my log
> 
> NR_IRQS:16 nr_irqs:16 16                                                        
> irq: Allocated domain of type 0 @0xde802800                                     
> intc: Registered controller 'sh73a0-intcs' with 77 IRQs                         
> irq: Allocated domain of type 3 @0xde802940                                     
..
> irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=1)     
..
> intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs                
> irq: Allocated domain of type 3 @0xde8029c0                                     
> irq: irq_domain_associate_many(<no-node>, irqbaseT4, hwbaseT4, count=1)     
> irq: irq_domain_associate_many(<no-node>, irqbaseT5, hwbaseT5, count=1)     
> irq: irq_domain_associate_many(<no-node>, irqbaseT6, hwbaseT6, count=1)     
> irq: irq_domain_associate_many(<no-node>, irqbaseT7, hwbaseT7, count=1)     
> irq: irq_domain_associate_many(<no-node>, irqbaseT8, hwbaseT8, count=1)     
> irq: irq_domain_associate_many(<no-node>, irqbaseT9, hwbaseT9, count=1)     
> irq: irq_domain_associate_many(<no-node>, irqbaseU0, hwbaseU0, count=1)     
> irq: irq_domain_associate_many(<no-node>, irqbaseU1, hwbaseU1, count=1)     
> irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=1)     
> ------------[ cut here ]------------                                            
> WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
> error: irq_desc already associated; irqU2 hwirq=0x228                         

Well, that's certainly a valid bug. hwirq 552 is already bound to the
previous controller, and the vector in question is being registered a
second time under another controller. This looks to be RTDMAC_2_DEI6 (0x1300),
but the rest descends in to macro hell, so it's not obvious why the same
vector is being registered in multiple places.
