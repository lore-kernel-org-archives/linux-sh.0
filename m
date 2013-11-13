From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 13 Nov 2013 17:14:50 +0000
Subject: Re: [PATCH] sh: fix kernel build error
Message-Id: <5283C19D.4050601@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384353504-21886-1-git-send-email-gaowanlong@cn.fujitsu.com>
In-Reply-To: <1384353504-21886-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>, linux-sh@vger.kernel.org, lethal@linux-sh.org
Cc: linux-kernel@vger.kernel.org, fengguang.wu@intel.com, kbuild-all@01.org

Hello.

On 11/13/2013 05:38 PM, Wanlong Gao wrote:

>     arch/sh/kernel/kgdb.c: In function 'sleeping_thread_to_gdb_regs':
>>> arch/sh/kernel/kgdb.c:225:32: error: implicit declaration of function 'task_stack_page' [-Werror=implicit-function-declaration]
>>> arch/sh/kernel/kgdb.c:242:23: error: dereferencing pointer to incomplete type
>>> arch/sh/kernel/kgdb.c:243:22: error: dereferencing pointer to incomplete type
>     arch/sh/kernel/kgdb.c: In function 'singlestep_trap_handler':
>>> arch/sh/kernel/kgdb.c:310:27: error: 'SIGTRAP' undeclared (first use in this function)
>     arch/sh/kernel/kgdb.c:310:27: note: each undeclared identifier is reported only once for each function it appears in
>     cc1: all warnings being treated as errors

    Strange quoting...

> This is introduced by commit 16559ae.

    Please also specify that commit's summary line in parens.

> CC: kbuild-all@01.org
> Reported-by: Fengguang Wu <fengguang.wu@intel.com>
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

WBR, Sergei

