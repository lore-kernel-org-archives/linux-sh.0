From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 09 Jun 2011 06:21:17 +0000
Subject: Ecovec (SH7724) board doesn't work on latest linus tree
Message-Id: <w3pvcwf5xuu.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Dear Paul

Ecovec (SH7724) board doesn't work on latest linus tree.

But if I revert below patch, it works.
I attached kernel dead log

--- I reverted this patch from linus/master -----

commit 3f9b8520b06013939ad247ba08b69529b5f14be1
Author: Paul Mundt <lethal@linux-sh.org>
Date:   Tue May 31 14:38:29 2011 +0900

    sh64: Move from P1SEG to CAC_ADDR for consistent sync.
    
    sh64 doesn't define a P1SEGADDR, resulting in a build failure. The proper
    mapping can be attained for both sh32 and 64 via the CAC_ADDR macro, so
    switch to that instead.
    
    Signed-off-by: Paul Mundt <lethal@linux-sh.org>

------- kernel dead log ----------
...
pid_max: default: 32768 minimum: 301                                            
Mount-cache hash table entries: 512                                             
CPU: SH7724                                                                     
Performance Events: sh4a support registered                                     
NET: Registered protocol family 16                                              
vpu: forcing memory chunk size to 0x00800000                                    
Unable to handle kernel paging request at virtual address 6e000000              
pc = 8800ef82                                                                   
*pde = 00000000                                                                 
Oops: 0000 [#1]                                                                 
Modules linked in:                                                              
                                                                                
Pid : 1, Comm:          swapper                                                 
CPU : 0                 Not tainted  (3.0.0-rc2+ #910)                          
                                                                                
PC is at sh4__flush_purge_region+0x30/0x8a                                      
PR is at dma_cache_sync+0x32/0x54                                               
PC  : 8800ef82 SP  : 8f029eec SR  : 40008000 TEA : 6e000000                     
R0  : 00040000 R1  : 6e000000 R2  : 6e000000 R3  : 00000100                     
R4  : 00008000 R5  : 000000a0 R6  : 000000c0 R7  : 000000e0                     
R8  : 00000080 R9  : 0000000b R10 : 8e000000 R11 : 00800000                     
R12 : 007fffff R13 : 883d3e0e R14 : 8f029eec                                    
MACH: 00000000 MACL: 00000000 GBR : 00000000 PR  : 8800e422                     
                                                                                
Call trace:                                                                     
 [<8800e510>] dma_generic_alloc_coherent+0x54/0x11c                             
 [<883d3e0e>] platform_resource_setup_memory+0xda/0x15c                         
 [<88138cd4>] strstr+0x0/0x6c                                                   
 [<882882ee>] _raw_spin_unlock_irqrestore+0x1e/0x58                             
 [<883d2f46>] sh7724_devices_setup+0x16/0x94                                    
 [<883d3d34>] platform_resource_setup_memory+0x0/0x15c                          
 [<880020ea>] do_one_initcall+0x9a/0x15c                                        
 [<883d2f30>] sh7724_devices_setup+0x0/0x94                                     
 [<883d1242>] kernel_init+0x72/0x138                                            
 [<88002050>] do_one_initcall+0x0/0x15c                                         
 [<88003d34>] kernel_thread_helper+0x8/0x14                                     
 [<883d11d0>] kernel_init+0x0/0x138                                             
 [<88003d2c>] kernel_thread_helper+0x0/0x14                                     
                                                                                
INFO: lockdep is turned off.                                                    
Process: swapper (pid: 1, stack limit = 8f028001)                               
Stack: (0x8f029eec to 0x8f02a000)                                               
9ee0:                            8f029ef8 0000000b 80000000 8800e510 8f029f00   
9f00: 00000004 8f029f2c 883d3e0e 8f029f28 88138cd4 8839b040 8f029f2c 00800000   
9f20: 8832ec3c 8839dfc4 882882ee 8f029f34 883d2f46 8f029f50 00000000 00000000   
9f40: 00000000 883f03cc 00200000 883d3d34 880020ea 8f029f60 883d2f30 883eff48   
9f60: 883ac1a0 8f029f68 883d1242 8f029f88 00000000 00000000 00000000 883f03cc   
9f80: 88002050 883eff48 88003d34 8f029f9c 00000000 00000000 00000000 00000000   
9fa0: 00000000 00000000 00000000 00000000 00000000 00000000 883d11d0 00000000   
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000   
9fe0: 8f029fa4 88003d2c 00000000 40008000 00000000 00000000 00000000 00000000   
---[ end trace 4eaa2a86a8e2da22 ]---                                            
Kernel panic - not syncing: Attempted to kill init!                             
Stack: (0x8f029ce0 to 0x8f02a000)                                               
9ce0: 882850c6 8f029cf0 88330b0c 8813b808 88285130 8f029cf8 8f029d20 8f029d00   
9d00: 8f029d24 880196d2 8f029d30 00000000 00000000 883ab46c 8f029d14 8f027080   
9d20: 8f027080 00000001 88019904 8f0271b4 883f3f0c 8833a328 883a9d6c 88285248   
9d40: 00000001 00000000 8f029d48 8f029d48 8f0271b4 88005d6e 8f029d74 00000000   
9d60: 00000000 88285248 8832ff18 00000000 8f029e90 8800f574 8f029d8c 00000000   
9d80: 88285248 6e000000 8f029e90 8f029d90 00000000 880070f4 8f029dfc 400080f1   
9da0: 00000000 8e556000 00000064 00000000 8e555c60 00000000 00000c80 ffe00000   
9dc0: 00000800 0000000b 00000555 88285dcc 8f029dec 888ab000 887d6dac 888b5aa0   
9de0: 00000555 882856cc 10000000 88058d8e 8f029dfc 0000000b 00000800 8f030060   
9e00: 8f027080 00008000 00000000 0000000c 00000000 8f029e1c 00000000 00000000   
9e20: 883d037c fffff800 00000000 00000000 883cfff4 00000010 00000000 00000000   
9e40: 883cfd14 883cffac 00000000 000280d0 883cfcf8 88058fec 8f029e84 00000000   
9e60: 007fffff 883d0378 00000000 0000000b 880070ec 8f029eec 883d3e0e 007fffff   
9e80: 00800000 880070ec 880070ec 00000000 00040000 6e000000 6e000000 00000100   
9ea0: 00008000 000000a0 000000c0 000000e0 00000080 0000000b 8e000000 00800000   
9ec0: 007fffff 883d3e0e 8f029eec 8f029eec 8800ef82 8800e422 40008000 00000000   
9ee0: 00000000 00000000 ffffffff 8f029ef8 0000000b 80000000 8800e510 8f029f00   
9f00: 00000004 8f029f2c 883d3e0e 8f029f28 88138cd4 8839b040 8f029f2c 00800000   
9f20: 8832ec3c 8839dfc4 882882ee 8f029f34 883d2f46 8f029f50 00000000 00000000   
9f40: 00000000 883f03cc 00200000 883d3d34 880020ea 8f029f60 883d2f30 883eff48   
9f60: 883ac1a0 8f029f68 883d1242 8f029f88 00000000 00000000 00000000 883f03cc   
9f80: 88002050 883eff48 88003d34 8f029f9c 00000000 00000000 00000000 00000000   
9fa0: 00000000 00000000 00000000 00000000 00000000 00000000 883d11d0 00000000   
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000   
9fe0: 8f029fa4 88003d2c 00000000 40008000 00000000 00000000 00000000 00000000   
                                                                                
Call trace:                                                                     
 [<882850c6>] dump_stack+0xe/0x1c                                               
 [<8813b808>] bust_spinlocks+0x0/0x4c                                           
 [<88285130>] panic+0x5c/0x174                                                  
 [<880196d2>] do_exit+0x6a/0x5cc                                                
 [<88019904>] do_exit+0x29c/0x5cc                                               
 [<88285248>] printk+0x0/0x30                                                   
 [<88005d6e>] die+0xf2/0x164                                                    
 [<88285248>] printk+0x0/0x30                                                   
 [<8800f574>] do_page_fault+0x29c/0x350                                         
 [<88285248>] printk+0x0/0x30                                                   
 [<880070f4>] ret_from_irq+0x0/0x10                                             
 [<88285dcc>] preempt_schedule+0x2c/0x58                                        
 [<882856cc>] schedule+0x0/0x480                                                
 [<88058d8e>] get_page_from_freelist+0x35a/0x40c                                
 [<88058fec>] __alloc_pages_nodemask+0xbc/0x4c0                                 
 [<880070ec>] ret_from_exception+0x0/0x8                                        
 [<883d3e0e>] platform_resource_setup_memory+0xda/0x15c                         
 [<880070ec>] ret_from_exception+0x0/0x8                                        
 [<880070ec>] ret_from_exception+0x0/0x8                                        
 [<883d3e0e>] platform_resource_setup_memory+0xda/0x15c                         
 [<8800ef82>] sh4__flush_purge_region+0x30/0x8a                                 
 [<8800e422>] dma_cache_sync+0x32/0x54                                          
 [<8800e510>] dma_generic_alloc_coherent+0x54/0x11c                             
 [<883d3e0e>] platform_resource_setup_memory+0xda/0x15c                         
 [<88138cd4>] strstr+0x0/0x6c                                                   
 [<882882ee>] _raw_spin_unlock_irqrestore+0x1e/0x58                             
 [<883d2f46>] sh7724_devices_setup+0x16/0x94                                    
 [<883d3d34>] platform_resource_setup_memory+0x0/0x15c                          
 [<880020ea>] do_one_initcall+0x9a/0x15c                                        
 [<883d2f30>] sh7724_devices_setup+0x0/0x94                                     
 [<883d1242>] kernel_init+0x72/0x138                                            
 [<88002050>] do_one_initcall+0x0/0x15c                                         
 [<88003d34>] kernel_thread_helper+0x8/0x14                                     
 [<883d11d0>] kernel_init+0x0/0x138                                             
 [<88003d2c>] kernel_thread_helper+0x0/0x14                                     
                                                                                
INFO: lockdep is turned off.                                                    



Best regards
--
Kuninori Morimoto
 
