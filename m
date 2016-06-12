From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 12 Jun 2016 11:32:52 +0000
Subject: Re: [PATCH v2 05/17] sh: command line passing chosen/bootargs in devicetree
Message-Id: <9def6543-5185-0248-72fd-67c6dae3b962@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
 <1465714475-24111-6-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-6-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/12/2016 9:54 AM, Yoshinori Sato wrote:

> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/kernel/setup.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/sh/kernel/setup.c b/arch/sh/kernel/setup.c
> index 8e3b099..d97de16 100644
> --- a/arch/sh/kernel/setup.c
> +++ b/arch/sh/kernel/setup.c
> @@ -280,6 +280,8 @@ void __init setup_arch(char **cmdline_p)
>  #endif
>  	enable_mmu();
>
> +

    Another empty line hardly needed here.

> +#ifndef CONFIG_OF
>  	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
>
>  	printk(KERN_NOTICE "Boot params:\n"
[...]

MBR, Sergei

