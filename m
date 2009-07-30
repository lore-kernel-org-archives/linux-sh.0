From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 30 Jul 2009 05:25:26 +0000
Subject: Re: Problem with current kernel and old sh3 machines
Message-Id: <20090730052525.GA29064@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
In-Reply-To: <aec7e5c30907232030pf8d5e92h1ae9d73d5a5e8e44@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jul 29, 2009 at 10:11:45PM -0300, Rafael Ignacio Zurita wrote:
> Node 0: start_pfn = 0xd000, low = 0xe000                                        
> Zone PFN ranges:                                                                
>   Normal   0x0000d000 -> 0x0000e000                                             
> Movable zone start PFN for each node                                            
> early_node_map[1] active PFN ranges                                             
>     0: 0x0000d000 -> 0x0000e000                                                 
> Built 1 zonelists in Zone order, mobility grouping off.  Total pages: 4064      
> Kernel command line: memM init=/bin/sh earlyprintk=serial                    
> NR_IRQS:256                                                                     
> PID hash table entries: 64 (order: 6, 256 bytes)                                
> Console: colour dummy device 80x25                                              
> console handover: boot [sercon0] -> real [tty0]        
> 
> and I guess that the system hangs. 
> Should I try other printks in other places? Suggestions?
> 
earlyprintk=serial,keep
