From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 19 Apr 2020 20:49:34 +0000
Subject: Re: [PATCH] sh: fix build error in mm/init.c
Message-Id: <CAK7LNASnovOtP99fuxcoTknj1g1Uoa8U4YopRQfdFYjC998B=A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200413014743.16353-1-masahiroy@kernel.org> <CAK7LNASzdC1ROArL0sxEE_TAw+kxher9YmDOeHi8SQ83men+Ew@mail.gmail.com>
In-Reply-To: <CAK7LNASzdC1ROArL0sxEE_TAw+kxher9YmDOeHi8SQ83men+Ew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Apr 20, 2020 at 5:46 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Linus,
>
> On Mon, Apr 13, 2020 at 10:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The closing parenthesis is missing.
> >
> > Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
>
>
> Will you pick up this directly ?
> The SuperH subsystem is inactive these days.
>
> https://lore.kernel.org/patchwork/patch/1223032/
>
>
> This is easy to review, and ARCH=sh build is apparently broken.
>
> Thanks.


Sorry, I take it back.

Guenter's one is already queued up in linux-next.

Somebody will fix it eventually.




-- 
Best Regards
Masahiro Yamada
