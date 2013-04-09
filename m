From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 09 Apr 2013 12:19:16 +0000
Subject: Re: [RFC][PATCH 2/4] ARM: shmobile: r8a7778: fixup Ether setup code position
Message-Id: <51640744.4020707@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <874nfgb74b.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <874nfgb74b.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 09-04-2013 11:59, Simon Horman wrote:

>> Ether setup code position was scattering.
>> This patch fixes it up

> Thanks, queued-up in the shc-r8a7778 branch.

>> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
>> ---
>>   arch/arm/mach-shmobile/setup-r8a7778.c |   28 ++++++++++++++--------------
>>   1 file changed, 14 insertions(+), 14 deletions(-)

>> diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
>> index 30b4a33..d6ee521 100644
>> --- a/arch/arm/mach-shmobile/setup-r8a7778.c
>> +++ b/arch/arm/mach-shmobile/setup-r8a7778.c
>> @@ -80,12 +80,6 @@ static struct sh_timer_config sh_tmu1_platform_data = {
[...]
>> +/* Ether */
>> +static struct resource ether_resources[] = {
>> +	DEFINE_RES_MEM(0xfde00000, 0x400),
>> +	DEFINE_RES_IRQ(gic_iid(0x89)),
>> +};
>> +
>> +void __init r8a7778_add_ether_device(struct sh_eth_plat_data *pdata)
>> +{
>> +	platform_device_register_resndata(&platform_bus, "sh_eth", -1,

> BTW, s/sh_eth/sh-eth/ ? Also for r8a7778?

    Yes, sorry for this mistake, I'll fix it. Unfortunately, I couldn't test it...

WBR, Sergei

