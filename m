From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 20 Jun 2012 06:10:45 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: Support Real Time Clock
Message-Id: <87a9zyfr8g.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4FE00E7E.8030406@kmckk.co.jp>
In-Reply-To: <4FE00E7E.8030406@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> KZM-A9-GT board has RTC device r2025d at I2C channel 0
> with slave address 0x64.
> 
> This patch enables reading and writing hardware real time clock on
> KZM-A9-GT board. Interrupt is not yet supported.
> 
> How to test this patch using user space command.
> 
> Read RTC
>  # hwclock -r
> 
> Copy system clock to RTC
>  # hwclock -w
> 
> Shutdown and power off the board, and wait a while, then power on again.
> Check RTC still keeps correct date.
> 
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
