From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 Jan 2020 13:00:28 +0000
Subject: Re: [PATCH] sh: clk: Fix discarding const qualifier warning
Message-Id: <CAMuHMdULcBE1inRzTRFJeRDToT1wW+nrMEfiUs7DxMLR0tqb3w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1578399963-2229-1-git-send-email-krzk@kernel.org>
In-Reply-To: <1578399963-2229-1-git-send-email-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

Hi Krzysztof,

On Tue, Jan 7, 2020 at 1:26 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> ioreadX() accepts pointer to non-const memory.  This fixes warnings
> like:
>
>     drivers/sh/clk/cpg.c: In function ‘r8’:
>     drivers/sh/clk/cpg.c:41:17: warning: passing argument 1 of ‘ioread8’
>         discards ‘const’ qualifier from pointer target type [-Wdiscarded-qualifiers]
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Thanks for your patch!

> --- a/drivers/sh/clk/cpg.c
> +++ b/drivers/sh/clk/cpg.c
> @@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
>                 iowrite32(value, clk->mapped_reg);
>  }
>
> -static unsigned int r8(const void __iomem *addr)
> +static unsigned int r8(void __iomem *addr)
>  {
>         return ioread8(addr);
>  }

Isn't the real issue that some implementations of ioreadX() take const,
while others don't?

Even the generic ones disagree:

    include/asm-generic/io.h:static inline u8 ioread8(const volatile
void __iomem *addr)
    include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);

IMHO they all should take "const volatile void __iomem *".

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
