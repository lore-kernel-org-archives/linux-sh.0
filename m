From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 03 Aug 2011 03:37:32 +0000
Subject: Re: [PATCH] sh: Fix conflicting definitions of ptrace_triggered
Message-Id: <20110803033732.GD32513@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1312148195-32658-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1312148195-32658-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Sun, Jul 31, 2011 at 05:36:35PM -0400, Paul Gortmaker wrote:
> The extra nmi argument is causing this compile fail:
> 
>   CC      arch/sh/kernel/ptrace_32.o
> arch/sh/kernel/ptrace_32.c:66:6: error: conflicting types for 'ptrace_triggered'
> arch/sh/include/asm/ptrace.h:126:13: note: previous declaration of 'ptrace_triggered' was here
> make[3]: *** [arch/sh/kernel/ptrace_32.o] Error 1
> 
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> 
Applied, thanks.
