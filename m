From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 10 Aug 2012 06:10:43 +0000
Subject: Re: irqdomain breaks ap4 boot
Message-Id: <874nobqntv.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878vdxd3mq.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> >     sh: intc: Handle domain association for sparseirq pre-allocated vectors.
> >     
> >     Presently it's assumed that the irqdomain code handles the irq_desc
> >     allocation for us, but this isn't necessarily the case when we've
> >     pre-allocated IRQs via sparseirq. Previously we had a -EEXIST check in
> >     the code that attempted to trap these cases and simply update them
> >     in-place, but this behaviour was inadvertently lost in the transition to
> >     irqdomains.
> >     
> >     This simply restores the previous behaviour, first attempting to let the
> >     irqdomain core fetch the allocation for us, and falling back to an
> >     in-place domain association in the extant IRQ case. Fixes up regressions
> >     on platforms that pre-allocate legacy IRQs (specifically ARM-based
> >     SH-Mobile platforms, as SH stopped pre-allocating vectors some time ago).
> >     
> >     Reported-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> >     Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> 
> This patch solved mackerel board crush bug on linus/master

ecovec/armadillo/marzen board were OK on this patch,
but kzm9g board still has problem.
I'm using "linus/master + paul/sh-latest"

========= kernel log ==============-
....
Preemptible hierarchical RCU implementation.                                    
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.                    
NR_IRQS:16 nr_irqs:16 16                                                        
intc: Registered controller 'sh73a0-intcs' with 77 IRQs                         
intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs                
------------[ cut here ]------------                                            
WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
error: irq_desc already associated; irqU2 hwirq=0x228                         
Modules linked in:                                                              
Backtrace:                                                                      
[<c0012358>] (dump_backtrace+0x0/0x10c) from [<c02e7e1c>] (dump_stack+0x18/0x1c)
 r6:c00655ec r5:00000009 r4:c03e9ed8 r3:c0404908                                
[<c02e7e04>] (dump_stack+0x0/0x1c) from [<c001cecc>] (warn_slowpath_common+0x54)
[<c001ce78>] (warn_slowpath_common+0x0/0x6c) from [<c001cf88>] (warn_slowpath_f)
 r8:00000228 r7:c03de574 r6:00000228 r5:00000000 r4:de8029c0                    
r3:00000009                                                                     
[<c001cf50>] (warn_slowpath_fmt+0x0/0x40) from [<c00655ec>] (irq_domain_associa)
 r3:00000228 r2:c037fb49                                                        
[<c006557c>] (irq_domain_associate_many+0x0/0x1b8) from [<c03d48a4>] (register_)
[<c03d4360>] (register_intc_controller+0x0/0x984) from [<c03c6e68>] (sh73a0_ini)
[<c03c6e04>] (sh73a0_init_irq+0x0/0x1c0) from [<c03c261c>] (init_IRQ+0x1c/0x24) 
 r7:c08a90c0 r6:c03dd774 r5:c03e8000 r4:c041ba80                                
[<c03c2600>] (init_IRQ+0x0/0x24) from [<c03c1744>] (start_kernel+0x19c/0x2a0)   
[<c03c15a8>] (start_kernel+0x0/0x2a0) from [<41008040>] (0x41008040)            
 r7:c03f3b4c r6:c03dd770 r5:c03f047c r4:10c5387d                                
---[ end trace 1b75b31a2719ed1c ]---                                            
intc: domain association failure                        

Best regards
---
Kuninori Morimoto
