From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 04 Jun 2014 09:33:14 +0000
Subject: Re: [alsa-devel] r8a7790 only has audio when clock is forced on
Message-Id: <CAMuHMdUKL7T0xmwz_Ji+ycLm3=S75V7tJD1wkB_wrud4gzLPBA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <538E0487.1010700@codethink.co.uk>
	<20140603214226.GA2520@sirena.org.uk>
	<87egz5ldtm.wl%kuninori.morimoto.gx@renesas.com>
	<538EE41D.3000500@codethink.co.uk>
In-Reply-To: <538EE41D.3000500@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Violeta Menendez Gonzalez <violeta.menendez@codethink.co.uk>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Mark Brown <broonie@kernel.org>, linux-kernel@lists.codethink.co.uk, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Linux-sh list <linux-sh@vger.kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>

Hi Violeta,

On Wed, Jun 4, 2014 at 11:17 AM, Violeta Menendez Gonzalez
<violeta.menendez@codethink.co.uk> wrote:
>> - Which kernel are you using ?
>
> 3.15-rc1
>
>> - Does your kernel booted from legacy code (= using board-lager.c)
>>    or from DT code (= using board-lager-referenct.c) ?
>>
> DT code

Does applying commit 3c90c55dcde745bed81f6447f24ba96bda43d984
("drivers: sh: compile drivers/sh/pm_runtime.c if ARCH_SHMOBILE_MULTI")
help?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
