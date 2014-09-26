From: Khiem Nguyen <khiem.nguyen.xt@renesas.com>
Date: Fri, 26 Sep 2014 10:20:29 +0000
Subject: Re: [PATCH RFC 0/7] ARM: shmobile: Support L2 shutdown mode in Suspend-to-RAM
Message-Id: <54253DED.2030209@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5424D1ED.6070309@renesas.com>
In-Reply-To: <5424D1ED.6070309@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert-san,

On 9/26/2014 7:04 PM, Geert Uytterhoeven wrote:
> Hi Khiem-san,
> 
> On Fri, Sep 26, 2014 at 4:39 AM, Khiem Nguyen
> <khiem.nguyen.xt@renesas.com> wrote:
>> These patches implement L2 shutdown mode in RCar Gen2 SoC and change
>> Suspend-to-RAM from Core Standby mode to L2 shutdown mode.
>> The impact to CPUIdle operation was also put into consideration during
>> implementation.
>>
>> I have confirmed Suspend-to-RAM in Lager board and Koelsch board.
>> So far, there is no regression detected during my testing.
>> There might be further patches to support Alt board. But it would be
>> after upstream kernel can boot up in Alt board.
>>
>> I hope to receive some comments for this patch series whether it's
>> right direction or not. Therefore, I marked it with RFC.
>> Any comments are appreciated.
> 
> While testing with various combinations of CONFIG_PM options, I noticed
> the build fails if CONFIG_ARM_CPU_SUSPEND is not set:
> 
> arch/arm/mach-shmobile/built-in.o: In function
> `shmobile_smp_apmu_enter_cpuidle':
> :(.text+0x27c): undefined reference to `cpu_suspend'
> arch/arm/mach-shmobile/built-in.o: In function `shmobile_cpuidle_notifier_call':
> :(.text+0x305c): undefined reference to `cpu_resume'
> arch/arm/mach-shmobile/built-in.o: In function `shmobile_smp_apmu_prepare_cpus':
> :(.init.text+0xddc): undefined reference to `cpu_resume'
> arch/arm/mach-shmobile/built-in.o: In function `shmobile_cpuidle_init':
> :(.init.text+0xe9c): undefined reference to `cpu_resume'
> make[3]: *** [vmlinux] Error 1
> make[2]: *** [sub-make] Error 2
> make[1]: *** [__sub-make] Error 2
> make: *** [all] Error 2
> 
That is interesting build error.
To make it clearer and able to fix it, please kindly confirm below points:
1. This only occurred after merging my patch ?
(The part related to shmobile_cpuidle_init seems out of my scope.)
2. What kind of 'various combinations of CONFIG_PM options' were you select ?

Thanks.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 

-- 
Best regards,
KHIEM Nguyen
