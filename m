From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 18 Feb 2013 05:46:01 +0000
Subject: Re: [PATCH 01/06] ARM: shmobile: Kill off sh73a0 scu_base_addr() function
Message-Id: <CANqRtoQThssWmy1yv8NPgHpf5eH5ANuSK+Jn+QuP-wY7=Y7Ehg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130213134628.12153.47120.sendpatchset@w520>
 <20130213134638.12153.54737.sendpatchset@w520>
 <201302161235.10950.arnd@arndb.de>
In-Reply-To: <201302161235.10950.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Arnd,

On Sat, Feb 16, 2013 at 9:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 13 February 2013, Magnus Damm wrote:
>
>> -}
>> +#define SH73A0_SCU_BASE IOMEM(0xf0000000)
>> +
>> +static void __iomem *shmobile_scu_base;
>>
>>  #ifdef CONFIG_HAVE_ARM_TWD
>> -static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, 0xf0000600, 29);
>> +static DEFINE_TWD_LOCAL_TIMER(twd_local_timer, SH73A0_SCU_BASE + 0x600, 29);
>
> This is causing a build warning in linux-next:
>
> arch/arm/mach-shmobile/smp-sh73a0.c:45:15: warning: initialization makes integer from pointer without a cast [enabled by default]
> arch/arm/mach-shmobile/smp-sh73a0.c:45:15: warning: (near initialization for 'twd_local_timer.res[0].start') [enabled by default]
> arch/arm/mach-shmobile/smp-sh73a0.c:45:15: warning: initialization makes integer from pointer without a cast [enabled by default]
> /arch/arm/mach-shmobile/smp-sh73a0.c:45:15: warning: (near initialization for 'twd_local_timer.res[0].end') [enabled by default]
>
> The problem is that DEFINE_TWD_LOCAL_TIMER expects a physical
> address to pass into ioremap(), while you are passing
> an __iomem token.

Thanks, will fix up.

/ magnus
