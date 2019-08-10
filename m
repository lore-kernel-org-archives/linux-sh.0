From: Joe Perches <joe@perches.com>
Date: Sat, 10 Aug 2019 04:20:48 +0000
Subject: Re: [PATCH] sh: Drop -Werror from kernel Makefile
Message-Id: <667995275e6a1cbcdaa93029c1b33e6b52fc6803.camel@perches.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1564971263-21562-1-git-send-email-linux@roeck-us.net>
         <20190805032441.GO9017@brightrain.aerifal.cx>
         <20190809195630.GA15606@roeck-us.net>
         <5f26547f-b48e-4b9f-b8ef-858283915e3d@embeddedor.com>
         <20190809215608.GA11065@roeck-us.net>
         <6a06245f-33f2-1d92-0d0e-c8b270dc24af@embeddedor.com>
In-Reply-To: <6a06245f-33f2-1d92-0d0e-c8b270dc24af@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Rich Felker <dalias@libc.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2019-08-09 at 21:47 -0500, Gustavo A. R. Silva wrote:
> On 8/9/19 4:56 PM, Guenter Roeck wrote:
> > On Fri, Aug 09, 2019 at 04:36:01PM -0500, Gustavo A. R. Silva wrote:
> > > On 8/9/19 2:56 PM, Guenter Roeck wrote:
> > > > On Sun, Aug 04, 2019 at 11:24:41PM -0400, Rich Felker wrote:
> > > > > On Sun, Aug 04, 2019 at 07:14:23PM -0700, Guenter Roeck wrote:
> > > > > > Since commit a035d552a93b ("Makefile: Globally enable fall-through
> > > > > > warning"), all sh builds fail with errors such as
> > > > > > 
> > > > > > arch/sh/kernel/disassemble.c: In function 'print_sh_insn':
> > > > > > arch/sh/kernel/disassemble.c:478:8: error: this statement may fall through
> > > > > > 
> > > > > > Since this effectively disables all build and boot tests for the
> > > > > > architecture, let's drop -Werror from the sh kernel Makefile until
> > > > > > the problems are fixed.
[]
> On second thought it seems to me that this is not a good idea, at least
> for mainline. For the time being I'll take this patch for linux-next only.
> 
> Who is the maintainer of sh?

But whoever it may be, isn't particularly active.

MAINTAINERS-SUPERH
MAINTAINERS-M:  Yoshinori Sato <ysato@users.sourceforge.jp>
MAINTAINERS-M:  Rich Felker <dalias@libc.org>
MAINTAINERS-L:  linux-sh@vger.kernel.org
MAINTAINERS-Q:  http://patchwork.kernel.org/project/linux-sh/list/
MAINTAINERS-S:  Maintained
MAINTAINERS-F:  Documentation/sh/
MAINTAINERS:F:  arch/sh/
MAINTAINERS-F:  drivers/sh/

> The best solution is to fix those fall-through warnings you see. Could you
> please send me all the warnings you see? I can try to fix them.

It's true it's a warning, but adding -Werror is rarely
a good idea as gcc error output can change with every
version.
