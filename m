From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 04 Dec 2015 12:44:27 +0000
Subject: Re: [PATCH 4/5] sh: ftrace: fix the comments for ftrace_modify_code
Message-Id: <56618AAB.2000202@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1449214067-12177-1-git-send-email-huawei.libin@huawei.com>
 <1449214067-12177-5-git-send-email-huawei.libin@huawei.com>
In-Reply-To: <1449214067-12177-5-git-send-email-huawei.libin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Li Bin <huawei.libin@huawei.com>, rostedt@goodmis.org, mingo@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 12/4/2015 10:27 AM, Li Bin wrote:

> There is no need to worry about module and __init text disappearing
> case, because that ftrace has a module notifier that is called when
> a module is being unloaded and before the text goes away and this
> code grabs the ftrace_lock mutex and removes the module functions
> from the ftrace list, such that it will no longer do any
> modifications to that module's text, the update to make functions
> be traced or not is done under the ftrace_lock mutex as well.
> And by now, __init section codes should not been modified
> by ftrace, because it is black listed in recordmcount.c and
> ignored by ftrace.
>
> Cc: linux-sh@vger.kernel.org
> Suggested-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Li Bin <huawei.libin@huawei.com>
> ---
>   arch/sh/kernel/ftrace.c |   13 ++++++-------
>   1 files changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/arch/sh/kernel/ftrace.c b/arch/sh/kernel/ftrace.c
> index 079d70e..b696f92 100644
> --- a/arch/sh/kernel/ftrace.c
> +++ b/arch/sh/kernel/ftrace.c
> @@ -212,13 +212,12 @@ static int ftrace_modify_code(unsigned long ip, unsigned char *old_code,
>   	unsigned char replaced[MCOUNT_INSN_SIZE];
>
>   	/*
> -	 * Note: Due to modules and __init, code can
> -	 *  disappear and change, we need to protect against faulting
> -	 *  as well as code changing. We do this by using the
> -	 *  probe_kernel_* functions.
> -	 *
> -	 * No real locking needed, this code is run through
> -	 * kstop_machine, or before SMP starts.
> +	 * Note:
> +	 * We are paranoid about modifying text, as if a bug were to happen, it

    s/were/was/.

[...]

MBR, Sergei

