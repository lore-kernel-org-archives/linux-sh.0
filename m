From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 20 Aug 2013 14:27:33 +0000
Subject: Re: [PATCH 2/2] sh_eth: remove 'register_type' field from 'struct sh_eth_plat_data'
Message-Id: <52137CD5.1040902@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201308180308.39941.sergei.shtylyov@cogentembedded.com> <201308180313.26607.sergei.shtylyov@cogentembedded.com> <3069255.T0Cvttgz9W@avalon>
In-Reply-To: <3069255.T0Cvttgz9W@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, lethal@linux-sh.org, linux-sh@vger.kernel.org

Hello.

On 20-08-2013 14:51, Laurent Pinchart wrote:

>> Now that the 'register_type' field of the 'sh_eth' driver's platform data is
>> not used by the driver anymore, it's time to remove it and  its
>> initializers from the SH platform code. Also  move *enum* declaring values
>> for this  field from <linux/sh_eth.h>  to  the  local driver's  header file
>> as they're only needed by the driver itself  now...

>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/mach-shmobile/board-armadillo800eva.c |    1 -
>>   arch/arm/mach-shmobile/board-bockw.c           |    1 -
>>   arch/sh/boards/board-espt.c                    |    1 -
>>   arch/sh/boards/board-sh7757lcr.c               |    4 ----
>>   arch/sh/boards/mach-ecovec24/setup.c           |    1 -
>>   arch/sh/boards/mach-se/7724/setup.c            |    1 -
>>   arch/sh/boards/mach-sh7763rdp/setup.c          |    1 -
>>   arch/sh/kernel/cpu/sh2/setup-sh7619.c          |    1 -
>>   drivers/net/ethernet/renesas/sh_eth.h          |    7 +++++++
>>   include/linux/sh_eth.h                         |    7 -------
>>   10 files changed, 7 insertions(+), 18 deletions(-)

> [snip]

>> Index: net-next/drivers/net/ethernet/renesas/sh_eth.h
>> =================================>> --- net-next.orig/drivers/net/ethernet/renesas/sh_eth.h
>> +++ net-next/drivers/net/ethernet/renesas/sh_eth.h
>> @@ -157,6 +157,13 @@ enum {
>>   	SH_ETH_MAX_REGISTER_OFFSET,
>>   };
>>
>> +enum {
>> +	SH_ETH_REG_GIGABIT,
>> +	SH_ETH_REG_FAST_RCAR,
>> +	SH_ETH_REG_FAST_SH4,
>> +	SH_ETH_REG_FAST_SH3_SH2
>> +};
>> +

> Would it make sense to move this change and the one below to a separate patch
> to be merged through the net tree ?

    I'm intending to merge these patches thru the net-next tree.

>>   /* Driver's parameters */
>>   #if defined(CONFIG_CPU_SH4) || defined(CONFIG_ARCH_SHMOBILE)
>>   #define SH4_SKB_RX_ALIGN	32
>> Index: net-next/include/linux/sh_eth.h
>> =================================>> --- net-next.orig/include/linux/sh_eth.h
>> +++ net-next/include/linux/sh_eth.h
>> @@ -5,17 +5,10 @@
>>   #include <linux/if_ether.h>
>>
>>   enum {EDMAC_LITTLE_ENDIAN, EDMAC_BIG_ENDIAN};
>> -enum {
>> -	SH_ETH_REG_GIGABIT,
>> -	SH_ETH_REG_FAST_RCAR,
>> -	SH_ETH_REG_FAST_SH4,
>> -	SH_ETH_REG_FAST_SH3_SH2
>> -};
>>
>>   struct sh_eth_plat_data {
>>   	int phy;
>>   	int edmac_endian;

> Wouldn't it make sense to move the edmac_endian field to sh_eth_cpu_data as
> well ?

    No, it depends on the SoC endianness which is determined by power-on pin 
strapping -- which is board specific.

WBR, Sergei

