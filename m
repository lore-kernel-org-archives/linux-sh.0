From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 20 Aug 2012 04:19:34 +0000
Subject: Re: kzm9g boot fail (was Re: irqdomain breaks ap4 boot)
Message-Id: <87obm6ry98.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <502DDC97.5080501@kmckk.co.jp>
In-Reply-To: <502DDC97.5080501@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul

> Can you post a boot log with the pr_debug() output in the irqdomain code
> enabled? You may need to add ignore_loglevel to your kernel command line.
> 
> If that doesn't produce any further clues I'll have to find one of these
> boards to see what's going on.

This is my log

---------------------------
Starting kernel ...                                                             
                                                                                
Booting Linux on physical CPU 0                                                 
Linux version 3.6.0-rc1+ (morimoto@morimoto-Dell-XPS420) (gcc version 4.7.1 2012
CPU: ARMv7 Processor [412fc098] revision 8 (ARMv7), crc5387d                 
CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache        
Machine: kzm9g                                                                  
Memory policy: ECC disabled, Data cache writealloc                              
PERCPU: Embedded 7 pages/cpu @c08ac000 s6592 r8192 d13888 u32768                
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 125860     
Kernel command line: root=/dev/null console=ttySC4,115200                       
PID hash table entries: 2048 (order: 1, 8192 bytes)                             
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)                 
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)                  
Memory: 496MB = 496MB total                                                     
Memory: 498600k/498600k available, 9304k reserved, 0K highmem                   
Virtual kernel memory layout:                                                   
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)                               
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)                               
    vmalloc : 0xdf800000 - 0xff000000   ( 504 MB)                               
    lowmem  : 0xc0000000 - 0xdf000000   ( 496 MB)                               
    pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)                               
    modules : 0xbf000000 - 0xbfe00000   (  14 MB)                               
      .text : 0xc0008000 - 0xc03c1000   (3812 kB)                               
      .init : 0xc03c1000 - 0xc03e79c0   ( 155 kB)                               
      .data : 0xc03e8000 - 0xc041ba40   ( 207 kB)                               
       .bss : 0xc041ba64 - 0xc044a044   ( 186 kB)                               
Preemptible hierarchical RCU implementation.                                    
        RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=1.                    
NR_IRQS:16 nr_irqs:16 16                                                        
irq: Allocated domain of type 0 @0xde802800                                     
intc: Registered controller 'sh73a0-intcs' with 77 IRQs                         
irq: Allocated domain of type 3 @0xde802940                                     
irq: irq_domain_associate_many(<no-node>, irqbaseD8, hwbaseD8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseD9, hwbaseD9, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseF4, hwbaseF4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseF5, hwbaseF5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseF6, hwbaseF6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseF7, hwbaseF7, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseF8, hwbaseF8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseG2, hwbaseG2, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseG5, hwbaseG5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseG6, hwbaseG6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseG7, hwbaseG7, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseG9, hwbaseG9, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseH0, hwbaseH0, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseI2, hwbaseI2, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseI3, hwbaseI3, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseI4, hwbaseI4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseI5, hwbaseI5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseP0, hwbaseP0, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseP5, hwbaseP5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseQ6, hwbaseQ6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseQ7, hwbaseQ7, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseQ8, hwbaseQ8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseR0, hwbaseR0, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseR1, hwbaseR1, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseR2, hwbaseR2, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseR3, hwbaseR3, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseR4, hwbaseR4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseR5, hwbaseR5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseR6, hwbaseR6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseC2, hwbaseC2, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseC4, hwbaseC4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseC6, hwbaseC6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseC7, hwbaseC7, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseC8, hwbaseC8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseD3, hwbaseD3, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseD4, hwbaseD4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseD5, hwbaseD5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU3, hwbaseU3, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU4, hwbaseU4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU5, hwbaseU5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU6, hwbaseU6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU7, hwbaseU7, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseX4, hwbaseX4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseX7, hwbaseX7, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseX8, hwbaseX8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseX9, hwbaseX9, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseY0, hwbaseY0, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseY1, hwbaseY1, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseY2, hwbaseY2, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseY3, hwbaseY3, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseY4, hwbaseY4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbase`0, hwbase`0, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbase`1, hwbase`1, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbase`2, hwbase`2, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbase`3, hwbase`3, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbase`4, hwbase`4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbase`8, hwbase`8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbase`9, hwbase`9, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbasea5, hwbasea5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbasea6, hwbasea6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbasea8, hwbasea8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbasea9, hwbasea9, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb0, hwbaseb0, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb1, hwbaseb1, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb3, hwbaseb3, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb4, hwbaseb4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb5, hwbaseb5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb6, hwbaseb6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb7, hwbaseb7, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb8, hwbaseb8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseb9, hwbaseb9, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbasec0, hwbasec0, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbasec1, hwbasec1, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbasec2, hwbasec2, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbasec3, hwbasec3, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseh0, hwbaseh0, count=1)     
intc: Registered controller 'sh73a0-intca-irq-pins' with 32 IRQs                
irq: Allocated domain of type 3 @0xde8029c0                                     
irq: irq_domain_associate_many(<no-node>, irqbaseT4, hwbaseT4, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseT5, hwbaseT5, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseT6, hwbaseT6, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseT7, hwbaseT7, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseT8, hwbaseT8, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseT9, hwbaseT9, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU0, hwbaseU0, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU1, hwbaseU1, count=1)     
irq: irq_domain_associate_many(<no-node>, irqbaseU2, hwbaseU2, count=1)     
------------[ cut here ]------------                                            
WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
error: irq_desc already associated; irqU2 hwirq=0x228                         
Modules linked in:                                                              
Backtrace:                                                                      
[<c0012358>] (dump_backtrace+0x0/0x10c) from [<c02e7e1c>] (dump_stack+0x18/0x1c)
 r6:c0065640 r5:00000009 r4:c03e9ed8 r3:c0404908                                
[<c02e7e04>] (dump_stack+0x0/0x1c) from [<c001cecc>] (warn_slowpath_common+0x54)
[<c001ce78>] (warn_slowpath_common+0x0/0x6c) from [<c001cf88>] (warn_slowpath_f)
 r8:00000228 r7:c03de574 r6:00000228 r5:00000000 r4:de8029c0                    
r3:00000009                                                                     
[<c001cf50>] (warn_slowpath_fmt+0x0/0x40) from [<c0065640>] (irq_domain_associa)
 r3:00000228 r2:c037fbdb                                                        
[<c00655a4>] (irq_domain_associate_many+0x0/0x1f0) from [<c03d48a4>] (register_)
[<c03d4360>] (register_intc_controller+0x0/0x984) from [<c03c6e68>] (sh73a0_ini)
[<c03c6e04>] (sh73a0_init_irq+0x0/0x1c0) from [<c03c261c>] (init_IRQ+0x1c/0x24) 
 r7:c08a90c0 r6:c03dd774 r5:c03e8000 r4:c041ba80                                
[<c03c2600>] (init_IRQ+0x0/0x24) from [<c03c1744>] (start_kernel+0x19c/0x2a0)   
[<c03c15a8>] (start_kernel+0x0/0x2a0) from [<41008040>] (0x41008040)            
 r7:c03f3b4c r6:c03dd770 r5:c03f047c r4:10c5387d                                
---[ end trace 1b75b31a2719ed1c ]---                                            
intc: domain association failure                                                
irq: irq_domain_associate_many(<no-node>, irqbaseU3, hwbaseU3, count=1)     
------------[ cut here ]------------                                            
WARNING: at /opt/usr/src/WORK/morimoto/gitlinux/linux-2.6/kernel/irq/irqdomain.)
error: irq_desc already associated; irqU3 hwirq=0x229                         
Modules linked in:                                                              
Backtrace:                                                                      
[<c0012358>] (dump_backtrace+0x0/0x10c) from [<c02e7e1c>] (dump_stack+0x18/0x1c)
 r6:c0065640 r5:00000009 r4:c03e9ed8 r3:c0404908                                
[<c02e7e04>] (dump_stack+0x0/0x1c) from [<c001cecc>] (warn_slowpath_common+0x54)
[<c001ce78>] (warn_slowpath_common+0x0/0x6c) from [<c001cf88>] (warn_slowpath_f)
 r8:00000229 r7:c03de574 r6:00000229 r5:00000000 r4:de8029c0                    
r3:00000009                                                                     
[<c001cf50>] (warn_slowpath_fmt+0x0/0x40) from [<c0065640>] (irq_domain_associa)
 r3:00000229 r2:c037fbdb                                                        
[<c00655a4>] (irq_domain_associate_many+0x0/0x1f0) from [<c03d48a4>] (register_)
[<c03d4360>] (register_intc_controller+0x0/0x984) from [<c03c6e68>] (sh73a0_ini)
[<c03c6e04>] (sh73a0_init_irq+0x0/0x1c0) from [<c03c261c>] (init_IRQ+0x



Best regards
---
Kuninori Morimoto
