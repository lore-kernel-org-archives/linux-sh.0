From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Jun 2019 07:01:40 +0000
Subject: Re: [PATCH] sh: clkfwk: don't pass void pointers to ioread*
Message-Id: <CAMuHMdVpvu+xzfh3Qee-Yz2H3YDc6CVUocKTwLTUG8gUOQPeGA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190628062524.5436-1-hch@lst.de>
In-Reply-To: <20190628062524.5436-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Christoph Hellwig <hch@lst.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>

Hi Christoph,

On Fri, Jun 28, 2019 at 8:25 AM Christoph Hellwig <hch@lst.de> wrote:
> Passing pointers with a const attr=D1=96bute to the ioread* functions
> causes a lot of compiler warnings, so remove the extra attributes.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Thanks for your patch!

> ---
>  drivers/sh/clk/cpg.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/sh/clk/cpg.c b/drivers/sh/clk/cpg.c
> index eeb028b9cdb3..4f3d99d37809 100644
> --- a/drivers/sh/clk/cpg.c
> +++ b/drivers/sh/clk/cpg.c
> @@ -36,17 +36,17 @@ static void sh_clk_write(int value, struct clk *clk)
>                 iowrite32(value, clk->mapped_reg);
>  }
>
> -static unsigned int r8(const void __iomem *addr)
> +static unsigned int r8(void __iomem *addr)

This is due to include/asm-generic/io.h and include/asm-generic/iomap.h
using different prototypes, right?

include/asm-generic/io.h:static inline u8 ioread8(const volatile void
__iomem *addr)
include/asm-generic/io.h:static inline u16 ioread16(const volatile
void __iomem *addr)
include/asm-generic/io.h:static inline u32 ioread32(const volatile
void __iomem *addr)
include/asm-generic/io.h:static inline u64 ioread64(const volatile
void __iomem *addr)

include/asm-generic/iomap.h:extern unsigned int ioread8(void __iomem *);
include/asm-generic/iomap.h:extern unsigned int ioread16(void __iomem *);
include/asm-generic/iomap.h:extern unsigned int ioread32(void __iomem *);
include/asm-generic/iomap.h:extern u64 ioread64(void __iomem *);

Wouldn't it be better to fix include/asm-generic/iomap.h and lib/iomap.c
instead?

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
