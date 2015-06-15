From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 15 Jun 2015 10:35:51 +0000
Subject: Re: [PATCH 6/6][RFC] arm64: defconfig: Enable Renesas R-Car Gen3 SoC in defconfig
Message-Id: <CANqRtoTT76FuZbAh4Gd9Hkzqn_V78btNM-8Vp4OOC=ZHAQfNQQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87wpz5vaia.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87wpz5vaia.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Khiem-san,

On Mon, Jun 15, 2015 at 7:05 PM, khiemnguyen
<khiem.nguyen.xt@rvc.renesas.com> wrote:
> Dear Morimoto-san,
>
> Thanks for your patch.
>
> On 6/15/2015 11:54 AM, Kuninori Morimoto wrote:
>>
>> This patch enables Renesas R-Car Gen3 SoCs in the arm64 defconfig.
>>
>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>   arch/arm64/configs/defconfig | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
>> index 866640b..b175c2a 100644
>> --- a/arch/arm64/configs/defconfig
>> +++ b/arch/arm64/configs/defconfig
>> @@ -34,6 +34,7 @@ CONFIG_MODULE_UNLOAD=y
>>   CONFIG_ARCH_EXYNOS7=y
>>   CONFIG_ARCH_FSL_LS2085A=y
>>   CONFIG_ARCH_MEDIATEK=y
>> +CONFIG_ARCH_RCAR_GEN3=y
>>   CONFIG_ARCH_SEATTLE=y
>>   CONFIG_ARCH_TEGRA=y
>>   CONFIG_ARCH_TEGRA_132_SOC=y
>> @@ -102,6 +103,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
>>   CONFIG_SERIAL_8250_MT6577=y
>>   CONFIG_SERIAL_AMBA_PL011=y
>>   CONFIG_SERIAL_AMBA_PL011_CONSOLE=y
>> +CONFIG_SERIAL_SH_SCI=m
>
>
> I wonder whether we can use built-in module, instead of dynamic module.
> Is there any strong reason for using dynamic module ?

Thanks, I agree with your question. =)

Also, what I can tell it seems that the DTS does not include any SCIF
nodes, so enabling the SCIF here in the defconfig seems a bit of a
mismatch.

Best,

/ magnus
