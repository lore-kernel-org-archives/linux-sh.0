From: Rich Felker <dalias@libc.org>
Date: Sun, 27 Mar 2016 17:05:44 +0000
Subject: Re: Build regressions/improvements in v4.6-rc1
Message-Id: <20160327170544.GA21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdXx80zs5VoA_aYc_wMn37O=fa6oXk-ovteHq0hGQYUUzg@mail.gmail.com>
 <CAMuHMdW3dfhZVT0e4tiqsbEPjYYA_hGUXQer1bQDeF2Gbs4WJg@mail.gmail.com>
 <20160327131530.GX21636@brightrain.aerifal.cx>
In-Reply-To: <20160327131530.GX21636@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Mar 27, 2016 at 09:15:30AM -0400, Rich Felker wrote:
> On Sun, Mar 27, 2016 at 02:43:24PM +0200, Geert Uytterhoeven wrote:
> > On Sun, Mar 27, 2016 at 2:39 PM, Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > Below is the list of build error/warning regressions/improvements in
> > > v4.6-rc1[1] compared to v4.5[2].
> > >
> > > Summarized:
> > >   - build errors: +9/-6
> > 
> > > [1] http://kisskb.ellerman.id.au/kisskb/head/10114/ (all 262 configs)
> > > [2] http://kisskb.ellerman.id.au/kisskb/head/10047/ (all 262 configs)
> > 
> > > 9 error regressions:
> > >   + /home/kisskb/slave/src/fs/xfs/xfs_ondisk.h: error: call to
> > > '__compiletime_assert_79' declared with attribute error: XFS:
> > > sizeof(xfs_attr_shortform_t) is wrong, expected 8:  => 79:2
> > 
> > cris-allyesconfig, cris-allmodconfig
> > 
> > >   + error: smp-shx3.c: undefined reference to `local_timer_setup':  =>
> > > .text+0xadec)
> > 
> > shx3_defconfig
> 
> Thanks for catching this. I've prepared a patch and I'm checking
> whether it fixes the problem.

I've tested that the patch fixes the build and sent it to the linux-sh
list.

Rich
