From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Thu, 14 Apr 2011 14:22:17 +0000
Subject: Re: [Kgdb-bugreport] [PATCH 4/5] sh: convert to asm-generic ptrace.h
Message-Id: <4DA70319.8000902@mvista.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org> <1302760895-13459-5-git-send-email-vapier@gentoo.org>
In-Reply-To: <1302760895-13459-5-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, x86@kernel.org, Paul Mundt <lethal@linux-sh.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

Hello.

Mike Frysinger wrote:

> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
> ---
>  arch/sh/include/asm/ptrace.h |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)

> diff --git a/arch/sh/include/asm/ptrace.h b/arch/sh/include/asm/ptrace.h
> index b219a08..3f2a6e7 100644
> --- a/arch/sh/include/asm/ptrace.h
> +++ b/arch/sh/include/asm/ptrace.h
[...]
> @@ -137,6 +136,9 @@ static inline unsigned long profile_pc(struct pt_regs *regs)
>  
>  	return pc;
>  }
> +#define profile_pc profile_pc

    Same question about preprocessor...

WBR, Sergei
