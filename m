From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 22 Jul 2009 13:44:40 +0000
Subject: Re: Do cpu-endian MMIO accessors exist?
Message-Id: <200907221544.41054.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <20090721234243.1928d9e2@daedalus.pq.iki.fi> <200907221035.50025.arnd@arndb.de> <20090722094309.10b25290@lxorguk.ukuu.org.uk>
In-Reply-To: <20090722094309.10b25290@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jiri Slaby <jirislaby@gmail.com>, Pekka Paalanen <pq@iki.fi>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, lethal@linux-sh.org, linux-sh@vger.kernel.org

On Wednesday 22 July 2009, Alan Cox wrote:
> 
> > in this case. Also, ioread32 should actually multiplex between
> > readl() and inl() based on the address token, as the code in
> > lib/iomap.c does. It's probably easy enough to enable
> > CONFIG_GENERIC_IOMAP on sh, and remove the ioread*/iowrite*
> > macros from arch/sh/include/asm/io.h.
> 
> If your platform is purely MMIO based then ioread32 and readl can become
> the same thing, which is much more efficient. Even if you have port based
> devices that are mapped as MMIO surely its more efficient to do the
> relevant address tweaking in the iomap not in the read ?

I did check that the architecture in question (sh) cannot do this,
because it actually implements board specific PIO functions in
arch/sh/boards/mach-*/io.c.

For architectures that don't need such hacks, I fully agree.

	Arnd <><
