From: Rich Felker <dalias@libc.org>
Date: Thu, 10 Sep 2020 13:37:51 +0000
Subject: Re: [PATCH] sh: fix syscall tracing
Message-Id: <20200910133751.GE3265@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <20200903054803.GX3265@brightrain.aerifal.cx>
 <e456a455-62cd-4f76-a69a-84d1e5b4d153@physik.fu-berlin.de>
 <20200903161639.GE3265@brightrain.aerifal.cx>
 <1a3f0f7e-f6e6-db4e-06ad-9c7d560a6265@physik.fu-berlin.de>
 <20200907174436.GK3265@brightrain.aerifal.cx>
 <3b8d5e6a-38d6-6eca-a49a-69e06680ec1c@physik.fu-berlin.de>
 <c0685f0b-e997-39e9-8ae9-ee22c8e74a01@landley.net>
In-Reply-To: <c0685f0b-e997-39e9-8ae9-ee22c8e74a01@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Landley <rob@landley.net>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-sh@vger.kernel.org, Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>, linux-kernel@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

On Thu, Sep 10, 2020 at 06:02:05AM -0500, Rob Landley wrote:
> On 9/10/20 4:55 AM, John Paul Adrian Glaubitz wrote:
> > Hi Rich!
> > 
> > On 9/7/20 7:44 PM, Rich Felker wrote:
> >>> Can we still get this merged as a hotfix for 5.9?
> >>
> >> Yes, fixes for regressions in the same release cycle are in-scope (the
> >> whole point of having -rc's). I have at least one other fix that needs
> >> to go in too and was just giving it a little time to make sure
> >> everything's ok now and that there are no more.
> > 
> > Let me know if there is anything else left for testing.
> 
> Could you also merge the fix the build break, ala:
> 
> > The vmlinux image is a current vanilla Linux kernel using an initramfs filesystem:
> > 
> >   make ARCH=sh CROSS_COMPILE=sh2eb-linux-muslfdpic- j2_defconfig vmlinux
> > 
> > And trying to do that in current git dies with:
> > 
> >   CC      init/version.o
> > In file included from ./include/linux/spinlock.h:318,
> >                  from ./arch/sh/include/asm/smp.h:11,
> >                  from ./include/linux/smp.h:82,
> >                  from ./include/linux/lockdep.h:14,
> >                  from ./include/linux/rcupdate.h:29,
> >                  from ./include/linux/rculist.h:11,
> >                  from ./include/linux/pid.h:5,
> >                  from ./include/linux/sched.h:14,
> >                  from ./include/linux/utsname.h:6,
> >                  from init/version.c:14:
> > ./include/linux/spinlock_api_smp.h: In function '__raw_spin_trylock':
> > ./include/linux/spinlock_api_smp.h:90:3: error: implicit declaration of function
> > 'spin_acquire'; did you mean 'xchg_acquire'? [-Werror=implicit-function-declaration]
> >    90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> >       |   ^~~~~~~~~~~~
> >       |   xchg_acquire
> > ./include/linux/spinlock_api_smp.h:90:21: error: 'raw_spinlock_t' {aka 'struct
> > raw_spinlock'} has no member named 'dep_map'
> >    90 |   spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
> >       |                     ^~
> > 
> > And so on and so forth for pages. I bisected it to:
> > 
> > commit 0cd39f4600ed4de859383018eb10f0f724900e1b
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Thu Aug 6 14:35:11 2020 +0200
> > 
> >     locking/seqlock, headers: Untangle the spaghetti monster
> 
> Which I reported to Rich on the 2nd and he had me test a one line patch fixing
> it (adding an extra #include) on the 3rd, but I just did a fresh pull and the
> j2_defconfig build still broke a week later.

Yes, that's presently the other regression fix I have queued for the
second pull request.

Rich
