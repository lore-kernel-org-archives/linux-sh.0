From: Mike Frysinger <vapier.adi@gmail.com>
Date: Tue, 25 May 2010 01:29:34 +0000
Subject: Re: [Uclinux-dist-devel] [PATCH -mm 1/1] ptrace: PTRACE_GETFDPIC: fix
Message-Id: <AANLkTinpMp1yZ2c5B5O7aT2NR57zBHlggvUXZ58bLGv2@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20100522165401.GB19573@redhat.com> <1266280229-18469-1-git-send-email-vapier@gentoo.org> 
	<1274431345-22366-1-git-send-email-vapier@gentoo.org> <20100521162659.GA16193@redhat.com> 
	<20100521183512.4477F40476@magilla.sf.frob.com> <20100522165320.GA19573@redhat.com> 
	<25539.1274711817@redhat.com> <20100524151445.GA6393@redhat.com> 
	<20100524234250.F158849A56@magilla.sf.frob.com>
In-Reply-To: <20100524234250.F158849A56@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, David Howells <dhowells@redhat.com>, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, Andrew Morton <akpm@linux-foundation.org>

On Mon, May 24, 2010 at 19:42, Roland McGrath wrote:
>> You mean, pass it to arch_ptrace() ?
>>
>> grep, grep, grep. I guess I understand you. We have more unsafe code
>> like this in arch/*/kernel/ptrace.c. Of course, it can be fixed without
>> doing get_task_mm() in sys_ptrace(), but perhaps it would be more clean
>> to do what you suggest.
>>
>> Roland, what do you think?
>
> The mm pointer is only used by these uncommon ptrace operations that exist
> only in certain unusual arch's (and they're all ill-advised old arch ptrace
> ABI additions, at that).

are you suggesting the FDPIC additions are ill-advised as well ?
curious how you would have implemented this if that's the case ...
-mike
