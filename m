From: Rich Felker <dalias@libc.org>
Date: Fri, 22 Jul 2016 15:31:11 +0000
Subject: Re: [PATCH] sh-DWARF: Delete unnecessary checks before the function call "mempool_destroy"
Message-Id: <20160722153111.GJ15995@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <564985B7.3080806@users.sourceforge.net>
 <f02b6294-fcde-7977-b151-6e423bcce54c@users.sourceforge.net>
In-Reply-To: <f02b6294-fcde-7977-b151-6e423bcce54c@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>, David Rientjes <rientjes@google.com>

On Tue, Jul 19, 2016 at 11:08:24PM +0200, SF Markus Elfring wrote:
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
> Would you like to integrate this update suggestion
> into another source code repository?

Looks OK. I have it in my linux-sh tree to go upstream.

Rich
