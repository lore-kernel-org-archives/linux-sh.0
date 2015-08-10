From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Aug 2015 10:48:11 +0000
Subject: Re: [PATCH/RFC 0/2] arm64: renesas: r8a7795: Add CPG/MSTP Clock Domain
Message-Id: <CAMuHMdU94=r+GgeFcFCzA0HckoKpWWuxU=0N75rHcemMcvBsAg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1438867989-4942-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1438867989-4942-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 6, 2015 at 3:33 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> This RFC patch series adds Clock Domain support to the Clock Pulse
> Generator (CPG) Module Stop (MSTP) Clocks driver using the generic PM
> Domain on R-Car Gen3 (r8a7795), cfr. 32-bit shmobile ARM SoCs.
>
> It is based on "[PATCH 00/13 v4][RFC] arm64: Renesas Gen3 initial
> patch".
>
> Compile-tested only.

Tested on real hardware:

# cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
    domain                      status         slaves
           /device                                      runtime status
----------------------------------------------------------------------
cpg_clocks                      on
    /devices/platform/soc/e6e88000.serial               active

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
