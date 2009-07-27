From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 27 Jul 2009 05:00:31 +0000
Subject: Re: Do cpu-endian MMIO accessors exist?
Message-Id: <20090727050031.GA14931@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20090721234243.1928d9e2@daedalus.pq.iki.fi> <200907221035.50025.arnd@arndb.de> <20090722094309.10b25290@lxorguk.ukuu.org.uk> <200907221544.41054.arnd@arndb.de>
In-Reply-To: <200907221544.41054.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jiri Slaby <jirislaby@gmail.com>, Pekka Paalanen <pq@iki.fi>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-sh@vger.kernel.org

On Wed, Jul 22, 2009 at 03:44:40PM +0200, Arnd Bergmann wrote:
> On Wednesday 22 July 2009, Alan Cox wrote:
> > 
> > > in this case. Also, ioread32 should actually multiplex between
> > > readl() and inl() based on the address token, as the code in
> > > lib/iomap.c does. It's probably easy enough to enable
> > > CONFIG_GENERIC_IOMAP on sh, and remove the ioread*/iowrite*
> > > macros from arch/sh/include/asm/io.h.
> > 
> > If your platform is purely MMIO based then ioread32 and readl can become
> > the same thing, which is much more efficient. Even if you have port based
> > devices that are mapped as MMIO surely its more efficient to do the
> > relevant address tweaking in the iomap not in the read ?
> 
> I did check that the architecture in question (sh) cannot do this,
> because it actually implements board specific PIO functions in
> arch/sh/boards/mach-*/io.c.
> 
> For architectures that don't need such hacks, I fully agree.
> 
SH doesn't really need it either, it is mostly legacy crap that was
commonly done for SuperIOs. I've tried to kill off most of it, and most
of the offenders now are in boards that very few people have available or
even use. We're at the point now where the platforms that are the worst
offenders can just be killed off, and the few that matter can be
converted. The generic iomap is a bit tricky given that most peripherals,
PCI I/O and mem space, etc. all fall under non-translatable sections of
the address space, despite being MMIO.
