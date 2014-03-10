From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Mar 2014 12:57:23 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <2488692.p5nEA6pWSY@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon>
In-Reply-To: <5448979.WQPtOb56tW@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>

On Monday 10 March 2014 12:59:03 Laurent Pinchart wrote:
> 
> The SoC includes 8 serial ports. They are all disabled in the SoC .dtsi, and 
> enabled selectively by board DT files. As not all serial ports are available 
> on all boards, the question was whether to add aliases for all ports (in the 
> .dtsi in this case) like
> 
>          serial0 = &scif0;
>          serial1 = &scif1;
>          serial2 = &scif2;
>          serial3 = &scif3;
>          serial4 = &scif4;
>          serial5 = &scif5;
>          serial6 = &scif6;
>          serial7 = &scif7;
> 
> or to just add aliases for the enabled ports (in the board DT file) like
> 
>          serial0 = &scif2;
>          serial1 = &scif3;
> 
> Note the numbering in the latter case: as the board doesn't use serial ports 0 
> and 1, hardware ports 2 and 3 become logical ports 0 and 1.
> 
> I considered that having Linux create ttySC0 and ttySC1 devices for the first 
> two ports of the board, regardless of which hardware ports are used, is 
> simpler from a user point of view (it allows sharing the same inittab settings 
> for the console serial port across several boards for instance). I'd 
> appreciate feedback on that.

I think the traditional interpretation is that we want to use the aliases
to reflect the device names in the OS. This however comes back to the more
general issue of serial port device naming: Linux traditionally uses separate
names per driver (e.g. ttySC0 instead of ttyS0).

There has been discussion in the past about changing this to let all drivers
use the same namespace, but it's not yet clear to me how we'd do this in a
100% backwards compatible way. Maybe it's best left to udev to figure out
the driver independent name, but then we definitely should use the alias
for that name.

	Arnd
