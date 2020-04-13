From: Masahiro Yamada <masahiroy@kernel.org>
Date: Mon, 13 Apr 2020 16:04:23 +0000
Subject: Re: [PATCH] sh: fix build error in mm/init.c
Message-Id: <CAK7LNAQmbFOtsBAO2y_s9_y90UGCjXWrd-Es9mOUjgrfCELqmA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200413014743.16353-1-masahiroy@kernel.org> <ef8addd0-81bb-249f-7d8f-dfa7fc032085@deltatee.com>
In-Reply-To: <ef8addd0-81bb-249f-7d8f-dfa7fc032085@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Apr 14, 2020 at 12:43 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2020-04-12 7:47 p.m., Masahiro Yamada wrote:
> > The closing parenthesis is missing.
> >
> > Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
>
> Oh, oops, I thought I compile checked all the arches. Must have been a
> last minute change. I'm also surprised the kbuild robot didn't catch this.
>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>
> Andrew, can this be squashed into the existing patch?


The offending commit is already in Linus' tree.

I was also surprised that no bot or human
complained about this breakage before it was merged.



-- 
Best Regards
Masahiro Yamada
