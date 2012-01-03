From: Oleg Endo <oleg.endo@t-online.de>
Date: Tue, 03 Jan 2012 02:38:48 +0000
Subject: Re: Dreamcast build broken
Message-Id: <1325558328.18753.807.camel@yam-132-YW-E178-FTW>
List-Id: <linux-sh.vger.kernel.org>
References: <4EC81660.3010109@gmail.com>
In-Reply-To: <4EC81660.3010109@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-sh@vger.kernel.org

On Mon, 2012-01-02 at 22:57 +0100, Paul Cercueil wrote:
> Le 17/12/2011 11:24, Adrian McMenamin a écrit :
> > On 25 November 2011 16:24, Paul Cercueil<pcercuei@gmail.com>  wrote:
> >> Le 24/11/2011 08:29, Paul Mundt a écrit :
> >>>
> >
> >> However, starting from commit 37b7a97884ba64bf7d403351ac2a9476ab4f1bba and
> >> up to the latest vanilla Linux 3.1,
> >> the vmlinux binary won't start on my dreamcast or on the lxdream emulator.
> >>
> > No output at all?
> 
> Hi,
> Sorry for the late reply.
> 
> That's right, there is no output at all. Perhaps the binary starts 
> correctly but then it crashes before the activation of the framebuffer.
> 
> I am facing another issue about the dreamcast build: the entry point of 
> the kernel is set to 0x8c002000, which does not appear to be correct. 
> When booting a CD, the bootloader (contained inside the IP.bin file) 
> loads the main executable at 0x8c010000.
> 

This is not entirely correct.  IP.BIN code does (normally) does not load
the main executable.  When the original SEGA BootROM boots from a CD-ROM
(not GD-ROM), it loads the "hidden" IP.BIN at 0x8C008000 and the
"1ST_READ.BIN" (typical name, could be different) to 0x8C010000. After
that it will start executing code contained in IP.BIN, which can perform
additional startup things.  One common technique for bootable CD-ROMs
was to put the 1ST_READ.BIN descrambling code into IP.BIN.

For more details see http://mc.pp.se/dc/ip.bin.html


> On a side note, the kernel inside the old DCLinux (based on Linux 2.4) 
> has an entry point set to 0x8c012000.

Could make sense if there are some additional things happening in
IP.BIN.  However, setting the entry point to 0x8C002000 seems incorrect
indeed, as this conflicts with the memory area that is used by the
resident GDC driver code of the original SEGA BootROM.  With a custom
IP.BIN it _is_ possible to copy the already loaded 1ST_READ.BIN to a
lower memory address than 0x8C010000 (e.g. 0x8C002000), but it will
render the resident BootROM code useless.  If the resident BootROM
functions are not used by the software being executed there will be no
further consequences and some additional KBytes of RAM available ;)

Cheers,
Oleg

