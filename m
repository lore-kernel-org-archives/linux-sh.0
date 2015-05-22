From: Simon Horman <horms@verge.net.au>
Date: Fri, 22 May 2015 01:32:19 +0000
Subject: Re: [PATCH v2 2/2] input: adxl34x: Add OF match support
Message-Id: <20150522013218.GD27511@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1432208546-18615-1-git-send-email-geert+renesas@glider.be>
 <1432208546-18615-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1432208546-18615-3-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Thu, May 21, 2015 at 01:42:26PM +0200, Geert Uytterhoeven wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> The I2C subsystem can match devices without explicit OF support based on
> the part of their compatible property after the comma. However, this
> mechanism uses the first compatible value only. For adxl34x OF device
> nodes the compatible property will contain the more specific
> "adi,adxl345" or "adi,adxl346" value first. This prevents the device
> node from being matched with the adxl34x driver.
> 
> Fix this by adding an OF match table with an "adi,adxl345" compatible
> entry. There's no need to add the "adi,adxl346" entry as the ADXL346 is
> backward-compatible with the ADXL345 with differences handled by runtime
> detection of the device model.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v2:
>   - Add Reviewed-by.

Reviewed-by: Simon Horman <horms+renesas@verge.net.au>

