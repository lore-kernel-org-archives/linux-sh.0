From: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Date: Wed, 23 Jan 2008 13:30:19 +0000
Subject: Re: debian etch sh3 and sh4
Message-Id: <20080123143019.a9b6f4cd.Kristoffer.ericson@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <82C85C285793D5ebiharaml@si-linux.com>
In-Reply-To: <82C85C285793D5ebiharaml@si-linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 23 Jan 2008 07:16:43 -0500
Mike Frysinger <vapier@gentoo.org> wrote:

> On Wednesday 23 January 2008, Adrian McMenamin wrote:
> > On Wed, January 23, 2008 9:53 am, Paul Mundt wrote:
> > > In 16MB you will always be bordering on thrashing just trying to do _any_
> > > basic tasks. Your options are realistically limited to busybox or
> > > throwing the damn thing out (the recommended option). Doing anything more
> > > involved than that was pretty questionable back when the kernel used a
> > > lot less memory, and trying to do builds in that environment is well past
> > > absurdity these days. 64MB is painful, but at least workable.
> >
> > You really are like the Kerryman who, when asked how to get to Dublin said
> > "well, I wouldn't start from here." :)
> >
> > I don't mind the thrashing if it gets me something that works and which
> > can later be used as the basis of a "distro" - which is my aim here.
> >
> > Anyone know how stable swap over nfs is these days? Speed is a secondary
> > consideration.
> >
> > NB: CF or similar isn't an option. In theory you could put a very small
> > swap partition on the Dreamcast's VMUs but access to that is likely to be
> > much slower even than NFS - as it would be rationed to 60 times per
> > second.
> 
> i used to build on the dreamcast, but the swapping was terrible so i gave up 
> and just bought a lantank as it has 64megs ;)
> -mike
> 

We've used ipkg for jlime, which basicly is a minimal version of apt. One would expect great speed, but unfortunantly
that isn't the case. It seems to have a hard time handling the database which is why we've split it up into
smaller pieces.
ipkg is borderline usable on an jornada with 16mb/133mhz so I doubt apt will be any better.

Personally I believe that slackware + some minimal packagemanager is the way to go. Doesn't simplify much for the user
but will be easy to access packages and also maintain diffs against the main sources. Archlinux might also be an option since
I have greater faith in pacman as a package manager, but currently there's no superH port.

I agree with paul that we need to see some commitment to getting stuff into the true release instead of providing "unsupported"/"unofficial" branches which pop up every year or so. 




