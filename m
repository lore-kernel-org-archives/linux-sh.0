From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 15 Oct 2015 11:06:49 +0000
Subject: Re: [PATCH/RFC 4/6] arm: shmobile: r8a7791: Obtain MD pin value using boot-mode-reg
Message-Id: <561F88C9.7080805@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444892377-10170-5-git-send-email-horms+renesas@verge.net.au>
In-Reply-To: <1444892377-10170-5-git-send-email-horms+renesas@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 10/15/2015 9:59 AM, Simon Horman wrote:

> Use new boot mode reg infrastructure to obtain the mode pin
> value when initialising SMP for r8a7791 SoC.
>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>   arch/arm/mach-shmobile/smp-r8a7791.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-shmobile/smp-r8a7791.c b/arch/arm/mach-shmobile/smp-r8a7791.c
> index b2508c0d276b..595499834293 100644
> --- a/arch/arm/mach-shmobile/smp-r8a7791.c
> +++ b/arch/arm/mach-shmobile/smp-r8a7791.c
[...]
> @@ -45,8 +47,17 @@ static void __init r8a7791_smp_prepare_cpus(unsigned int max_cpus)
>   static int r8a7791_smp_boot_secondary(unsigned int cpu,
>   				      struct task_struct *idle)
>   {
> +	int err;
> +	u32 mode;
> +
> +	err = boot_mode_reg_get(&mode);
> +	if (err) {
> +		pr_warn("Unable retrieve boot mode register\n");

    There's "to" missing in this string.

[...]

MBR, Sergei

