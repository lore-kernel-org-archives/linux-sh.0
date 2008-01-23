From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 23 Jan 2008 09:53:59 +0000
Subject: Re: debian etch sh3 and sh4
Message-Id: <20080123095359.GA22537@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <82C85C285793D5ebiharaml@si-linux.com>
In-Reply-To: <82C85C285793D5ebiharaml@si-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 23, 2008 at 10:40:58AM +0100, Manuel Lauss wrote:
> On Wed, Jan 23, 2008 at 09:29:47AM -0000, Adrian McMenamin wrote:
> > On Tue, January 22, 2008 10:49 pm, Mike Frysinger wrote:
> > > On Tuesday 22 January 2008, Adrian McMenamin wrote:
> > >> On Tue, January 22, 2008 2:34 pm, Mike Frysinger wrote:
> > >> > err, 18 months ?  which stages are you looking at ?
> > >>
> > >> I was looking at the uclibc stuff, which I admit is not a strictly fair
> > >> comparison (as the Debian stuff is linked with glibc)
> > >
> > > i can look at refreshing the uClibc stages this time around ... when i was
> > > doing 2007.0, i didnt have enough time to bounce glibc and uclibc at the
> > > sametime
> > 
> > 
> > How good is emerge when memory is in short supply in the glibc versions?
> > apt/dpkg is a pig - takes forever and then OOMs :(
> 
> All you need is a bit of swap (CF cards, ..) and distcc.  This way I was
> able to emerge current XFCE and qt-4.3.3 with 64MB RAM. Patience is a 
> virtue in this case ;-)
>  
In 16MB you will always be bordering on thrashing just trying to do _any_
basic tasks. Your options are realistically limited to busybox or
throwing the damn thing out (the recommended option). Doing anything more
involved than that was pretty questionable back when the kernel used a
lot less memory, and trying to do builds in that environment is well past
absurdity these days. 64MB is painful, but at least workable.
