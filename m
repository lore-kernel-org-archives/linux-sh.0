From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Sat, 05 Jan 2008 12:47:48 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <1199537268.6601.3.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Fri, 2008-01-04 at 20:24 -0500, Mike Frysinger wrote:
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
> it isnt busybox's job to load modules automatically and thus there is nothing 
> in there for it.  then again, i dont see why it would matter ... just do 
> `modprobe <the alsa driver>` and there's nothing else to be done.

Well, obviously I can load the module manually - as that is how I get
the oss emulation to work.

ALSA seems to require various configuration settings to work and that is
what I am trying to get to work.

I took one of the init.d scripts on my x86 box, chopped it down slightly
and loaded that: now the modules load but the alias commands/settings
are all rejected: so more work needs to be done. 

