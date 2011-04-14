From: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 14 Apr 2011 18:09:36 +0000
Subject: Re: [PATCH 1/5] asm-generic/ptrace.h: start a common low level
Message-Id: <20110414180936.GA20924@redhat.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org> <1302760895-13459-2-git-send-email-vapier@gentoo.org>
In-Reply-To: <1302760895-13459-2-git-send-email-vapier@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mike Frysinger <vapier@gentoo.org>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>

On 04/14, Mike Frysinger wrote:
>
> This implements a bunch of helper funcs for poking the registers of a
> ptrace structure.  Now common code should be able to portably update
> specific registers (like kgdb updating the PC).

The whole series looks correct, but I am a bit confused...

> +#ifndef GET_IP
> +#define GET_IP(regs) ((regs)->pc)
> +#endif

Could you explain this ifndef ?

IIUC, this should be included by arch/*/asm/ptrace.h. Isn't it better
to simply require that if you include asm-generic/ptrace.h you should
provide the necessary GET_* macros?

(regs)->pc looks a bit strange in asm-generic. But please feel free
to ignore.

Oleg.

