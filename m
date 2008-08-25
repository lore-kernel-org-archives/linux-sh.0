From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 25 Aug 2008 06:27:43 +0000
Subject: Re: [2.6 patch] sh: fix ptrace_64.c:user_disable_single_step()
Message-Id: <20080825062743.GB19834@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080822152036.GB26762@cs181140183.pp.htv.fi>
In-Reply-To: <20080822152036.GB26762@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Aug 22, 2008 at 06:20:36PM +0300, Adrian Bunk wrote:
> This patch fixes the following compile error caused by
> commit c459dbf294b4a3d70490a468a7ca3907fb2c2f57
> (sh: ptrace single stepping cleanups.):
> 
> <--  snip  -->
> 
> ...
>   CC      arch/sh/kernel/ptrace_64.o
> arch/sh/kernel/ptrace_64.c: In function 'user_disable_single_step':
> arch/sh/kernel/ptrace_64.c:134: error: 'regs' undeclared (first use in this function)
> arch/sh/kernel/ptrace_64.c:134: error: (Each undeclared identifier is reported only once
> arch/sh/kernel/ptrace_64.c:134: error: for each function it appears in.)
> ...
> make[2]: *** [arch/sh/kernel/ptrace_64.o] Error 1
> 
> <--  snip  -->
> 
> Reported-by: Adrian Bunk <bunk@kernel.org>
> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
Applied, thanks.
