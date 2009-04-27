From: Pavel Machek <pavel@ucw.cz>
Date: Mon, 27 Apr 2009 18:03:32 +0000
Subject: Re: [RFC][patch] filesystem: Vmufat filesystem, version 4
Message-Id: <20090427180332.GA19265@elf.ucw.cz>
List-Id: <linux-sh.vger.kernel.org>
References: <1239654768.6542.10.camel@localhost.localdomain> <20090424221455.GB5342@elf.ucw.cz> <200904271356.21684.vapier@gentoo.org>
In-Reply-To: <200904271356.21684.vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Adrian McMenamin <adrian@newgolddream.dyndns.info>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-sh <linux-sh@vger.kernel.org>

On Mon 2009-04-27 13:56:20, Mike Frysinger wrote:
> On Friday 24 April 2009 18:14:55 Pavel Machek wrote:
> > On Mon 2009-04-13 21:32:48, Adrian McMenamin wrote:
> > > --- /dev/null
> > > +++ b/fs/vmufat/Kconfig
> > > @@ -0,0 +1,14 @@
> > > +config VMUFAT_FS
> > > +	tristate "Dreamcast VMU FAT filesystem"
> > > +	depends on BLOCK
> > > +	help
> > > +	  This implements the simple FAT type filesystem found on SEGA
> > > +	  Dreamcast visual memory units.
> > > +
> > > +	  Dreamcast users who want to mount their VMUs to view the native
> > > +	  filesystem will say 'Y' here. The filesystem is hardware independent
> > > +	  but is not recommended for any serious use in other circumstances, so
> > > +	  just about everyone else should say 'N'.
> > > +
> > > +	  To compile this as a module say 'M' here. The module will be called
> > > +	  vmufat
> >
> > "vmufat.ko." ?
> 
> no, the standard is to name it without extension.  there should be a period 
> there though as it's the end of the sentence ...

Ok, add that period at end of sentence, I stand corrected.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
