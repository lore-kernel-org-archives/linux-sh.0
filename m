From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Thu, 08 May 2014 22:03:37 +0000
Subject: Re: [PATCH 3/6] i2c: rcar: do not print error if device nacks transfer
Message-Id: <536BFF39.40607@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1390752337-22386-1-git-send-email-ben.dooks@codethink.co.uk> <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390752337-22386-4-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>, linux-kernel@lists.codethink.co.uk
Cc: Simon Horman <horms+renesas@verge.net.au>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 01/26/2014 07:05 PM, Ben Dooks wrote:

> The i2c-rcar driver currently prints an error message if the master_xfer
> callback fails. However if the bus is being probed then lots of NAKs
> will be generated, causing the output of a number of errors printed.

> To solve this, disable the print if the error is not -EREMOTEIO.

> An example of running i2cdetect:

> 10: i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- 12 i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15
> -- i2c-rcar e6530000.i2c: error -121 : 15

> Cc: Simon Horman <horms+renesas@verge.net.au>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>   drivers/i2c/busses/i2c-rcar.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/i2c/busses/i2c-rcar.c b/drivers/i2c/busses/i2c-rcar.c
> index 2c2fd7c..0d25104 100644
> --- a/drivers/i2c/busses/i2c-rcar.c
> +++ b/drivers/i2c/busses/i2c-rcar.c
> @@ -623,7 +623,7 @@ static int rcar_i2c_master_xfer(struct i2c_adapter *adap,
>
>   	pm_runtime_put(dev);
>
> -	if (ret < 0)
> +	if (ret < 0 && ret != -EREMOTEIO)
>   		dev_err(dev, "error %d : %x\n", ret, priv->flags);

    Hm, I'm now getting -EBUSY and -EAGAIN running i2cdetect on R8A7791 base 
Henninger board. Only when I comment out the above 2 lines, I can get the bus 
scanned, otherwise I don't see any devices at all.

WBR, Sergei

