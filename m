From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 10 Aug 2015 09:24:02 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: bockw: remove "reference" device tree
Message-Id: <CAMuHMdWLmcoxE+a2rE6G0LoN0_9vwfe0MJbK5xvnu+tvywsZuQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1438965297-12888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1438965297-12888-2-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 7, 2015 at 6:34 PM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Replaced by multi-platform.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
>  arch/arm/boot/dts/Makefile                         |   3 +-
>  arch/arm/boot/dts/r8a7778-bockw-reference.dts      | 139 ---------------------
>  3 files changed, 1 insertion(+), 143 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
>
> diff --git a/Documentation/devicetree/bindings/arm/shmobile.txt b/Documentation/devicetree/bindings/arm/shmobile.txt
> index f3f96b5..f8aad0b 100644
> --- a/Documentation/devicetree/bindings/arm/shmobile.txt
> +++ b/Documentation/devicetree/bindings/arm/shmobile.txt
> @@ -39,8 +39,6 @@ Boards:
>      compatible = "renesas,armadillo800eva"
>    - BOCK-W
>      compatible = "renesas,bockw", "renesas,r8a7778"
> -  - BOCK-W - Reference Device Tree Implementation
> -    compatible = "renesas,bockw-reference", "renesas,r8a7778"

As this was the last reference to a Reference Device Tree Implementation,
please also remove the last 4 lines in this file.
You can defer that to a separate patch, though.

>    - Genmai (RTK772100BC00000BR)
>      compatible = "renesas,genmai", "renesas,r7s72100"
>    - Gose

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
