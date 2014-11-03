From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Nov 2014 10:19:59 +0000
Subject: Re: [PATCH 03/12] ARM: shmobile: r8a7791: Add Audio DMAC devices to DT
Message-Id: <CAMuHMdVJHuM_jccydmZ3dm3E29bZsZoOZ_D8Yvb2Vt9tC150mw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wq7g1xcl.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87wq7g1xcl.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 31, 2014 at 9:01 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
> --- a/arch/arm/boot/dts/r8a7791.dtsi
> +++ b/arch/arm/boot/dts/r8a7791.dtsi
> @@ -301,6 +301,62 @@
>                 dma-channels = <15>;
>         };
>
> +       audma0: dma-contorller@ec700000 {

dma-controller

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
