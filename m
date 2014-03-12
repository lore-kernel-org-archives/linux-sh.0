From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 12 Mar 2014 10:40:48 +0000
Subject: Re: [RFC] Serial port aliases in DT
Message-Id: <9554680.Wp7ectfBdb@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <5448979.WQPtOb56tW@avalon> <1551855.ylN84WQiIN@avalon> <20140311124622.GA30394@katana>
In-Reply-To: <20140311124622.GA30394@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: devicetree@vger.kernel.org, linux-sh@vger.kernel.org

Hi Wolfram,

On Tuesday 11 March 2014 13:46:22 Wolfram Sang wrote:
> On Tue, Mar 11, 2014 at 12:56:50PM +0100, Laurent Pinchart wrote:
> > On Monday 10 March 2014 13:38:37 Wolfram Sang wrote:
> > > > I've recently reviewed a patch adding serial port aliases to the
> > > > device tree and would like to pick your brains about a disagreement I
> > > > had with the developer.
> > > 
> > > And here is the developer :)
> > > 
> > > > The SoC includes 8 serial ports. They are all disabled in the SoC
> > > > .dtsi, and enabled selectively by board DT files. As not all serial
> > > > ports are available on all boards, the question was whether to add
> > > > aliases for all ports (in the .dtsi in this case) like
> > > > 
> > > >          serial0 = &scif0;
> > > >          serial1 = &scif1;
> > > >          serial2 = &scif2;
> > > >          serial3 = &scif3;
> > > >          serial4 = &scif4;
> > > >          serial5 = &scif5;
> > > >          serial6 = &scif6;
> > > >          serial7 = &scif7;
> > > > 
> > > > or to just add aliases for the enabled ports (in the board DT file)
> > > > like
> > > > 
> > > >          serial0 = &scif2;
> > > >          serial1 = &scif3;
> > > > 
> > > > Note the numbering in the latter case: as the board doesn't use serial
> > > > ports 0 and 1, hardware ports 2 and 3 become logical ports 0 and 1.
> > > > 
> > > > I considered that having Linux create ttySC0 and ttySC1 devices for
> > > > the first two ports of the board, regardless of which hardware ports
> > > > are used, is simpler from a user point of view (it allows sharing the
> > > > same inittab settings for the console serial port across several
> > > > boards for instance). I'd appreciate feedback on that.
> > > 
> > > First, I don't think this is restricted to serial ports but how to use
> > > aliases in general. We may decide this or that way, yet we should do it
> > > consistently. Using aliases this way for serial ports and that way for
> > > I2C busses will create a mess.
> > > And currently, I only know of 1:1 mappings for I2C/SPI. So, on the same
> > > board, you'll need to open /dev/i2c-2, not /dev/i2c-0.
> > > 
> > > From my experience, things get complicated when stuff gets added and the
> > > 
> > > numbers go wild:
> > >           serial0 = &scif2;
> > >           serial1 = &scif3;
> > >           serial2 = &scif6;
> > >           serial3 = &scif0;
> > >           serial4 = &scif7;
> > > 
> > > When debugging here, trying to remember which port to open for the
> > > terminal, and which number to scan for in the schematics is error-prone
> > > and a PITA.
> 
> No comments on those? Are the experiences from the stable ethernet
> naming which would speak for/against those arguments?

I'm waiting for others to comment :-) I agree that you have a point though.

> > > Yeah, the drawback is that the console might be at different places
> > > across boards. I suggest to update inittab at runtime anyhow, since not
> > > only the number but also the naming often changes (ttyXYZ to ttyABC).
> > 
> > Just out of curiosity (as I could use it), do you have a sample
> > implementation of dynamic inittab updates ?
> 
> Sure. Can be optimized and improved, but does its job (for an initramfs
> at least, where the default 'ttyS0' keeps constant):
> 
> == S02inittab
> 
> #!/bin/sh
> #
> # Update inittab at runtime - by Wolfram Sang, WTFPLv2
> 
> case "$1" in
>   start)
> 	echo "Adapting inittab to kernel console"
> 	l=$(cat /proc/cmdline)
> 	l=${l##*console=}
> 	l=${l%%,*}
> 	sed -i s/ttyS0/$l/g /etc/inittab
> 	kill -s SIGHUP 1
> 	;;
>   *)
> 	echo "Usage: $0 {start}"
> 	exit 1
> esac
> 
> exit $?
> 
> =
Thank you.

Maybe we could also let udev create a link to the console serial port.

-- 
Regards,

Laurent Pinchart
