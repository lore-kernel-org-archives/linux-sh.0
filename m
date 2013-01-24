From: Wolfram Sang <w.sang@pengutronix.de>
Date: Thu, 24 Jan 2013 07:27:48 +0000
Subject: Re: [PATCH 0/4] i2c: sh_mobile: fix STOP condition generation
Message-Id: <20130124072748.GK8364@nekote.pengutronix.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1358415957-8371-1-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-i2c@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

On Thu, Jan 17, 2013 at 10:45:53AM +0100, Guennadi Liakhovetski wrote:
> Currently the i2c-sh_mobile.c driver generates STOP conditions after each 
> message. This makes any multi-message transfers, e.g. reading, impossible 
> with the AS3711 PMIC on kzm9g. This patch series fixes this by only 
> generating the STOP condition after the last message or if the I2C_M_STOP 
> flag is set.
> 
> Guennadi Liakhovetski (4):
>   i2c: i2c-sh_mobile.c: cosmetic: trivially simplify 2 functions
>   i2c: sh_mobile: fix timeout error handling
>   i2c: sh_mobile: eliminate an open-coded "goto" loop
>   i2c: sh_mobile: don't send a stop condition by default inside
>     transfers

Looks good to me. I have to mention usleep_range, though. I leave it to
you if you want to fix it or not. Other than that, I would apply the
series.
