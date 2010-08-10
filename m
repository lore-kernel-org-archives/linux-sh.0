From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 10 Aug 2010 13:18:28 +0000
Subject: Re: [PATCH] i2c: i2c-sh_mobile irq rollback fix
Message-Id: <20100810151828.36a77cc3@hyperion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20100802071637.18054.76993.sendpatchset@t400s>
In-Reply-To: <20100802071637.18054.76993.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lethal-M7jkjyW5wf5g9hUCZPvPmw@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Mon, 02 Aug 2010 16:16:37 +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Update the i2c-sh_mobile driver to properly free
> interrupts. The function sh_mobile_i2c_hook_irqs()
> is fixed so module both unload and load are working
> as expected.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  drivers/i2c/busses/i2c-sh_mobile.c |   23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> --- 0001/drivers/i2c/busses/i2c-sh_mobile.c
> +++ work/drivers/i2c/busses/i2c-sh_mobile.c	2010-08-02 15:14:48.000000000 +0900
> @@ -538,15 +538,17 @@ static int sh_mobile_i2c_hook_irqs(struc
>  {
>  	struct resource *res;
>  	int ret = -ENXIO;
> -	int q, m;
> -	int k = 0;
> -	int n = 0;
> +	int n, k = 0;

You can't really hope to get the code right with such variable names.

-- 
Jean Delvare
