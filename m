From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Mon, 23 Jul 2018 13:46:57 +0000
Subject: Re: [PATCH] arch/sh: use slow path for get_user_pages_fast() on SMP
Message-Id: <20180723154657.3872fa70@windsurf>
List-Id: <linux-sh.vger.kernel.org>
References: <20180615155237.8166-1-thomas.petazzoni@bootlin.com>
        <474bbdcc-d78f-faa0-b2c3-3650cc870b36@cogentembedded.com>
In-Reply-To: <474bbdcc-d78f-faa0-b2c3-3650cc870b36@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

On Fri, 15 Jun 2018 19:04:45 +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 06/15/2018 06:52 PM, Thomas Petazzoni wrote:
> 
> > The fast path of get_user_pages_fast() disables IRQs and then does:
> > 
> >  - gup_pud_range()
> >    - gup_pmd_range()
> >      - gup_pte_range()
> >        - flush_dcache_page()
> > 
> > However, flush_dcache_page() makes a smp_call_function(), and using
> > smp_call_function() when IRQs are disabled is not allowed.
> > 
> > In order to work around this problem, this commit prevents the fast
> > path from get_user_pages_fast() from being used on SMP, and directly  
>        ^^^^ of?
>    Else it sounds a bit tautological...

Yes, agreed.

I can fix that up for a v2, or perhaps such a small typo can be fixed
while applying the patches.

Could someone review and/or merge those patches ?

I sent four patches, which are still pending:

  [PATCH] arch/sh: kernel: use KERN_CONT in print_sh_insn()
  [PATCH] arch/sh: kernel: use KERN_CONT in dump_mem()
  [PATCH] arch/sh: fix SH4 flush_dcache_all() for SMP
  [PATCH] arch/sh: use slow path for get_user_pages_fast() on SMP

Note that this last one is more a workaround than a proper fix. It does
the job, but there is very likely a better solution, and I was hoping
to get some insights/suggestions.

Thanks a lot,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
