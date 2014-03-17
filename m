From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Mon, 17 Mar 2014 12:12:12 +0000
Subject: Re: [Linux-kernel] [RFC 3/6] ARM: shmobile: add sh_pm_runtime_init() to header
Message-Id: <5326E69C.5030409@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1395055999.12161.116.camel@xylophone>
In-Reply-To: <1395055999.12161.116.camel@xylophone>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hello.

On 17-03-2014 15:33, Ben Hutchings wrote:

>> Add definition of sh_pm_runtime_init() to machine header to allow calling

> declaration not definition

>> the pm_runtime initialisation code.

>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> ---
>>   arch/arm/mach-shmobile/include/mach/common.h | 2 ++
>>   1 file changed, 2 insertions(+)

>> diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
>> index cb8e32d..4727d4f 100644
>> --- a/arch/arm/mach-shmobile/include/mach/common.h
>> +++ b/arch/arm/mach-shmobile/include/mach/common.h
>> @@ -52,4 +52,6 @@ static inline void __init shmobile_init_late(void)
>>   	shmobile_cpuidle_init();
>>   }
>>
>> +extern int sh_pm_runtime_init(void);
>> +
>>   #endif /* __ARCH_MACH_COMMON_H */

> The declaration should include '__init'

    Since when? It makes no sense for declarations.

> and need not include 'extern'.

WBR, Sergei

