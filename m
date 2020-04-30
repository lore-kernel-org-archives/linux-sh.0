From: Nicolas Pitre <nico@fluxnic.net>
Date: Thu, 30 Apr 2020 01:59:46 +0000
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem properly in there
Message-Id: <nycvar.YSQ.7.76.2004292153090.2671@knanqh.ubzr>
List-Id: <linux-sh.vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
 <20200429215620.GM1551@shell.armlinux.org.uk>
In-Reply-To: <20200429215620.GM1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Rich Felker <dalias@libc.org>, linux-c6x-dev@linux-c6x.org, Yoshinori Sato <ysato@users.sourceforge.jp>, Jann Horn <jannh@google.com>, Christophe Lyon <christophe.lyon@linaro.org>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, Mark Salter <msalter@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Aurelien Jacquiot <jacquiot.aurelien@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-arm-kernel@lists.infradead.org, "Eric W . Biederman" <ebiederm@xmission.com>

On Wed, 29 Apr 2020, Russell King - ARM Linux admin wrote:

> On Wed, Apr 29, 2020 at 11:49:49PM +0200, Jann Horn wrote:
> > At the moment, we have that rather ugly mmget_still_valid() helper to
> > work around <https://crbug.com/project-zero/1790>: ELF core dumping
> > doesn't take the mmap_sem while traversing the task's VMAs, and if
> > anything (like userfaultfd) then remotely messes with the VMA tree,
> > fireworks ensue. So at the moment we use mmget_still_valid() to bail
> > out in any writers that might be operating on a remote mm's VMAs.
> > 
> > With this series, I'm trying to get rid of the need for that as
> > cleanly as possible.
> > In particular, I want to avoid holding the mmap_sem across unbounded
> > sleeps.
> > 
> > 
> > Patches 1, 2 and 3 are relatively unrelated cleanups in the core
> > dumping code.
> > 
> > Patches 4 and 5 implement the main change: Instead of repeatedly
> > accessing the VMA list with sleeps in between, we snapshot it at the
> > start with proper locking, and then later we just use our copy of
> > the VMA list. This ensures that the kernel won't crash, that VMA
> > metadata in the coredump is consistent even in the presence of
> > concurrent modifications, and that any virtual addresses that aren't
> > being concurrently modified have their contents show up in the core
> > dump properly.
> > 
> > The disadvantage of this approach is that we need a bit more memory
> > during core dumping for storing metadata about all VMAs.
> > 
> > After this series has landed, we should be able to rip out
> > mmget_still_valid().
> > 
> > 
> > Testing done so far:
> > 
> >  - Creating a simple core dump on X86-64 still works.
> >  - The created coredump on X86-64 opens in GDB, and both the stack and the
> >    exectutable look vaguely plausible.
> >  - 32-bit ARM compiles with FDPIC support, both with MMU and !MMU config.
> > 
> > I'm CCing some folks from the architectures that use FDPIC in case
> > anyone wants to give this a spin.
> 
> I've never had any reason to use FDPIC, and I don't have any binaries
> that would use it.  Nicolas Pitre added ARM support, so I guess he
> would be the one to talk to about it.  (Added Nicolas.)

It's been a while since I worked with it. However Christophe Lyon (in 
CC) added support for ARM FDPIC to mainline gcc recently, so hopefully 
he might still be set up and able to help.


Nicolas
