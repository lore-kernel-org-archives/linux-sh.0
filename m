From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Wed, 14 Jan 2015 11:22:51 +0000
Subject: Re: [PATCH] spi: sh-msiof: Update calculation of frequency dividing
Message-Id: <54B6518B.4080607@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1421220335-22503-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1421220335-22503-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>, linux-spi@vger.kernel.org
Cc: linux-sh@vger.kernel.org, geert@glider.be, yoshihiro.shimoda.uh@renesas.com

Hello.

On 1/14/2015 10:25 AM, Nobuhiro Iwamatsu wrote:

> sh-msiof of frequency dividing does not perform the calculation, driver have
> to manage setting value in the table. It is not possible to set frequency
> dividing value close to the actual data in this way. This changes from
> frequency dividing of table management to setting by calculation.
> This driver is able to set a value close to the actual data.

> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
> ---
>   drivers/spi/spi-sh-msiof.c | 39 +++++++++++++++++----------------------
>   1 file changed, 17 insertions(+), 22 deletions(-)

> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index 96a5fc0..58b1bfe 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -241,42 +241,37 @@ static irqreturn_t sh_msiof_spi_irq(int irq, void *data)
[...]
> -	k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_clk_table) - 1);
> -
> -	sh_msiof_write(p, TSCR, sh_msiof_spi_clk_table[k].scr);
> +	scr = sh_msiof_spi_div_table[k].brdv | (brps -1) << 8;

    You forgot a space after '-'.

[...]

WBR, Sergei

