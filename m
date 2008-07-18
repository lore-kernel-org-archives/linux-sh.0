From: Andrew Morton <akpm@linux-foundation.org>
Date: Fri, 18 Jul 2008 23:36:09 +0000
Subject: Re: [PATCH 05/05] sh: add IORESOURCE_CLK to SuperH Mobile I2C
Message-Id: <20080718163609.4eaa2d2d.akpm@linux-foundation.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20080718074002.32713.73442.sendpatchset@rx1.opensource.se>
	<20080718074044.32713.83039.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080718074044.32713.83039.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, gregkh@suse.de, lethal@linux-sh.org, i2c@lm-sensors.org, magnus.damm@gmail.com

On Fri, 18 Jul 2008 16:40:44 +0900
Magnus Damm <magnus.damm@gmail.com> wrote:

> This patch passes processor specific IORESOURCE_CLK information to the
> i2c-sh_mobile driver. With this change the clock to the IIC block will
> be disabled while the I2C bus is inactive. Without this patch the clock
> is always on.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Applies to 6b4b0121a22649640e997b17dd00bb40e97e254d of sh-2.6 git

I can't get this to even vaguely apply to linux-next from 20 minutes ago.
