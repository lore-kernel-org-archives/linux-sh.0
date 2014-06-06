From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 06 Jun 2014 06:42:12 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <CAMuHMdX-M753qtpTGjf-neaK=6AGYZJVuweUf4jR_z5KCe=8nA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>
	<20140603214226.GA2520@sirena.org.uk>
	<87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>
	<538EE0BE.5030304@codethink.co.uk>
	<87zjhrj3gc.wl%kuninori.morimoto.gx@renesas.com>
	<539033ED.4010604@codethink.co.uk>
	<87fvjjitqm.wl%kuninori.morimoto.gx@renesas.com>
	<53903DCF.1050604@codethink.co.uk>
	<539048D3.6060306@codethink.co.uk>
	<87iooebn1d.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87iooebn1d.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>, Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Morimoto-san,

On Fri, Jun 6, 2014 at 7:54 AM, Kuninori Morimoto
<kuninori.morimoto.gx@renesas.com> wrote:
>> >>   - SSI(ALL) is called via pm_runtime_xxx() from sound driver
>> >>   - SRC(ALL) is called as parent clock of SRCn clocks
>> >
>> > See, this is why I /hate/ the implicit clock management. This is
>> > another case where we're getting bitten by it.
>
> I troubled about this ALL bit too,
> then, it become current style.
>
> One reason was that
> this driver is supporting Gen1 sound too.
> But, this SRC(ALL) didn't exist on Gen1..

This is not the only module that has a clock in R-Car Gen2, but not in Gen1.
The same is true for GPIO. There may be others...

When adding a device node to the DTS, always make sure to double check
if it has a clock, and add it.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
