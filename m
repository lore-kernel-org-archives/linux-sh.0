From: Rich Felker <dalias@libc.org>
Date: Thu, 26 May 2016 16:53:34 +0000
Subject: Re: [PATCH 0/4] sh: fix up modular use in non-modular code
Message-Id: <20160526165334.GY21636@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
References: <1461348424-3896-1-git-send-email-paul.gortmaker@windriver.com>
 <20160526164557.GJ27984@windriver.com>
In-Reply-To: <20160526164557.GJ27984@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>

On Thu, May 26, 2016 at 12:45:57PM -0400, Paul Gortmaker wrote:
> [[PATCH 0/4] sh: fix up modular use in non-modular code] On 22/04/2016 (Fri 14:07) Paul Gortmaker wrote:
> 
> > For anyone new to the underlying goal of this cleanup, we are trying to
> > make kernel code consistent with the Makefiles/Kconfigs that control them.
> 
> Ping -- wondering if there are any issues here, or if I can expect these
> to be merged upstream in the merge window.  I didn't see them loop
> around via the linux-next tree but I wasn't sure if arch/sh has a repo
> for linux-next.

I don't have experience with the affected code, but it looks ok unless
any of these "should" be modular and Kconfig was just wrong to
disallow it.

Sato-san, do you have an opinion on these? Should I go ahead and just
merge them?

Rich

> > This means not using modular functions/macros for code that can never
> > be built as a module.  Some of the other downfalls this leads to are:
> > 
> >  (1) it is easy to accidentally write unused module_exit and remove code
> >  (2) it can be misleading when reading the source, thinking it can be
> >      modular when the Makefile and/or Kconfig prohibit it
> >  (3) it requires the include of the module.h header file which in turn
> >      includes nearly everything else, thus adding to CPP overhead.
> >  (4) it gets copied/replicated into other drivers and spreads like weeds.
> > 
> > Three of the four commits here are completely trivial with zero runtime
> > impact whatsoever.  The fourth has a deletion of a ".remove" function
> > and as we've done elsewhere, we block the sysfs ability to reach in and
> > manually execute that function, since there isn't a sane use case for
> > which doing that makes sense.
> > 
> > Build tested on today's linux-next ; full build fails on duplicate syms
> > from OF generic board, but that is a known and reported issue elsewhere;
> > it has nothing to do with the changes here.
> > 
> > Paul
> > --
> > 
> > Cc: linux-sh@vger.kernel.org
> > Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Cc: Rich Felker <dalias@libc.org>
> > Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> > 
> > 
> > Paul Gortmaker (4):
> >   sh: make time.c explicitly non-modular
> >   sh: make mm/asids-debugfs explicitly non-modular
> >   sh: make board-secureedge5410 explicitly non-modular
> >   sh: make heartbeat driver explicitly non-modular
> > 
> >  arch/sh/boards/board-secureedge5410.c |  3 +--
> >  arch/sh/drivers/heartbeat.c           | 32 +++-----------------------------
> >  arch/sh/kernel/time.c                 |  3 +--
> >  arch/sh/mm/asids-debugfs.c            |  5 +----
> >  4 files changed, 6 insertions(+), 37 deletions(-)
> > 
> > -- 
> > 2.8.0
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
