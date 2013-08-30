From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 30 Aug 2013 17:26:13 +0000
Subject: Re: [RFC 04/10] i2c: rcar: modify I2C driver
Message-Id: <5220D5B5.3080009@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1377866264-21110-5-git-send-email-ulrich.hecht@gmail.com>
In-Reply-To: <1377866264-21110-5-git-send-email-ulrich.hecht@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 08/30/2013 04:37 PM, Ulrich Hecht wrote:

> From: Nguyen Viet Dung <nv-dung@jinso.co.jp>

> This patch modify calculate for clock in I2C driver.

    Maybe "modifies clock calculation" instead?

> Signed-off-by: Nguyen Viet Dung <nv-dung@jinso.co.jp>
> ---
>   drivers/i2c/busses/i2c-rcar.c | 17 +++++++++++++++--
>   include/linux/i2c/i2c-rcar.h  |  4 ++++
>   2 files changed, 19 insertions(+), 2 deletions(-)

> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 0fc5858..c4fb69c 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
[...]
> @@ -287,7 +300,7 @@ scgd_find:
>   	/*
>   	 * keep icccr value
>   	 */
> -	priv->icccr = (scgd << 2 | cdf);
> +	priv->icccr = (scgd << (cdf_width) | cdf);

    Parens not needed here at all (if only around <<).

WBR, Sergei

