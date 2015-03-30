From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Mar 2015 09:57:04 +0000
Subject: Re: [PATCH 1/5 v2] ASoC: rsrc-card: add Renesas sampling rate convert sound card support
Message-Id: <CAMuHMdVa=KZRT294AjDZ7QZy5PFU=aKh55ookWYruf6cJhbdbg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87h9t85ry1.wl%kuninori.morimoto.gx@renesas.com>
	<87fv8s5rwt.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fv8s5rwt.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>, Linux-DT <devicetree@vger.kernel.org>, Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Das Biju <biju.das@bp.renesas.com>, Linux-sh list <linux-sh@vger.kernel.org>

On Thu, Mar 26, 2015 at 5:01 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> diff --git a/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
> new file mode 100644
> index 0000000..12e287e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/renesas,rsrc-card.txt
> @@ -0,0 +1,66 @@
> +Renesas Sampling Rate Convert Sound Card:
> +
> +Renesas Sampling Rate Convert Sound Card specifies audio DAI connections of SoC <-> codec.
> +
> +Required properties:
> +
> +- compatible                           : "renesas,rsrc-card,<board>"
> +                                         Examples with soctypes are:

board types

> +                                           - "renesas,rsrc-card,lager"
> +                                           - "renesas,rsrc-card,koelsch"

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
