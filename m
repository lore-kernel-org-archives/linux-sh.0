From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2015 09:19:18 +0000
Subject: Re: [PATCH v8 03/07] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
Message-Id: <CAMuHMdWOLAWzzXBP22gkhLCMxNUbVAY4cAkjWBS+rS7xUS+0Lw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062941.24004.65819.sendpatchset@little-apple>
In-Reply-To: <20150831062941.24004.65819.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 31, 2015 at 8:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> --- 0010/arch/arm64/boot/dts/renesas/r8a7795.dtsi
> +++ work/arch/arm64/boot/dts/renesas/r8a7795.dtsi       2015-08-29 15:26:42.172366518 +0900
> @@ -239,5 +239,17 @@
>                                                      "pll3", "pll4";

The above line (remnant from "clock-output-names"?) prevents the patch from
applying without fuzz.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
