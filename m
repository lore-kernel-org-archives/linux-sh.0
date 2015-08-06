From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 06 Aug 2015 10:15:08 +0000
Subject: Re: [PATCH 13/13 v4][RFC] Local: arm64: renesas: add SalvatorX board support on DTS
Message-Id: <CAMuHMdVZs-ZUe85y8j4U5mj66JEEhTGKbbQ46AVwHAtyBa=HUQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egjgyh6d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87egjgyh6d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Aug 6, 2015 at 10:09 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
> --- /dev/null
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvatorx.dts
> @@ -0,0 +1,36 @@

> +       aliases {
> +               serial0 = &scif2;

Mapping 0 to 2?

> +       chosen {
> +               bootargs = "console=ttySC0,115200";

You shouldn't need the above line if stdout-path is present.

> +               stdout-path = &scif2;

Furthemore, quoting Mark Rutland
(http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/324232.html):

| I'd strongly recommend that you also pass the configuration explicitly
| here, so as to avoid nasty surprises. For that you can either use a path
| or an alias, depending on what the rest of your DT looks like:
|
|        stdout-path = "/path/to/scifa0:115200n8"
|
|        stdout-path = "serial0:115200n8"

I haven't tried that yet, but we may want to start doing The Right Thing (tm)
with Gen3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
