From: Valentine <valentine.barshak@cogentembedded.com>
Date: Thu, 09 Jan 2014 14:26:11 +0000
Subject: Re: [PATCH 1/3] ARM: shmobile: r8a7790: Add VIN clock support
Message-Id: <52CEB183.2080909@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383060193-1505-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 01/09/2014 12:14 PM, Simon Horman wrote:
> On Wed, Jan 08, 2014 at 08:31:23PM +0400, Valentine Barshak wrote:
>> This adds VIN[0-3] clock support to R8A7790 SoC.
>
> Please place Changes and similar annotations below a "---" line
> to allow git to automatically strip them out for me when I apply your
> patches.

OK, thanks.

>
> ---
>
>>
>> Changes in V2:
>> * none.
>>
>> Changes in V3:
>> * capitalized ARM in the subject.
>>
>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>> ---
>>   arch/arm/mach-shmobile/clock-r8a7790.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>
> There was some fuzz when applying this patch.
> I have queued up the following. Please check that it is correct.

It is correct, thanks.

>
> From: Valentine Barshak <valentine.barshak@cogentembedded.com>
>
> ARM: shmobile: r8a7790: Add VIN clock support
>
> This adds VIN[0-3] clock support to R8A7790 SoC.
>
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> [horms+renesas@verge.net.au: manually applied]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>
> diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
> index 58f3dcf..b2b2323 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7790.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7790.c
> @@ -197,6 +197,7 @@ enum {
>   	MSTP931, MSTP930, MSTP929, MSTP928,
>   	MSTP917,
>   	MSTP813,
> +	MSTP811, MSTP810, MSTP809, MSTP808,
>   	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
>   	MSTP717, MSTP716,
>   	MSTP704,
> @@ -226,6 +227,10 @@ static struct clk mstp_clks[MSTP_NR] = {
>   	[MSTP928] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
>   	[MSTP917] = SH_CLK_MSTP32_STS(&qspi_clk, SMSTPCR9, 17, MSTPSR9, 0), /* QSPI */
>   	[MSTP813] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR8, 13, MSTPSR8, 0), /* Ether */
> +	[MSTP811] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8, 11, MSTPSR8, 0), /* VIN0 */
> +	[MSTP810] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8, 10, MSTPSR8, 0), /* VIN1 */
> +	[MSTP809] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8,  9, MSTPSR8, 0), /* VIN2 */
> +	[MSTP808] = SH_CLK_MSTP32_STS(&zg_clk, SMSTPCR8,  8, MSTPSR8, 0), /* VIN3 */
>   	[MSTP726] = SH_CLK_MSTP32_STS(&zx_clk, SMSTPCR7, 26, MSTPSR7, 0), /* LVDS0 */
>   	[MSTP725] = SH_CLK_MSTP32_STS(&zx_clk, SMSTPCR7, 25, MSTPSR7, 0), /* LVDS1 */
>   	[MSTP724] = SH_CLK_MSTP32_STS(&zx_clk, SMSTPCR7, 24, MSTPSR7, 0), /* DU0 */
> @@ -312,6 +317,10 @@ static struct clk_lookup lookups[] = {
>   	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
>   	CLKDEV_DEV_ID("i2c-rcar_gen2.3", &mstp_clks[MSTP928]),
>   	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
> +	CLKDEV_DEV_ID("r8a7790-vin.0", &mstp_clks[MSTP811]),
> +	CLKDEV_DEV_ID("r8a7790-vin.1", &mstp_clks[MSTP810]),
> +	CLKDEV_DEV_ID("r8a7790-vin.2", &mstp_clks[MSTP809]),
> +	CLKDEV_DEV_ID("r8a7790-vin.3", &mstp_clks[MSTP808]),
>   	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
>   	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
>   	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP502]),
>

Thanks,
Val.
