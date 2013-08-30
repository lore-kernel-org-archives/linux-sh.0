From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 30 Aug 2013 17:31:30 +0000
Subject: Re: [RFC 06/10] ARM: shmobile: r8a7790: add I2C clock
Message-Id: <5220D6F2.7040404@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-7-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-7-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 08/30/2013 04:37 PM, Ulrich Hecht wrote:

> From: Nguyen Viet Dung <nv-dung@jinso.co.jp>

> This patch add clock for I2C bus.

> Signed-off-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> ---
>   arch/arm/mach-shmobile/clock-r8a7790.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)

> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index d99b87b..05cd34b 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
[...]
> @@ -181,6 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
>
>   /* MSTP */
>   enum {
> +	MSTP931, MSTP930, MSTP929, MSTP928,

    Please break the line after "MSTP930,".

[...]
> @@ -286,6 +293,10 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_DEV_ID("ee220000.mmcif", &mstp_clks[MSTP305]),
>   	CLKDEV_DEV_ID("sh_mmcif.1", &mstp_clks[MSTP305]),
>   	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
> +	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP931]),
> +	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP930]),
> +	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP929]),
> +	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP928]),

    These should be sorted downwards by MSTPxxx index, no?

WBR, Sergei

