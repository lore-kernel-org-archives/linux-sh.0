From: "H. Peter Anvin" <hpa@zytor.com>
Date: Thu, 14 Apr 2011 17:05:41 +0000
Subject: Re: [Kgdb-bugreport] [PATCH 3/5] x86: convert to asm-generic ptrace.h
Message-Id: <4DA72965.20907@zytor.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1302760895-13459-1-git-send-email-vapier@gentoo.org> <1302760895-13459-4-git-send-email-vapier@gentoo.org> <4DA701D5.5050205@mvista.com>
In-Reply-To: <4DA701D5.5050205@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Mike Frysinger <vapier@gentoo.org>, Roland McGrath <roland@redhat.com>, Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, Jason Wessel <jason.wessel@windriver.com>, Andrew Morton <akpm@linux-foundation.org>, linux-sh@vger.kernel.org, x86@kernel.org, Paul Mundt <lethal@linux-sh.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>

On 04/14/2011 07:16 AM, Sergei Shtylyov wrote:
> Hello.
>
> Mike Frysinger wrote:
>
>> Signed-off-by: Mike Frysinger <vapier@gentoo.org>
>> ---
>> arch/x86/include/asm/ptrace.h | 18 +++++-------------
>> 1 files changed, 5 insertions(+), 13 deletions(-)
>
>> diff --git a/arch/x86/include/asm/ptrace.h
>> b/arch/x86/include/asm/ptrace.h
>> index 78cd1ea..98a5e97 100644
>> --- a/arch/x86/include/asm/ptrace.h
>> +++ b/arch/x86/include/asm/ptrace.h
>> @@ -136,6 +136,7 @@ struct cpuinfo_x86;
>> struct task_struct;
>>
>> extern unsigned long profile_pc(struct pt_regs *regs);
>> +#define profile_pc profile_pc
>
> Er, won't this lead to infinite recursion in preprocessor? :-)
>
> WBR, Sergei
>

No.

	-hpa
