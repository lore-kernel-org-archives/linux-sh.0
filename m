From: "Maciej W. Rozycki" <macro@linux-mips.org>
Date: Fri, 21 May 2010 15:34:54 +0000
Subject: Re: bkl: Pushdowns for sound/oss ?
Message-Id: <alpine.LFD.2.00.1005211613200.4344@eddie.linux-mips.org>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.LFD.2.00.1005211536330.25348@localhost.localdomain> <20100521144055.GB13174@linux-mips.org>
In-Reply-To: <20100521144055.GB13174@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: John Kacur <jkacur@redhat.com>, linux-kernel@vger.kernel.org, Frederic Weisbecker <fweisbec@gmail.com>, Arnd Bergmann <arndbergmann@googlemail.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, linux-mips@linux-mips.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Roman Zippel <zippel@linux-m68k.org>, linux-m68k@vger.kernel.org

On Fri, 21 May 2010, Ralf Baechle wrote:

> > particular in:
> > sound/oss/swarm_cs4297a.c
> 
> This one is specific to the Swarm, a MIPS-based platform indeed; I'll cc
> Maciej Rozycki who most likely is the only person on the planet knowing the
> technical details.  I don't even recall touching that file so my (C)
> header in there is a surprise :)

 You probably added a missing header inclusion or suchlike. ;)

 That's a Crystal Sound CS4297A AC'97 codec wired to a synchronous serial 
interface of the SWARM board.  It used to work with 2.4 after some tweaks 
I did back then (it broke in the little-endian mode or something like 
that), but I can't say anything about 2.6.  I think the driver should be 
dropped and the serial port in the sound mode (there's a demux to switch 
the interface's external connection between the codec and a DE-9 
connector; the serial port supports asynchronous mode as well) properly 
abstracted as a "sound card".

 There's a separate CS4297A driver already in our tree, so it should be 
used in place of the codec bits from this driver (which I believe were 
simply copied over at some point).  The rest is glue logic to set up 
serial line parameters correctly for the codec and switch the demux to the 
codec (no proper resource management is done for that though; the 
selection used to be made at the kernel build time).  This glue logic is 
all that's needed to be carried over to the new "sound card" driver.

 I have plans to do so in some indefinite future, probably when I retire 
and my grandchildren have grown up; anyone please feel free to take it 
first. ;)

  Maciej
