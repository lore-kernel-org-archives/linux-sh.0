From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sun, 19 Apr 2020 20:46:39 +0000
Subject: Re: [PATCH] sh: fix build error in mm/init.c
Message-Id: <CAK7LNASzdC1ROArL0sxEE_TAw+kxher9YmDOeHi8SQ83men+Ew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200413014743.16353-1-masahiroy@kernel.org>
In-Reply-To: <20200413014743.16353-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>, Linux-sh list <linux-sh@vger.kernel.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Linus,

On Mon, Apr 13, 2020 at 10:48 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The closing parenthesis is missing.
>
> Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>



Will you pick up this directly ?
The SuperH subsystem is inactive these days.

https://lore.kernel.org/patchwork/patch/1223032/


This is easy to review, and ARCH=sh build is apparently broken.

Thanks.





> ---
>
>  arch/sh/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index b9de2d4fa57e..8d2a68aea1fc 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -412,7 +412,7 @@ int arch_add_memory(int nid, u64 start, u64 size,
>         unsigned long nr_pages = size >> PAGE_SHIFT;
>         int ret;
>
> -       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot)
> +       if (WARN_ON_ONCE(params->pgprot.pgprot != PAGE_KERNEL.pgprot))
>                 return -EINVAL;
>
>         /* We only have ZONE_NORMAL, so this is easy.. */
> --
> 2.25.1
>


-- 
Best Regards
Masahiro Yamada
