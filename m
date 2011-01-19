From: Yusuke Goda <yusuke.goda.sx@renesas.com>
Date: Wed, 19 Jan 2011 00:47:54 +0000
Subject: Re: [PATCH] [rfc] ARM: mach-shmobile: mackerel: clarify shdi/mmcif
Message-Id: <4D3634BA.8010205@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1291849274-8115-1-git-send-email-horms@verge.net.au>
In-Reply-To: <1291849274-8115-1-git-send-email-horms@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon-san

(2011/01/19 9:32), Simon Horman wrote:
> Hi Goda-san,
> 
> On Tue, Jan 11, 2011 at 04:30:38PM +0900, Yusuke Goda wrote:
>> Hi Simon-san
>>
>> (2011/01/08 7:26), Simon Horman wrote:
>>> * Pins 2 and 4 of switch 33 are documented as don't care on the PCB,
>>>   my testing seems to confirm this.
>> I approve of your patch.
> 
> Great. Can I take that to mean that Paul can merge this change?
Yes!
I think so.

Thanks,
Goda
> 
>> Pins 2 and 4 of switch 33 dont' care in mackerel.
>> There was a mistake in the Users Manual.
>> I asked a designer to revise Users Manual.
>> Thank you for your indication.
>>
>>> * I have been unable to do anything sensible with S1 set to on.
>>>   Am I missing something with regards to MMC1?
>> SW1 ON : Can not use MCP(NOR, NAND) and Ether
>> Therefore, u-boot does not start.
>>
>>> * Clarify which driver is needed for each switch setting.
>>>
>>> * Should the AP4 board code be updated to allow the
>>>   SHDI driver to access SHDI1 as the mackerel code does?
>> In AP4, pins 2 and 4 of switch 33 should care.
>>
>> Thanks,
>> Goda
>>
>>> Signed-off-by: Simon Horman <horms@verge.net.au>
>>> ---
>>>  arch/arm/mach-shmobile/board-mackerel.c |    5 ++---
>>>  1 files changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-shmobile/board-mackerel.c b/arch/arm/mach-shmobile/board-mackerel.c
>>> index 42f7c0d..b190248 100644
>>> --- a/arch/arm/mach-shmobile/board-mackerel.c
>>> +++ b/arch/arm/mach-shmobile/board-mackerel.c
>>> @@ -167,9 +167,8 @@
>>>   *	SW1	|	SW33
>>>   *		| bit1 | bit2 | bit3 | bit4
>>>   * -------------+------+------+------+-------
>>> - * MMC0	  OFF	|  OFF |  ON  |  ON  |  X
>>> - * MMC1	  ON	|  OFF |  ON  |  X   | ON
>>> - * SDHI1  OFF	|  ON  |   X  |  OFF | ON
>>> + * MMC0   OFF	|  OFF |   X  |  ON  |  X       (Use MMCIF)
>>> + * SDHI1  OFF	|  ON  |   X  |  OFF |  X       (Use MFD_SH_MOBILE_SDHI)
>>>   *
>>>   */
>>>  
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 

