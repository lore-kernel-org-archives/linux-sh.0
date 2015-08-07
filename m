From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 07 Aug 2015 07:19:39 +0000
Subject: Re: [PATCH 16/16 v5][RFC] Local: arm64: renesas: add SalvatorX board support on DTS
Message-Id: <CAMuHMdXAS45q6EqU2OXn9tfu06H5d-RiiQo516Vw_S=jXByWJQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhdndbz9.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87lhdndbz9.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Aug 7, 2015 at 5:20 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
> @@ -0,0 +1,36 @@

> +/ {
> +       model = "Renesas SalvatorX board based on r8a7795";
> +       compatible = "renesas,salvatorx", "renesas,r8a7795";

Please document "renesas,salvatorx".

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
