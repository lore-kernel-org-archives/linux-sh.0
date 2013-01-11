From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 11 Jan 2013 02:14:24 +0000
Subject: Current SuperH board can't boot
Message-Id: <87vcb44gaq.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi Paul, Michel, and all

I noticed that SuperH ecovec board can't boot on latest linus/master branch.
NFS rootfs can't mount.
I git-bisect'ed this issue, and found first bad commit.
Below is bad commit and my kernel log.

--- first bad commit -------------------------------
b4265f12340f809447b9a48055e88c444b480c89 is the first bad commit
commit b4265f12340f809447b9a48055e88c444b480c89
Author: Michel Lespinasse <walken@google.com>
Date:   Tue Dec 11 16:02:12 2012 -0800

mm: use vm_unmapped_area() on sh architecture

Update the sh arch_get_unmapped_area[_topdown] functions to make use of
vm_unmapped_area() instead of implementing a brute force search.

[akpm@linux-foundation.org: remove now-unused COLOUR_ALIGN_DOWN()]
Signed-off-by: Michel Lespinasse <walken@google.com>
Reviewed-by: Rik van Riel <riel@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Mundt <lethal@linux-sh.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Chris Metcalf <cmetcalf@tilera.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

:040000 040000 4bb40855396d49b51e499d2d4eafff31288b6d03 6b51feb630302d72692ee15eead57bc0b1639147 M	arch

--- kernel boot log -------------------------------
...
asoc-simple-card asoc-simple-card.0:  da7210-hifi <-> fsib-dai mapping ok                                                                
net eth0: attached phy 31 to driver SMSC LAN8700                                                                                         
Sending DHCP requests ..libphy: sh-eth-0:1f - Link is Up - 100/Full                                                                      
., OK                                                                                                                                    
IP-Config: Got DHCP answer from 192.168.10.77, my address is 192.168.10.119                                                              
IP-Config: Complete:                                                                                                                     
     device=eth0, addr2.168.10.119, mask%5.255.255.0, gw2.168.10.77                                                              
     host2.168.10.119, domain=example.org, nis-domain=(none)                                                                          
     bootserver2.168.10.77, rootserver2.168.10.77, rootpath=/opt/tftpboot/rootfs_ms7724se                                          
     nameserver02.168.10.77ALSA device list:                                                                                          
  #0: FSIB-DA7210                                                                                                                        
VFS: Mounted root (nfs filesystem) on device 0:9.                                                                                        
Freeing unused kernel memory: 136k freed                                                                                                 
Kernel panic - not syncing: No init found.  Try passing init= option to kernel. See Linux Documentation/init.txt for guidance.           
Stack: (0x8f029f3c to 0x8f02a000)                                                                                                        
9f20:                                                                882b1c2a                                                            
9f40: 8f029f4c 00000000 88369c68 882b1cb4 8f029f54 00000000 00000000 00000000                                                            
9f60: 8f029f84 882adcc0 8f029f90 00000000 00000000 00000000 00000000 00000000                                                            
9f80: 88002050 883db36c 883db2e0 00140173 88003a78 8f029f9c 00000000 00000000                                                            
9fa0: 00000000 00000000 00000000 00000000 00000000 00000000 882adc1c 00000000                                                            
9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000                                                            
9fe0: 8f029fa4 88003a70 00000000 40008000 00000000 00000000 00000000 00000000                                                            
                                                                                                                                         
Call trace:                                                                                                                              
 [<882b1c2a>] dump_stack+0xe/0x1c                                                                                                        
 [<882b1cb4>] panic+0x7c/0x1b8                                                                                                           
 [<882adcc0>] kernel_init+0xa4/0xf8                                                                                                      
 [<88002050>] run_init_process+0x0/0x24                                                                                                  
 [<88003a78>] kernel_thread_helper+0x8/0x14                                                                                              
 [<882adc1c>] kernel_init+0x0/0xf8                                                                                                       
 [<88003a70>] kernel_thread_helper+0x0/0x14                                                                                              
                                                                                                                                         
1 lock held by init/1:                                                                                                                   
 #0:  (panic_lock){......}, at: [<882b1c62>] panic+0x2a/0x1b8                                                                            

