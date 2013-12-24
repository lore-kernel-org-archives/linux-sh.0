From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Tue, 24 Dec 2013 20:44:01 +0000
Subject: Re: [PATCH RFC 3/3] [RFC] ARM: shmobile: genmai: Enable r7s72100-gether
Message-Id: <52BA000D.1050200@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387095886-15163-1-git-send-email-horms+renesas@verge.net.au> <1387095886-15163-4-git-send-email-horms+renesas@verge.net.au> <52AE11A7.6090407@cogentembedded.com> <20131216013054.GA3192@verge.net.au>
In-Reply-To: <20131216013054.GA3192@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

On 12/16/2013 04:30 AM, Simon Horman wrote:

>>     You forgot to sign off.

>> [...]

>>> diff --git a/arch/arm/mach-shmobile/board-genmai.c b/arch/arm/mach-shmobile/board-genmai.c
>>> index 3e92e3c..838325b 100644
>>> --- a/arch/arm/mach-shmobile/board-genmai.c
>>> +++ b/arch/arm/mach-shmobile/board-genmai.c
>>> @@ -20,15 +20,35 @@
>>>
>>>   #include <linux/kernel.h>
>>>   #include <linux/platform_device.h>
>>> +#include <linux/sh_eth.h>
>>>   #include <mach/common.h>
>>> +#include <mach/irqs.h>
>>>   #include <mach/r7s72100.h>
>>>   #include <asm/mach-types.h>
>>>   #include <asm/mach/arch.h>
>>>
>>> +/* GEther */
>>> +static const struct sh_eth_plat_data gether_pdata __initconst = {
>>> +	.phy			= 0x00, /* PD60610 */
>>> +	.edmac_endian		= EDMAC_LITTLE_ENDIAN,
>>> +	.phy_interface		= PHY_INTERFACE_MODE_MII,

>>     Does MII work for Gigabit Ethernet?

> My understanding is that although the SH ethernet block on
> the SoC supports Gigabit it is only wired up to allow 100Mbit
> access on the board and that MII is the interface used.

    No, it's the SoC manual that limits the Ethernet speed to 100 Mbps.

WBR, Sergei

