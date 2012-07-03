From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 03 Jul 2012 10:12:27 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: add REGULATOR settings to kzm9g_defconfig
Message-Id: <Pine.LNX.4.64.1207031207110.29890@axis700.grange>
List-Id: <linux-sh.vger.kernel.org>
References: <4FF2C282.5030000@kmckk.co.jp>
In-Reply-To: <4FF2C282.5030000@kmckk.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello

On Tue, 3 Jul 2012, Tetsuyuki Kobayashi wrote:

> Add REGULATOR settings to kernel config file of kzm9g.
> 
> Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
> ---
> Hello, 
> 
> I found Guennadi's
> "ARM: mach-shmobile: add fixed voltage regulators to kzm9g"
> requires REGULATOR setting in kernel config.
> Without this, it causes these errors at boot time.

Thanks for the patch. However, I think, this error will only appear if you 
enable REGULATOR in the kernel, but both REGULATOR_FIXED_VOLTAGE and 
REGULATOR_DUMMY are disabled. To fix this fixing the defconfig is good, 
but not sufficient, I think. How about adding something like

	select REGULATOR_FIXED_VOLTAGE if REGULATOR

to either the CPU or the arch section in respective Kconfig? I would 
actually propose to add these to both arm/mach-shmobile and sh. Any 
objections?

Thanks
Guennadi

> smsc911x: Driver version 2008-10-21
> smsc911x smsc911x.0: Failed to get supply 'vdd33a': -517
> smsc911x smsc911x.0: (unregistered net_device): couldn't get regulators -517
> platform smsc911x.0: Driver smsc911x requests probe deferral
> 
> 
> After applying this patch,
>  make kzm9g_defconfig
>  make menuconfig (as you like)
>  make uImage
> 
> smsc911x ethernet device works well as before.
> 
> 
>  arch/arm/configs/kzm9g_defconfig |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/configs/kzm9g_defconfig b/arch/arm/configs/kzm9g_defconfig
> index 7b2eecd..d2df401 100644
> --- a/arch/arm/configs/kzm9g_defconfig
> +++ b/arch/arm/configs/kzm9g_defconfig
> @@ -82,6 +82,9 @@ CONFIG_I2C_CHARDEV=y
>  CONFIG_I2C_SH_MOBILE=y
>  CONFIG_GPIO_PCF857X=y
>  # CONFIG_HWMON is not set
> +CONFIG_REGULATOR=y
> +CONFIG_REGULATOR_DUMMY=y
> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_FB=y
>  CONFIG_FB_SH_MOBILE_LCDC=y
>  CONFIG_FRAMEBUFFER_CONSOLE=y
> -- 1.7.9.5 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
