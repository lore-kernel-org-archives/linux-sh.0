From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 13 Jul 2015 07:36:54 +0000
Subject: Re: [PATCH v3 03/04] ARM: shmobile: Remove Marzen from shmobile_defconfig
Message-Id: <CAMuHMdUDwQYhDtEfHMrRpmwXshhO0h4M9_3RKhtyr-dyH-8iNQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150713061523.25534.1744.sendpatchset@little-apple>
In-Reply-To: <20150713061523.25534.1744.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Jul 13, 2015 at 8:15 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
>
> Kill of the defconfig bits now when the marzen-reference board code is gone.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

If you also remove it from multi_v7_defconfig:

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
