From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Wed, 09 Jan 2008 18:56:10 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <1199904970.6399.0.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Wed, 2008-01-09 at 12:54 -0500, Mike Frysinger wrote:
> On Wednesday 09 January 2008, Adrian McMenamin wrote:
> > On Tue, 2008-01-08 at 19:38 -0500, Mike Frysinger wrote:
> > > On Tuesday 08 January 2008, Adrian McMenamin wrote:
> > > > On Tue, 2008-01-08 at 00:57 -0500, Mike Frysinger wrote:
> > >
> > > are you generating the device nodes by hand or relying on something else
> > > ? mdev currently will not place the device nodes in a subdir as would be
> > > required by alsa-lib.
> >
> > No, I'm using udev. The module loading stuff was not the issue I'm sure
> > anyway. And the OSS emulation appears to work perfectly.
> 
> i'd just build everything into the kernel except for the module you're 
> developing ... a lot simpler that way
> 

Why? I'm not sure I follow what you mean.

> > > > Maybe something wrong with my driver, (though oss emulation works very
> > > > well), but nobody is being very communicative. I don't think there is
> > > > much cross compiling of alsa going on out there!
> > >
> > > are you using uClibc or glibc ?  we're cross-compiling alsa-lib for
> > > Blackfin/uClibc and it seems to be working for us.  our drivers are
> > > varying degrees of working, but that is a driver problem ;)
> >
> > uClibc. I suppose my issue might be driver related, but if so nobody can
> > point me as to where. And, as I say, the OSS emulation works.
> >
> > Maybe you could point me to the configure script you are using?
> 
> make sure you turn off version stuff: --with-versioned=no

Is this for alsa-lib or something else?

Adrian

