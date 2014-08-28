From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 28 Aug 2014 11:57:23 +0000
Subject: Re: [PATCH 00/05] ARM: shmobile: r8a7740 and Armadillo cleanup
Message-Id: <CAMuHMdVGNELv6+crzvf2Je66Vfwhc=Q0sgT-C5n=bJ73TQueMA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140828033443.18867.55162.sendpatchset@w520>
In-Reply-To: <20140828033443.18867.55162.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Thu, Aug 28, 2014 at 5:34 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> ARM: shmobile: r8a7740 and Armadillo cleanup
>
> [PATCH 01/05] ARM: shmobile: armadillo800eva: Sync DTS
> [PATCH 02/05] ARM: shmobile: armadillo800eva: Build DTS for multiplatform
> [PATCH 03/05] ARM: shmobile: r8a7740: Add restart callback
> [PATCH 04/05] ARM: shmobile: armadillo800eva reference: Remove C board code
> [PATCH 05/05] ARM: shmobile: armadillo800eva reference: Remove DTS
>
> This patch series cleans up the Armadillo board support by removing
> the DT reference implementation. To not lose functionality the reset
> handling code is moved from (incorrect) board specific location to
> the r8a7740 SoC code.
>
> With this patch series applied the "DT Reference" case is now replaced
> by r8a7740 Multiplatform using the same DTS/DTB as the r8a7740 legacy
> case.
>
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

Thanks, works fine!

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
