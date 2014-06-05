From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 05 Jun 2014 08:15:15 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: EMEV2 init delay update
Message-Id: <CAMuHMdXf5TkNDQ1dU8CzF2xJ3i=azOZZRosQ-cozKQtbpnetmA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140605053149.19066.90593.sendpatchset@w520>
In-Reply-To: <20140605053149.19066.90593.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Jun 5, 2014 at 7:31 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: EMEV2 init delay update
>
> [PATCH 01/03] ARM: shmobile: Update EMEV2 DTS to include CPU frequency
> [PATCH 02/03] ARM: shmobile: Use shmobile_init_delay() on EMEV2
> [PATCH 03/03] ARM: shmobile: Get rid of redundant EMEV2 mach callbacks
>
> These patches clean up the EMEV2 SoC code. The CPU Frequency is put into
> DTS, code is adjusted to read out the frequency from DTS, and the EMEV2
> SoC callbacks are cleaned up slightly.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, looks fine to me.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
