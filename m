From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Fri, 21 May 2010 16:12:46 +0000
Subject: Re: bkl: Pushdowns for sound/oss ?
Message-Id: <20100521161246.GA31383@sirena.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.LFD.2.00.1005211536330.25348@localhost.localdomain> <20100521144055.GB13174@linux-mips.org>
In-Reply-To: <20100521144055.GB13174@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: John Kacur <jkacur@redhat.com>, linux-kernel@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Arnd Bergmann <arndbergmann@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org

On Fri, May 21, 2010 at 03:40:56PM +0100, Ralf Baechle wrote:
> On Fri, May 21, 2010 at 03:45:04PM +0200, John Kacur wrote:

> > sound/oss/sh_dac_audio.c

> SH3 specific.

I believe this either has been or easily can be replaced by a modern
ASoC driver and so it's probably as easy to drop it as updated it.
