From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 13 Jun 2018 14:31:25 +0000
Subject: Re: [PATCH] sh: remove no-op macro VMLINUX_SYMBOL()
Message-Id: <CAK7LNAQjBYQ1YKGnFodng8uibRDuJ+D9iD4OLQ-qE_8xYOv6Ww@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1525852402-29269-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1525852402-29269-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>
Cc: linux-arch <linux-arch@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

2018-05-09 16:53 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> VMLINUX_SYMBOL() is no-op unless CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
> is defined.  It has ever been selected only by BLACKFIN and METAG.
> VMLINUX_SYMBOL() is unneeded for SuperH-specific code.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---



For information for SH maintainers just in case.

I already picked up this patch to my Kbuild tree.

Thanks.



>  arch/sh/include/asm/vmlinux.lds.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/sh/include/asm/vmlinux.lds.h b/arch/sh/include/asm/vmlinux.lds.h
> index f312813..9929556 100644
> --- a/arch/sh/include/asm/vmlinux.lds.h
> +++ b/arch/sh/include/asm/vmlinux.lds.h
> @@ -7,9 +7,9 @@
>  #ifdef CONFIG_DWARF_UNWINDER
>  #define DWARF_EH_FRAME                                                 \
>         .eh_frame : AT(ADDR(.eh_frame) - LOAD_OFFSET) {                 \
> -                 VMLINUX_SYMBOL(__start_eh_frame) = .;                 \
> +                 __start_eh_frame = .;                                 \
>                   *(.eh_frame)                                          \
> -                 VMLINUX_SYMBOL(__stop_eh_frame) = .;                  \
> +                 __stop_eh_frame = .;                                  \
>         }
>  #else
>  #define DWARF_EH_FRAME
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
