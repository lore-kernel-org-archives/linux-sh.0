From: Dave Chinner <david@fromorbit.com>
Date: Mon, 28 Mar 2016 21:59:23 +0000
Subject: Re: Build regressions/improvements in v4.6-rc1
Message-Id: <20160328215923.GG11812@dastard>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdXx80zs5VoA_aYc_wMn37O=fa6oXk-ovteHq0hGQYUUzg@mail.gmail.com>
	<CAMuHMdW3dfhZVT0e4tiqsbEPjYYA_hGUXQer1bQDeF2Gbs4WJg@mail.gmail.com>
In-Reply-To: <CAMuHMdW3dfhZVT0e4tiqsbEPjYYA_hGUXQer1bQDeF2Gbs4WJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, Rich Felker <dalias@libc.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Cris <linux-cris-kernel@axis.com>, xfs@oss.sgi.com

On Sun, Mar 27, 2016 at 02:43:24PM +0200, Geert Uytterhoeven wrote:
> On Sun, Mar 27, 2016 at 2:39 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > Below is the list of build error/warning regressions/improvements in
> > v4.6-rc1[1] compared to v4.5[2].
> >
> > Summarized:
> >   - build errors: +9/-6
> 
> > [1] http://kisskb.ellerman.id.au/kisskb/head/10114/ (all 262 configs)
> > [2] http://kisskb.ellerman.id.au/kisskb/head/10047/ (all 262 configs)
> 
> > 9 error regressions:
> >   + /home/kisskb/slave/src/fs/xfs/xfs_ondisk.h: error: call to
> > '__compiletime_assert_79' declared with attribute error: XFS:
> > sizeof(xfs_attr_shortform_t) is wrong, expected 8:  => 79:2
> 
> cris-allyesconfig, cris-allmodconfig

Yup, cris is the only platform that throws this error on this
structure. It's an on-disk structure and relying on the gcc
optimiser to do the same thing from release to release has become
such a crap-shoot these days. Hence as a stop-gap measure we added
build time checking of what they compiler is doing with those
structures, and to refuse to build XFS if the compiler/platform is
doing something obviously different.

Modernising the on-disk structure definitions is on the list of
things to do, but it's nowhere near the top of my list at the
moment...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
