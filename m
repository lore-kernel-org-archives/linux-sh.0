From: Ralf Baechle <ralf@linux-mips.org>
Date: Fri, 21 May 2010 14:40:56 +0000
Subject: Re: bkl: Pushdowns for sound/oss ?
Message-Id: <20100521144055.GB13174@linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.LFD.2.00.1005211536330.25348@localhost.localdomain>
In-Reply-To: <alpine.LFD.2.00.1005211536330.25348@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Kacur <jkacur@redhat.com>
Cc: linux-kernel@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Arnd Bergmann <arndbergmann@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "Maciej W. Rozycki" <macro@linux-mips.org>, linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org

On Fri, May 21, 2010 at 03:45:04PM +0200, John Kacur wrote:

> particular in:
> sound/oss/swarm_cs4297a.c

This one is specific to the Swarm, a MIPS-based platform indeed; I'll cc
Maciej Rozycki who most likely is the only person on the planet knowing the
technical details.  I don't even recall touching that file so my (C)
header in there is a surprise :)

Stiching up the build problems in that file.

> sound/oss/msnd_pinnacle.c

Random weirdo ISA sound card.  Probably only ever tested on x86 and will
have the chances

> sound/oss/sh_dac_audio.c

SH3 specific.

> sound/oss/vwsnd.c

Belongs to the x86-based first generation of SGI visual workstations.

> sound/oss/dmasound/dmasound_core.c
> sound/oss/dmasound/dmasound_core.c

Motorola 68k-specific.  Adding 68k maintainers to cc list.

> when I noticed they were including asm files from mips. I went so far as 
> to compile my own mips tool chain, but I wasn't able to compile the above.
> Being oss sound, I was wondering if these are still maintained or are 
> marked for removal some time in the future.
> 
> If there is merely a problem with my toolchain, then that can be fixed, 
> but there is no point in wasting time with these if no-one uses them.

More a problem in not reading the research properly :)

  Ralf
