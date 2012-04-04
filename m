From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 04 Apr 2012 03:01:57 +0000
Subject: Re: [PATCH] sh: fix build error in fpu.c
Message-Id: <20120404030156.GB23761@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4F7BAEE9.7020401@renesas.com>
In-Reply-To: <4F7BAEE9.7020401@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 04, 2012 at 11:16:09AM +0900, Shimoda, Yoshihiro wrote:
> This patch fixes the following build error:
> 
>   CC      arch/sh/kernel/cpu/sh4/fpu.o
> arch/sh/kernel/cpu/sh4/fpu.c:405: warning: return type defaults to ???int???
> arch/sh/kernel/cpu/sh4/fpu.c:405: warning: function declaration isn???t a prototype
> arch/sh/kernel/cpu/sh4/fpu.c: In function ???BUILD_TRAP_HANDLER???:
> arch/sh/kernel/cpu/sh4/fpu.c:407: error: ???TRAP_HANDLER_DECL??? undeclared (first use in this function)
> arch/sh/kernel/cpu/sh4/fpu.c:407: error: (Each undeclared identifier is reported only once
> arch/sh/kernel/cpu/sh4/fpu.c:407: error: for each function it appears in.)
> arch/sh/kernel/cpu/sh4/fpu.c:409: error: ???regs??? undeclared (first use in this function)
> arch/sh/kernel/cpu/sh4/fpu.c:423: warning: ???return??? with no value, in function returning non-void
>   CC      arch/sh/kernel/cpu/fpu.o
> arch/sh/kernel/cpu/fpu.c:80: warning: return type defaults to ???int???
> arch/sh/kernel/cpu/fpu.c:80: warning: function declaration isn???t a prototype
> arch/sh/kernel/cpu/fpu.c: In function ???BUILD_TRAP_HANDLER???:
> arch/sh/kernel/cpu/fpu.c:81: error: ???TRAP_HANDLER_DECL??? undeclared (first use in this function)
> arch/sh/kernel/cpu/fpu.c:81: error: (Each undeclared identifier is reported only once
> arch/sh/kernel/cpu/fpu.c:81: error: for each function it appears in.)
> arch/sh/kernel/cpu/fpu.c:83: error: ???regs??? undeclared (first use in this function)
> arch/sh/kernel/cpu/fpu.c:83: error: called object ???fpu_state_restore??? is not a function
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Already fixed in my tree.
