From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Aug 2015 16:03:20 +0000
Subject: Re: [PATCH v8 00/07] Renesas R-Car H3 (r8a7795) integration patches V8
Message-Id: <CAMuHMdUiUo-Qwz+T0yzwAuh1UQVFCHF7O9TYC8Jx6sSkzQCE_A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062907.24004.79614.sendpatchset@little-apple>
In-Reply-To: <20150831062907.24004.79614.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Magnus,

On Mon, Aug 31, 2015 at 8:29 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> Renesas R-Car H3 (r8a7795) integration patches V8
>
> [PATCH v8 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
> [PATCH v8 02/07] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
> [PATCH v8 03/07] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
> [PATCH v8 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
> [PATCH v8 05/07] arm64: renesas: r8a7795: enable PFC
> [PATCH v8 06/07] arm64: renesas: add Salvator-X board support on DTS
> [PATCH v8 07/07] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC
>
> This is V8 of the R-Car H3 SoC support which contains a simplified
> series of initial r8a7795 support including:
> - Single CPU core, Arch timer, GIC
> - CPG and MSTP
> - r8a7795 SCIF0->SCIF6
> - PFC
> - Salvator-X DEBUG0 and DEBUG1 serial ports.

> Regarding dependencies, this V8 integration series depends on the following:
>
> CPG:
> [PATCH v4 00/05] Renesas R-Car Gen3 CPG support V4
>
> PFC:
> [PATCH 0/2][RFC] pinctrl: sh-pfc: r8a7795 support
>
> SCIF:
> [PATCH] serial: sh-sci: Add device tree support for r8a7795

Thanks!

I've pushed your series, its dependencies (cpg upgraded to v5), and everything
merged together[*] to a few topic branches in the renesas-drivers repository:

  topic/gen3-integration-v8
  topic/gen3-cpg-v5
  topic/r8a7795-pfc
  topic/r8a7795-scif
  topic/gen3-latest [*]

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
