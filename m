From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Apr 2020 07:42:01 +0000
Subject: Re: [PATCH] sh: fix build error in mm/init.c
Message-Id: <CAMuHMdWyouYStBj=kjJuMwgi1ZNQkBC8J+ums7id6t2exOj=WA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20200413014743.16353-1-masahiroy@kernel.org>
In-Reply-To: <20200413014743.16353-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, Logan Gunthorpe <logang@deltatee.com>, Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@linux.ibm.com>, Oscar Salvador <osalvador@suse.de>, Thomas Gleixner <tglx@linutronix.de>

On Mon, Apr 13, 2020 at 7:44 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> The closing parenthesis is missing.
>
> Fixes: bfeb022f8fe4 ("mm/memory_hotplug: add pgprot_t to mhp_params")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
