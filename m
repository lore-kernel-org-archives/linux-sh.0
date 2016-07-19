From: David Rientjes <rientjes@google.com>
Date: Tue, 19 Jul 2016 19:28:48 +0000
Subject: Re: [PATCH] sh-DWARF: Delete unnecessary checks before the function call "mempool_destroy"
Message-Id: <alpine.DEB.2.10.1607191228070.52203@chino.kir.corp.google.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5307CAA2.8060406@users.sourceforge.net> <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6> <530A086E.8010901@users.sourceforge.net> <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6> <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6> <530B5FB6.6010207@users.sourceforge.net> <alpine.DEB.2.10.1402241710370.2074@hadrien> <530C5E18.1020800@users.sourceforge.net> <alpine.DEB.2.10.1402251014170.2080@hadrien> <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien> <530CF8FF.8080600@users.sourceforge.net> <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6> <530DD06F.4090703@users.sourceforge.net> <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <564985B7.3080806@users.sourceforge.net> <8876165d-9a23-c837-cdb1-bcf60fa058a8@users.sourceforge.net>
In-Reply-To: <8876165d-9a23-c837-cdb1-bcf60fa058a8@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Tue, 19 Jul 2016, SF Markus Elfring wrote:

> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 16 Nov 2015 08:20:36 +0100
> > 
> > The mempool_destroy() function tests whether its argument is NULL
> > and then returns immediately. Thus the test around the calls is not needed.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  arch/sh/kernel/dwarf.c | 6 ++----
> >  1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
> > index 9d209a0..e1d751a 100644
> > --- a/arch/sh/kernel/dwarf.c
> > +++ b/arch/sh/kernel/dwarf.c
> > @@ -1009,10 +1009,8 @@ static void __init dwarf_unwinder_cleanup(void)
> >  	rbtree_postorder_for_each_entry_safe(cie, next_cie, &cie_root, node)
> >  		kfree(cie);
> >  
> > -	if (dwarf_reg_pool)
> > -		mempool_destroy(dwarf_reg_pool);
> > -	if (dwarf_frame_pool)
> > -		mempool_destroy(dwarf_frame_pool);
> > +	mempool_destroy(dwarf_reg_pool);
> > +	mempool_destroy(dwarf_frame_pool);
> >  	kmem_cache_destroy(dwarf_reg_cachep);
> >  	kmem_cache_destroy(dwarf_frame_cachep);
> >  }
> > 
> 
> How do you think about to integrate this update suggestion
> into another source code repository?
> 

Your patch is fine, but you may want to send it to the maintainers 
directly to merge.

$ ./scripts/get_maintainer.pl -f arch/sh/kernel/dwarf.c
Yoshinori Sato <ysato@users.sourceforge.jp> (maintainer:SUPERH)
Rich Felker <dalias@libc.org> (maintainer:SUPERH)
linux-sh@vger.kernel.org (open list:SUPERH)
linux-kernel@vger.kernel.org (open list)
