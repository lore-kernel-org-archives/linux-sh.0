From: Simon Horman <horms@verge.net.au>
Date: Fri, 27 Feb 2015 01:49:11 +0000
Subject: Re: [PATCH v4 3/9] DT: i2c: add trivial binding for OKI ML86V7667 video decoder
Message-Id: <20150227014911.GB31738@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1424968934-30577-4-git-send-email-ulrich.hecht+renesas@gmail.com>
In-Reply-To: <1424968934-30577-4-git-send-email-ulrich.hecht+renesas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

[CC Wolfram]

On Thu, Feb 26, 2015 at 05:42:08PM +0100, Ulrich Hecht wrote:
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks, I have queued this up with Wolfram's ack which he provided
for an older patch which included this change.

> ---
>  Documentation/devicetree/bindings/i2c/trivial-devices.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/trivial-devices.txt b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> index aaa8325..7cbd62b 100644
> --- a/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +++ b/Documentation/devicetree/bindings/i2c/trivial-devices.txt
> @@ -77,6 +77,7 @@ nxp,pca9556		Octal SMBus and I2C registered interface
>  nxp,pca9557		8-bit I2C-bus and SMBus I/O port with reset
>  nxp,pcf8563		Real-time clock/calendar
>  nxp,pcf85063		Tiny Real-Time Clock
> +oki,ml86v7667		OKI ML86V7667 video decoder
>  ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
>  pericom,pt7c4338	Real-time Clock Module
>  plx,pex8648		48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
> -- 
> 2.2.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
