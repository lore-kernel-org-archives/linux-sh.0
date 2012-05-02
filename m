From: Greg KH <gregkh@linuxfoundation.org>
Date: Wed, 02 May 2012 21:22:05 +0000
Subject: Re: [PATCH 06/06] serial8250-em: Add Emma Mobile UART driver
Message-Id: <20120502212205.GA12212@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120502124642.30480.41373.sendpatchset@w520>
 <20120502124736.30480.48207.sendpatchset@w520>
 <4FA14788.6090000@windriver.com>
In-Reply-To: <4FA14788.6090000@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-serial@vger.kernel.org, horms@verge.net.au, arnd@arndb.de, linux-sh@vger.kernel.org, swarren@wwwdotorg.org, linux-kernel@vger.kernel.org, rjw@sisk.pl, lethal@linux-sh.org, olof@lixom.net, dan.j.williams@intel.com, alan@linux.intel.com

On Wed, May 02, 2012 at 10:41:12AM -0400, Paul Gortmaker wrote:
> On 12-05-02 08:47 AM, Magnus Damm wrote:
> > From: Magnus Damm <damm@opensource.se>
> > 
> > Add a platform driver for Emma Mobile 8250 hardware.
> 
> 
> [...]
> 
> > +
> > +config SERIAL_8250_EM
> > +	tristate "Support for Emma Mobile intergrated serial port"
> > +	depends on SERIAL_8250
> 
> Should we depend on arch=ARM or something similar?  Even if the
> driver is written to be arch independent, if the Emma itself is
> physically tied to ARM platforms, we probably don't need to be
> building it for sparc allyesconfig etc.

Yeah, it doesn't build on x86-64, I get the following build problems:
	ERROR: "clk_get_rate" [drivers/tty/serial/8250/8250_em.ko] undefined!
	ERROR: "clk_enable" [drivers/tty/serial/8250/8250_em.ko] undefined!
	ERROR: "clk_get" [drivers/tty/serial/8250/8250_em.ko] undefined!
	ERROR: "clk_put" [drivers/tty/serial/8250/8250_em.ko] undefined!
	ERROR: "clk_disable" [drivers/tty/serial/8250/8250_em.ko] undefined!

So it should depend on some arch that has clk at the least.

Magnus, care to redo just this one patch that fixes this up?  I've
applied the first 5 already.

thanks,

greg k-h
