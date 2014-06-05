From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Jun 2014 08:17:55 +0000
Subject: Re: [PATCH] ARM: shmobile: Lager memory map update
Message-Id: <CAMuHMdWBDdCDqoKAgzPyNVnGtV0jomeN52uXu-JPABkHm3o-ew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140605060601.12351.26135.sendpatchset@w520>
In-Reply-To: <20140605060601.12351.26135.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Jun 5, 2014 at 8:06 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Update the Lager DTS to make use of the new unified legacy
> memory map where the legacy window on Lager and Koelsch
> have the same size.
>
> After update the Lager board has the following map:
> Bank0: 1GiB RAM (Legacy 32-bit: 0x40000000->0x7fffffff)
> Bank1: 3GiB RAM (LPAE area: 0x140000000->0x1ffffffff)
>
> Before the update the old map looked like this:
> Bank0: 2GiB RAM (Legacy 32-bit: 0x40000000->0xbfffffff)
> Bank1: 2GiB RAM (LPAE area: 0x180000000->0x1ffffffff)
>
> Tested with and without LPAE on r8a7790 Lager.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

I think this lacks an explanation why you want this...

In general, less highmem is better ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
