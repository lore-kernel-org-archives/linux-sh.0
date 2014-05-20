From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 20 May 2014 07:48:08 +0000
Subject: Re: [PATCH 00/03] ARM: shmobile: Use shmobile_init_delay() on r8a7790
Message-Id: <CAMuHMdVHzp7sK8ufi9J35-ZaBXsvOZPrZDNcCwX8wTBSZpOpoA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140519233714.10496.31390.sendpatchset@w520>
In-Reply-To: <20140519233714.10496.31390.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, May 20, 2014 at 1:37 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> [PATCH 01/03] ARM: shmobile: Use r8a7790 DT CPU Frequency in common case
> [PATCH 02/03] ARM: shmobile: Use r8a7790 DT CPU Frequency for Lager
> [PATCH 03/03] ARM: shmobile: Remove unused r8a7790_init_early()
>
> Convert r8a7790 to rely on shmobile_init_delay() instead of using a per-SoC
> delay setup function. Very similar to the r8a7791 implementation.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
