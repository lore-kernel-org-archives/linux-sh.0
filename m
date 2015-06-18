From: rkuo <rkuo@codeaurora.org>
Date: Thu, 18 Jun 2015 18:13:05 +0000
Subject: Re: [PATCH 2/2] Consolidate redundant register/stack access code
Message-Id: <20150618181304.GA9557@codeaurora.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1434386579-6045-1-git-send-email-dave.long@linaro.org>
 <1434386579-6045-3-git-send-email-dave.long@linaro.org>
In-Reply-To: <1434386579-6045-3-git-send-email-dave.long@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jun 15, 2015 at 12:42:59PM -0400, David Long wrote:
> From: "David A. Long" <dave.long@linaro.org>
> 
> Several architectures have identical or functionally equivalent code
> implementing parts of the HAVE_REGS_AND_STACK_ACCESS_API feature.  Move
> that code out of the architecture directories.
> 
> Signed-off-by: David A. Long <dave.long@linaro.org>
> ---
>  arch/arm/include/asm/ptrace.h          |  6 ---
>  arch/arm/kernel/ptrace.c               | 67 +-------------------------------
>  arch/hexagon/include/uapi/asm/ptrace.h |  3 --
>  arch/powerpc/include/asm/ptrace.h      | 38 ------------------
>  arch/powerpc/kernel/ptrace.c           | 34 +----------------
>  arch/s390/include/asm/ptrace.h         |  3 --
>  arch/s390/kernel/ptrace.c              | 70 ++++++++++------------------------
>  arch/sh/include/asm/ptrace.h           | 39 -------------------
>  arch/sh/kernel/Makefile                |  2 +-
>  arch/sh/kernel/ptrace.c                | 33 ----------------
>  arch/sh/kernel/ptrace_32.c             |  2 +-
>  arch/sh/kernel/ptrace_64.c             |  2 +-
>  arch/x86/include/asm/ptrace.h          | 37 ------------------
>  arch/x86/kernel/ptrace.c               | 34 +----------------
>  include/linux/ptrace.h                 | 42 ++++++++++++++++++++
>  kernel/ptrace.c                        | 38 ++++++++++++++++++
>  16 files changed, 107 insertions(+), 343 deletions(-)
>  delete mode 100644 arch/sh/kernel/ptrace.c
> 

(And in some cases, the architecture didn't have the code in the first place!)

For Hexagon:

Acked-by: Richard Kuo <rkuo@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, 
a Linux Foundation Collaborative Project
