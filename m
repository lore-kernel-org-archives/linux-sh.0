From: Will Deacon <will.deacon@arm.com>
Date: Tue, 16 Jun 2015 17:39:07 +0000
Subject: Re: [PATCH 0/2] Consolidate redundant register/stack access code
Message-Id: <20150616173907.GV30522@arm.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
In-Reply-To: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi David,

On Mon, Jun 15, 2015 at 05:42:57PM +0100, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Move duplicate and functionally equivalent code for accessing registers
> and stack (CONFIG_HAVE_REGS_AND_STACK_ACCESS_API) from arch subdirs into
> common kernel files.
> 
> Note: Help regression testing s390, hexagon, and sh would be appreciated.
>       Powerpc builds but I have not verified the functionality.
> 
> David A. Long (2):
>   Move the pt_regs_offset struct definition from arch to common include
>     file
>   Consolidate redundant register/stack access code
> 
>  arch/arm/include/asm/ptrace.h          |  6 ---
>  arch/arm/kernel/ptrace.c               | 72 +---------------------------------
>  arch/hexagon/include/uapi/asm/ptrace.h |  3 --
>  arch/powerpc/include/asm/ptrace.h      | 38 ------------------
>  arch/powerpc/kernel/ptrace.c           | 39 +-----------------
>  arch/s390/include/asm/ptrace.h         |  3 --
>  arch/s390/kernel/ptrace.c              | 70 ++++++++++-----------------------
>  arch/sh/include/asm/ptrace.h           | 44 ---------------------
>  arch/sh/kernel/Makefile                |  2 +-
>  arch/sh/kernel/ptrace.c                | 33 ----------------
>  arch/sh/kernel/ptrace_32.c             |  2 +-
>  arch/sh/kernel/ptrace_64.c             |  2 +-
>  arch/x86/include/asm/ptrace.h          | 37 -----------------
>  arch/x86/kernel/ptrace.c               | 39 +-----------------
>  include/linux/ptrace.h                 | 51 ++++++++++++++++++++++++
>  kernel/ptrace.c                        | 38 ++++++++++++++++++
>  16 files changed, 116 insertions(+), 363 deletions(-)

Nice cleanup! The ARMy bits all look fine to me.

  Acked-by: Will Deacon <will.deacon@arm.com>

Will
