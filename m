From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Date: Fri, 15 Jun 2018 19:27:26 +0000
Subject: Re: [PATCH] arch/sh: use slow path for get_user_pages_fast() on SMP
Message-Id: <20180615212726.17d8ffe5@windsurf>
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

I re-read again my sentence, and I believe it's correct and it has the
meaning I intended to give. Of course, I'm not a native english
speaker, so I might be wrong on this :-)

I'm actually more interested in hearing whether there is a better
solution to this problem. This patch submission is really a very
proposal, and I'm hoping to get some better suggestions on how to
approach the problem.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
