From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Tue, 08 Jan 2008 20:49:40 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <1199825380.6232.11.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Tue, 2008-01-08 at 00:57 -0500, Mike Frysinger wrote:
> On Friday 04 January 2008, Adrian McMenamin wrote:
> > I am struggling to get alsa (userland) to work on my Dreamcast - the
> > kernel side works nicely when using oss emulation but I cannot get the
> > pure alsa stuff - which relies on the alsa-lib - to work at all.
> >
> > I *think* this is due to not being able to configure the modules
> > automatically and I cannot figureout any way to get Busybox to do this -
> > eg neither /etc/modules or /etc/modules.conf appear to be handled.
> >
> > I suppose I could hack the init in some way to fix this, but I wonder if
> > someone here has had this problem and knows how to get round it?
> 
> you still having troubles with the userspace alsa stuff ?


Yes. I think I've more or less convinced people I am building the thing
properly now, but it still won't work as alsa.

Maybe something wrong with my driver, (though oss emulation works very
well), but nobody is being very communicative. I don't think there is
much cross compiling of alsa going on out there!

I could try to debug alsa-lib but even its creators admit it's pretty
hard to digest.

