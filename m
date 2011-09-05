From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 05 Sep 2011 04:19:47 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: ag5evm needs CONFIG_I2C
Message-Id: <20110905041947.GC22142@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Aug 30, 2011 at 06:19:13PM +0200, Guennadi Liakhovetski wrote:
> ag5evm implements a backlight control, using an I2C controller, therefore
> it needs CONFIG_I2C to fix this make failure
> 
> arch/arm/mach-shmobile/built-in.o: In function `lcd_on':
> pfc-sh73a0.c:(.text+0x2334): undefined reference to `i2c_get_adapter'
> pfc-sh73a0.c:(.text+0x2370): undefined reference to `i2c_transfer'
> 
> (ignore pfc-sh73a0.c) and to build successfully.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Applied, thanks.
