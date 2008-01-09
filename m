From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Wed, 09 Jan 2008 07:59:17 +0000
Subject: Re: Busybox and automatic module loading
Message-Id: <1199865557.6393.2.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1199495386.12780.3.camel@localhost.localdomain>
In-Reply-To: <1199495386.12780.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


On Tue, 2008-01-08 at 19:38 -0500, Mike Frysinger wrote:
> On Tuesday 08 January 2008, Adrian McMenamin wrote:
> > On Tue, 2008-01-08 at 00:57 -0500, Mike Frysinger wrote:

> 
> are you generating the device nodes by hand or relying on something else ?  
> mdev currently will not place the device nodes in a subdir as would be 
> required by alsa-lib.

No, I'm using udev. The module loading stuff was not the issue I'm sure
anyway. And the OSS emulation appears to work perfectly.

> 
> > Maybe something wrong with my driver, (though oss emulation works very
> > well), but nobody is being very communicative. I don't think there is
> > much cross compiling of alsa going on out there!
> 
> are you using uClibc or glibc ?  we're cross-compiling alsa-lib for 
> Blackfin/uClibc and it seems to be working for us.  our drivers are varying 
> degrees of working, but that is a driver problem ;)
> 

uClibc. I suppose my issue might be driver related, but if so nobody can
point me as to where. And, as I say, the OSS emulation works.

Maybe you could point me to the configure script you are using?


> > I could try to debug alsa-lib but even its creators admit it's pretty
> > hard to digest.
> 
> so it is
> -mike

