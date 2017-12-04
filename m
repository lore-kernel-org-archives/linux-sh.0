From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 04 Dec 2017 14:58:42 +0000
Subject: Re: [PATCH] arch/sh: fix Ethernet clock for SH7786
Message-Id: <CAMuHMdUNur9AnB6eWsixNhrpwUs2Sf_Dunhr4qXvC7htn-UtrA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20171204143049.20244-1-thomas.petazzoni@free-electrons.com>
In-Reply-To: <20171204143049.20244-1-thomas.petazzoni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Thomas,

On Mon, Dec 4, 2017 at 3:30 PM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> The sh_eth driver (used for the Ethernet controller on SH7786) uses
> devm_clk_get(&pdev->dev, NULL) to get its clock. It means that con_id
> = NULL, and therefore a clock lookup made on the con_id doesn't work.
>
> In order to make sure that the sh_eth driver is able to find its clock
> on SH7786, we switch from using a con_id to a dev_id in the clock
> lookup table for this SoC.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

The clock is optional, right? Do you need it? It's "needed" for WoL only,
but that dependency is planned to be removed, cfr. "sh_eth: Remove obsolete
explicit clock handling for WoL".

Regardless:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
