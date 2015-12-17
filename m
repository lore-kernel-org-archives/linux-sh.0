From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 17 Dec 2015 08:06:11 +0000
Subject: Re: [PATCH/RFC 02/03] ARM: shmobile: r8a7795: Hack up SYS-DMAC0 support
Message-Id: <CAMuHMdVyT6eFM0iQvY7VBN5ruUbh0MVqd0NZ6T8dMu5dEyyogw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151215132652.15356.75661.sendpatchset@little-apple>
In-Reply-To: <20151215132652.15356.75661.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Thu, Dec 17, 2015 at 1:35 AM, Simon Horman <horms@verge.net.au> wrote:
>> > +                       interrupts =    <0 119 IRQ_TYPE_LEVEL_HIGH
>>
>> GIC_SPI
>>
>> (we should fix up all interrupts properties in R-Car Gen2 DTSes, too)
>
> Can I clarify that the idea is to substitute the first cell of the
> value of interrupt properties as follows:
> * s/0/GIC_SPI/
> * s/1/GIC_PPI/

Indeed.

> If so, I can add this to my (long) integration todo list.
> I'm also quite happy for someone else to handle this.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
