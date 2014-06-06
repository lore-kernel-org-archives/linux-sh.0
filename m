From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 06 Jun 2014 06:49:09 +0000
Subject: Re: [PATCH 00/08] ARM: shmobile: Suspend on non-SMP update for r8a7790
Message-Id: <CANqRtoTFaAKUBLYKpF9iY5h8RKUck4r7g_7faWGDGCDGRaL7MA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140605051505.18075.76727.sendpatchset@w520>
In-Reply-To: <20140605051505.18075.76727.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi again Geert,

On Fri, Jun 6, 2014 at 6:34 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> On Thu, Jun 5, 2014 at 5:01 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> Things like (in [6/8]):
>>
>>  void __init shmobile_smp_apmu_suspend_init(void)
>>  {
>> +#ifndef CONFIG_SMP
>> +       /* initialize APMU for non-SMP case */
>> +       shmobile_smp_apmu_prepare_cpus(1);
>> +#endif
>>         shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
>>  }
>>  #else
>>
>> can look really confusing: shmobile_*SMP*_apmu_suspend_init() has a
>> !CONFIG_SMP section calling into shmobile_*SMP*_apmu_prepare_cpus()
>> (the latter is OK, due to the "1" parameter indicating there's only one CPU).
>
> I agree that this portion is far from pretty. Ideally in my opinion
> the ARM SMP callbacks should be updated to allow executing some SMP
> setup code even though UP is used. Right now we need to call setup
> code from various directions depending on mode which results in
> italian pasta dish coding. =)

To try to improve the situation I'm considering adding a single setup
function for mach-shmobile. I was playing around with a similar
approach earlier but I could at that time not get any positive
comments about setting up the smp_ops dynamically. In general I think
it makes sense to setup a lot of similar callbacks from C instead of
explicitly adding them to each and every SoC and board mach vector.
Perhaps we could also deal with UP vs SMP at the same time?

The idea with the code below would be to allow passing two pointers to
the setup code:
1) function pointer for UP case
2) smp_ops pointer for SMP setup case

The setup function (shmobile_init_cpus() below) would be responsible
for the following:
- if running as smp then register the smp_ops
- if running as up then call the function pointer for setup
- execute shmobile_init_delay()
- install shmobile_init_late in the machine vector

For the common case every machine vector we would only need dt_compat
and init_early.

What do you think?

Cheers,

/ magnus

--- 0007/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c   2014-06-06
15:34:37.000000000 +0900
@@ -41,17 +41,20 @@ static void __init emev2_map_io(void)
        iotable_init(emev2_io_desc, ARRAY_SIZE(emev2_io_desc));
 }

+extern struct smp_operations emev2_smp_ops;
+
+static void __init emev2_init(void)
+{
+       shmobile_init_cpus(NULL, smp_ops(emev2_smp_ops));
+}
+
 static const char *emev2_boards_compat_dt[] __initconst = {
        "renesas,emev2",
        NULL,
 };

-extern struct smp_operations emev2_smp_ops;
-
 DT_MACHINE_START(EMEV2_DT, "Generic Emma Mobile EV2 (Flattened Device Tree)")
-       .smp            = smp_ops(emev2_smp_ops),
        .map_io         = emev2_map_io,
-       .init_early     = shmobile_init_delay,
-       .init_late      = shmobile_init_late,
+       .init_early     = emev2_init,
        .dt_compat      = emev2_boards_compat_dt,
 MACHINE_END
../foo.patch lines 14-36/36 (END)
