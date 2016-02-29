From: David Hildenbrand <dahi@linux.vnet.ibm.com>
Date: Mon, 29 Feb 2016 08:24:41 +0000
Subject: Re: sh7724 regression: commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93
Message-Id: <20160229092441.2e999f8d@thinkpad-w530>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
In-Reply-To: <CAMuHMdWR0RZhGrX4qW+fHwOYxAXffNinUdhrL=SZsMn5BUKoeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

> On 02/27/2016 03:28 PM, John Paul Adrian Glaubitz wrote:
> > Hi Hans!
> > 
> > On 02/27/2016 03:20 PM, Geert Uytterhoeven wrote:  
> >>> I noticed that 4.1 was ok and v4.2 wasn't, so I did a git bisect and ended up with
> >>> commit 8222dbe21e79338de92d5e1956cd1e3994cc9f93 (sched/preempt, mm/fault: Decouple
> >>> preemption from the page fault logic) as the culprit.  
> > 
> > If you like, please report this the kernel bug tracker and set
> > "Hardware" to "SuperH". This way we are able to keep track of
> > the issue.
> > 
> > I think Yoshinori Sato and Rich Felker will have a look at this.
> > 
> > Adrian
> >   
> 
> Done: https://bugzilla.kernel.org/show_bug.cgi?id3321
> 
> Regards,
> 
> 	Hans
> 

Looks like the code then requires to not be allowed to sleep/preempt in these
sections (just like kmap_atomic, or kmap_coherent on mips).

So the fix should be simple as (untested):

From d29f0d0cb670175c688cdd181c7a693d28b27a33 Mon Sep 17 00:00:00 2001             
From: David Hildenbrand <dahi@linux.vnet.ibm.com>                                  
Date: Mon, 29 Feb 2016 09:19:24 +0100                                              
Subject: [PATCH] sched/preempt, sh: kmap_coherent relies on disabled               
 preemption                                                                        
                                                                                   
kmap_coherent needs disabled preemption to not schedule in the critical            
section, just like kmap_coherent on mips and kmap_atomic in general.               
                                                                                   
Fixes: 8222dbe21e79 "sched/preempt, mm/fault: Decouple preemption from the page fault logic"
Reported-by: Hans Verkuil <hverkuil@xs4all.nl>                                     
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>                         
---                                                                                
 arch/sh/mm/kmap.c | 2 ++                                                          
 1 file changed, 2 insertions(+)                                                   
                                                                                   
diff --git a/arch/sh/mm/kmap.c b/arch/sh/mm/kmap.c                                 
index ec29e14..bf25d7c 100644                                                      
--- a/arch/sh/mm/kmap.c                                                            
+++ b/arch/sh/mm/kmap.c                                                            
@@ -36,6 +36,7 @@ void *kmap_coherent(struct page *page, unsigned long addr)    
                                                                                   
        BUG_ON(!test_bit(PG_dcache_clean, &page->flags));                          
                                                                                   
+       preempt_disable();                                                         
        pagefault_disable();                                                       
                                                                                   
        idx = FIX_CMAP_END -                                                       
@@ -64,4 +65,5 @@ void kunmap_coherent(void *kvaddr)                               
        }                                                                          
                                                                                   
        pagefault_enable();                                                        
+       preempt_enable();                                                          
 }                                                                                 
--                                                                                 
2.3.9                                                                              
         

David

