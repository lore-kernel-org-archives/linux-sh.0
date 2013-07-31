From: Chen Gang <gang.chen@asianux.com>
Date: Wed, 31 Jul 2013 08:37:20 +0000
Subject: Re: [PATCH] sh: kernel: cpu: provide 'NULL' parameter for calling cpuidle_register().
Message-Id: <51F8CCC0.1090302@asianux.com>
List-Id: <linux-sh.vger.kernel.org>
References: <51F8BB73.2070603@asianux.com>
In-Reply-To: <51F8BB73.2070603@asianux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On 07/31/2013 03:35 PM, Daniel Lezcano wrote:
> On 07/31/2013 09:23 AM, Chen Gang wrote:
>> Need provide additional parameter for calling cpuidle_register() just
>> like some of another architectures have done, or can not pass compiling.
>>
>> The related error (with kfr2r09_defconfig):
>>
>>     CC      arch/sh/kernel/cpu/shmobile/cpuidle.o
>>   arch/sh/kernel/cpu/shmobile/cpuidle.c: In function 'sh_mobile_setup_cpuidle':
>>   arch/sh/kernel/cpu/shmobile/cpuidle.c:102:2: error: too few arguments to function 'cpuidle_register'
>>     return cpuidle_register(&cpuidle_driver);
>>     ^
>>   In file included from arch/sh/kernel/cpu/shmobile/cpuidle.c:16:0:
>>   include/linux/cpuidle.h:130:12: note: declared here
>>    extern int cpuidle_register(struct cpuidle_driver *drv,
>>             ^
>>
>> Signed-off-by: Chen Gang <gang.chen@asianux.com>
>> ---
> 
> Thanks for the patch.
> 
> I have the same fix in my tree sent by Geert Uytterhoeven
> 
>   -- Daniel
> 
> 

OK, thanks, and I will send another patches.

:-)

-- 
Chen Gang
