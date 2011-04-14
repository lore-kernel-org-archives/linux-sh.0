From: Mike Frysinger <vapier@gentoo.org>
Date: Thu, 14 Apr 2011 18:16:03 +0000
Subject: Re: [PATCH 1/5] asm-generic/ptrace.h: start a common low level ptrace helper
Message-Id: <BANLkTikxq-xUhYmbE93+aGHoiEEbHWkoWQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org>
 <1302760895-13459-2-git-send-email-vapier@gentoo.org> <20110414180936.GA20924@redhat.com>
In-Reply-To: <20110414180936.GA20924@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, Apr 14, 2011 at 14:09, Oleg Nesterov wrote:
> On 04/14, Mike Frysinger wrote:
>> +#ifndef GET_IP
>> +#define GET_IP(regs) ((regs)->pc)
>> +#endif
>
> Could you explain this ifndef ?
>
> IIUC, this should be included by arch/*/asm/ptrace.h. Isn't it better
> to simply require that if you include asm-generic/ptrace.h you should
> provide the necessary GET_* macros?
>
> (regs)->pc looks a bit strange in asm-generic. But please feel free
> to ignore.

my view of asm-generic is to put as much common/sane-defaults in there
as possible to minimize code duplication in arch code.  when it comes
to the register names, i looked at the arches to see what people used.
while x86 uses "ip", the majority of ports use "pc", thus the
majority of ports wont have to define their own GET_IP helper.
-mike
