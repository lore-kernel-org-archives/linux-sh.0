From: Matt Fleming <matt@codeblueprint.co.uk>
Date: Mon, 12 Oct 2015 08:56:16 +0000
Subject: Re: [PATCH] sh: add copy_user_page() alias for __copy_user()
Message-Id: <20151012085616.GA2579@codeblueprint.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1442958411-4271-1-git-send-email-ross.zwisler@linux.intel.com>
 <20151008230734.GB19399@linux.intel.com>
In-Reply-To: <20151008230734.GB19399@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Ross Zwisler <ross.zwisler@linux.intel.com>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Matthew Wilcox <willy@linux.intel.com>, linux-fsdevel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>

On Thu, 08 Oct, at 05:07:34PM, Ross Zwisler wrote:
> On Tue, Sep 22, 2015 at 03:46:51PM -0600, Ross Zwisler wrote:
> > copy_user_page() is needed by DAX.  Without this we get a compile error
> > for DAX on SH:
> > 
> > fs/dax.c:280:2: error: implicit declaration of function ‘copy_user_page’
> > [-Werror=implicit-function-declaration]
> >   copy_user_page(vto, (void __force *)vfrom, vaddr, to);
> >     ^
> > 
> > This was done with a random config that happened to include DAX support.
> > 
> > This patch has only been compile tested.
> > 
> > Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > Apologies for the resend, I wanted to add some more recipients.
> > ---
> >  arch/sh/include/asm/page.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/sh/include/asm/page.h b/arch/sh/include/asm/page.h
> > index fe20d14..ceb5201 100644
> > --- a/arch/sh/include/asm/page.h
> > +++ b/arch/sh/include/asm/page.h
> > @@ -59,6 +59,7 @@ pages_do_alias(unsigned long addr1, unsigned long addr2)
> >  
> >  #define clear_page(page)	memset((void *)(page), 0, PAGE_SIZE)
> >  extern void copy_page(void *to, void *from);
> > +#define copy_user_page(to, from, vaddr, pg)  __copy_user(to, from, PAGE_SIZE)
> >  
> >  struct page;
> >  struct vm_area_struct;
> 
> Ping?

Your best bet is probably to Cc Andrew (now Cc'd).

Andrew, original patch is here,

  https://lkml.kernel.org/r/1442958411-4271-1-git-send-email-ross.zwisler@linux.intel.com

-- 
Matt Fleming, Intel Open Source Technology Center
