From: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 23 Feb 2015 13:08:42 +0000
Subject: Re: [PATCH/RFC] i2c: rcar: Support ACK by HW auto restart after NACK
Message-Id: <2775fbb6b2e2b333ef2457133f419d4d@the-dreams.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1424011480-3551-1-git-send-email-ykaneko0929@gmail.com>
In-Reply-To: <1424011480-3551-1-git-send-email-ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Hi,

On 2015-02-15 15:44, Yoshihiro Kaneko wrote:
> From: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
>
> Even if R-Car I2C received NACK, after that it might receive ACK
> by HW auto restart. In case of that, driver would continue process.
> If R-Car I2C didn't receive ACK, the driver would detect timeout
> and would report NACK as -ENXIO.
>
> Signed-off-by: Ryo Kataoka <ryo.kataoka.wt@renesas.com>
> Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>

Excuse me, but what exactly is HW auto restart in this case? Is it a 
feature of the I2C slave?

Thanks,

    Wolfram

