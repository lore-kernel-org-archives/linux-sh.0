From: Simon Horman <horms@verge.net.au>
Date: Mon, 10 Nov 2014 01:02:25 +0000
Subject: Re: [PATCH 1/5] ARM: shmobile: kzm9g legacy: Set i2c clks_per_count to 2
Message-Id: <20141110010225.GF16836@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1415274730-310-1-git-send-email-geert+renesas@glider.be>
 <1415274730-310-2-git-send-email-geert+renesas@glider.be>
 <20141107052420.GA1278@katana>
In-Reply-To: <20141107052420.GA1278@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

On Fri, Nov 07, 2014 at 06:24:21AM +0100, Wolfram Sang wrote:
> On Thu, Nov 06, 2014 at 12:52:06PM +0100, Geert Uytterhoeven wrote:
> > On sh73a0/kzm9g-legacy, probing of the i2c masters fails with:
> > 
> >     i2c-sh_mobile i2c-sh_mobile.0: timing values out of range: L/H=0x208/0x1bf
> >     sh_mobile: probe of i2c-sh_mobile.0 failed with error -22
> 
> Yay, so the warning I added found another bug \o/
> 
> > 
> > According to the datasheet, the transfer rate is derived from the HP
> > clock (which runs at 104 MHz) divided by two. Hence
> > i2c_sh_mobile_platform_data.clks_per_count should be set to two.
> > 
> > Now probing succeeds, and i2c works:
> > 
> >     i2c-sh_mobile i2c-sh_mobile.0: I2C adapter 0 with bus speed 100000 Hz (L/H=0x104/0xe0)
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks, I have queued this up.

