From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Apr 2008 08:50:33 +0000
Subject: Re: [PATCH] i2c: SuperH Mobile I2C Bus Controller V5
Message-Id: <20080405105033.3687c785@hyperion.delvare>
List-Id: <linux-sh.vger.kernel.org>
References: <20080402025950.1026.44461.sendpatchset@rx1.opensource.se>
In-Reply-To: <20080402025950.1026.44461.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: i2c@lm-sensors.org, linux-sh@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Ben Dooks <ben-linux@fluff.org>, Andrew Morton <akpm@linux-foundation.org>

Hi Magnus,

On Wed, 02 Apr 2008 11:59:50 +0900, Magnus Damm wrote:
> This is V5 of the SuperH Mobile I2C Controller Driver. A simple Master
> only driver for the I2C block included in processors such as sh7343,
> sh7722 and sh7723. Tested on a sh7722 MigoR using a rs5c732b rtc.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> Signed-off-by: Paul Mundt <lethal@linux-sh.org>
> ---
> 
>  Changes since V4:
>   - Use sh_mobile_i2c_op enum
>   - Remove fast_mode and rx_ack_high code
>   - Use variable name retry_count instead of k
>   - Encoding fixes
>   - Use clk_enable() and clk_disable()
>   - Remove deactivate_ch() call from setup_channel()
>   - Use dev_err() if i2c_add_numbered_adapter() fails
>   - MODULE_LICENSE("GPL v2")
>   - Comment fix, cleaned up header
>  Changes since V3:
>   - Added SUPERH Kconfig dependency
>   - Use spin_lock_irqsave() and spin_unlock_irqrestore()
>   - Use IRQF_DISABLED
>   - Checkpatch fixes
>  Changes since V2:
>   - dev_xxx() use
>   - Kill off superfluous ioarea resource
>   - Add SMBus emulation
>  Changes since V1:
>   - Use clk_get()/clk_put()/clk_get_rate() to get peripheral clock rate.
>   - Use pdev->dev.bus_id instead of dev->name
> 
>  Verified with the rtc-rs5c372 SMBus conversion patches currently in -mm.
> 
>  drivers/i2c/busses/Kconfig         |   10 
>  drivers/i2c/busses/Makefile        |    1 
>  drivers/i2c/busses/i2c-sh_mobile.c |  500 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 511 insertions(+)

Patch added to my i2c tree and queued up for merge in 2.6.26-rc1.
Thanks to everyone who reviewed the previous versions of the driver.

-- 
Jean Delvare
