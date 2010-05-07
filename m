From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Fri, 07 May 2010 10:15:31 +0000
Subject: Re: [PATCH] sh: modify pinmux for SH7757 2nd cut
Message-Id: <4BE3E843.1010905@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4BE3DC84.4070203@renesas.com>
In-Reply-To: <4BE3DC84.4070203@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Paul Mundt wrote:
> On Fri, May 07, 2010 at 06:25:24PM +0900, Yoshihiro Shimoda wrote:
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> ---
>>  arch/sh/include/cpu-sh4/cpu/sh7757.h    |  301 +++---
>>  arch/sh/kernel/cpu/sh4a/pinmux-sh7757.c | 1582 ++++++++++++++++++-------------
>>  2 files changed, 1081 insertions(+), 802 deletions(-)
>>
>> diff --git a/arch/sh/include/cpu-sh4/cpu/sh7757.h b/arch/sh/include/cpu-sh4/cpu/sh7757.h
>> index f4d267e..15f3de1 100644
>> --- a/arch/sh/include/cpu-sh4/cpu/sh7757.h
>> +++ b/arch/sh/include/cpu-sh4/cpu/sh7757.h
>> @@ -3,241 +3,252 @@
>>
>>  enum {
>>  	/* PTA */
>> -	GPIO_PTA7, GPIO_PTA6, GPIO_PTA5, GPIO_PTA4,
>> -	GPIO_PTA3, GPIO_PTA2, GPIO_PTA1, GPIO_PTA0,
>> +	GPIO_PTA0, GPIO_PTA1, GPIO_PTA2, GPIO_PTA3,
>> +	GPIO_PTA4, GPIO_PTA5, GPIO_PTA6, GPIO_PTA7,
>>
> This looks like the pinout has been completely inverted. Presumably if
> this is added then support for the 1st cut will be completely broken?
> 

Yes, I would like to remove the 1st cut supporting because it is prototype CPU.

Thanks,
Yoshihiro Shimoda
