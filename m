From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sun, 12 Jun 2016 11:29:42 +0000
Subject: Re: [PATCH v2 01/17] sh: Add sh-specific early_init_dt_reserve_memory_arch
Message-Id: <b257fec6-5c92-dcf5-ff8a-20365f8e9365@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1465714475-24111-1-git-send-email-ysato@users.sourceforge.jp>
 <1465714475-24111-2-git-send-email-ysato@users.sourceforge.jp>
In-Reply-To: <1465714475-24111-2-git-send-email-ysato@users.sourceforge.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshinori Sato <ysato@users.sourceforge.jp>, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On 6/12/2016 9:54 AM, Yoshinori Sato wrote:

> sh used P1 address space in early device tree.
> So need convert P1 to physical address before reserve memory.
>
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  arch/sh/boards/of-generic.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
> index 57d45dc..fe2d917 100644
> --- a/arch/sh/boards/of-generic.c
> +++ b/arch/sh/boards/of-generic.c
[...]
> @@ -203,3 +204,14 @@ static int __init sh_of_device_init(void)
>  	return 0;
>  }
>  arch_initcall_sync(sh_of_device_init);
> +
> +int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
> +					     phys_addr_t size, bool nomap)
> +{
> +	if (nomap)
> +		return memblock_remove(base, size);
> +
> +	if (base >= P1SEG)
> +		base = base & ~P1SEG;

		base &= ~P1SEG;

> +	return memblock_reserve(base, size);
> +}

MBR, Sergei

