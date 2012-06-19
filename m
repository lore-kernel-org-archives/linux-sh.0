From: Simon Horman <horms@verge.net.au>
Date: Tue, 19 Jun 2012 08:06:46 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: Support Real Time Clock
Message-Id: <20120619080646.GB25674@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <4FE00E7E.8030406@kmckk.co.jp>
In-Reply-To: <4FE00E7E.8030406@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jun 19, 2012 at 02:30:38PM +0900, Tetsuyuki Kobayashi wrote:
> Hello, this is my first patch to this ML.
> 
> This depends on Morimoto-san's 
> [PATCH 0/27] ARM: shmobile: resend patch set
> 
> 
> 
> 
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

Hi Kobayashi-san,

I have verified that your patch works using the hwclock commands above.

Tested-by: Simon Horman <horms@verge.net.au>

