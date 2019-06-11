From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Jun 2019 08:25:46 +0000
Subject: Re: [PATCH 07/15] binfmt_flat: use __be32 for the on-disk format
Message-Id: <CAMuHMdXvbA=+=AQ6fYV2zRUc6CWtZ_GzEN7D5b8QNYwLEd6OjA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20190610212015.9157-1-hch@lst.de>
 <20190610212015.9157-8-hch@lst.de>
In-Reply-To: <20190610212015.9157-8-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: "moderated list:H8/300 ARCHITECTURE" <uclinux-h8-devel@lists.sourceforge.jp>, linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>, linux-c6x-dev@linux-c6x.org, Linux-sh list <linux-sh@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-riscv@lists.infradead.org, Greg Ungerer <gerg@linux-m68k.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

Hi Christoph,

On Mon, Jun 10, 2019 at 11:21 PM Christoph Hellwig <hch@lst.de> wrote:
> So far binfmt_flat has onl been supported on 32-bit platforms, so the
> variable size of the fields didn't matter.  But the upcoming RISC-V
> nommu port supports 64-bit CPUs, and we now have a conflict between
> the elf2flt creation tool that always uses 32-bit fields and the kernel
> that uses (unsigned) long field.  Switch to the userspace view as the
> rest of the binfmt_flat format is completely architecture neutral,
> and binfmt_flat isn't the right binary format for huge executables to
> start with.
>
> While we're at it also ensure these fields are using __be types as
> they big endian and are byteswapped when loaded.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

> --- a/include/linux/flat.h
> +++ b/include/linux/flat.h

> @@ -67,19 +67,19 @@ struct flat_hdr {
>  #define OLD_FLAT_RELOC_TYPE_BSS                2
>
>  typedef union {
> -       unsigned long   value;
> +       u32             value;
>         struct {
>  # if defined(mc68000) && !defined(CONFIG_COLDFIRE)
> -               signed long offset : 30;
> -               unsigned long type : 2;
> +               s32     offset : 30;
> +               u32     type : 2;
>  #      define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
>  # elif defined(__BIG_ENDIAN_BITFIELD)
> -               unsigned long type : 2;
> -               signed long offset : 30;
> +               u32     type : 2;
> +               s32     offset : 30;
>  #      define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */
>  # elif defined(__LITTLE_ENDIAN_BITFIELD)
> -               signed long offset : 30;
> -               unsigned long type : 2;
> +               s32     offset : 30;
> +               u32     type : 2;
>  #      define OLD_FLAT_FLAG_RAM    0x1 /* load program entirely into RAM */

The definitions of OLD_FLAT_FLAG_RAM are identical, so could be
factored out.
However, they appear to be unused.

>  # else
>  #      error "Unknown bitfield order for flat files."

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
