From: Gaku Inami <gaku.inami.xw@bp.renesas.com>
Date: Thu, 02 Apr 2015 08:18:12 +0000
Subject: Re: [RFC/PATCH] ARM: shmobile: Consolidate the smp code for R-Car Gen2
Message-Id: <551CFB44.6000407@bp.renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <5502A268.2030304@bp.renesas.com>
In-Reply-To: <5502A268.2030304@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert-san,

Thank you for your feedback.

On 2015/04/01 22:31, Geert Uytterhoeven wrote:

<snip>

> I wonder whether we should replace the "compatible" matching by reading
> the Product Register (PRR, iomem 0xff000044), looking at bits 22-25 and 27-30
> to check for the presence of CA7 and CA15 CPU cores, and fill in the
> rcar_apmu_config tables based on that. That way it'll work automatically for
> all members of the R-Car Gen2 family.

I will try to implement in this way.

>> +       /* let APMU code install data related to shmobile_boot_vector */
>> +       shmobile_smp_apmu_prepare_cpus(max_cpus,
>> +                                      rcar_gen2_apmu_config,
>> +                                      rcar_apmu_config_size);
>> +
>> +       rcar_gen2_pm_init();
>> +
>> +       /* turn on power to SCU of second cluster */
>> +       if (has_a15 && has_a7) {
>> +               this_cluster = MPIDR_AFFINITY_LEVEL(read_cpuid_mpidr(), 1);
>> +               if (this_cluster = 0)
>> +                       rcar_sysc_power_up(&rcar_gen2_ca7_scu);
>> +               else
>> +                       rcar_sysc_power_up(&rcar_gen2_ca15_scu);
> This is a change in behavior compared to the old r8a7790 implementation, which
> powered on both clusters. Please mention this in the patch description.

I will add this description with v2 patch.

The SCU of boot cpu side is already powered on. Therefore, it is not 
necessary to power on the SCU of both clusters in here. In case of 
multi-cluster, the SCU of secondary cluster should be powered on.

>> +       }
>> +}
>> +
>> +static int rcar_gen2_smp_boot_secondary(unsigned int cpu,
>> +                                     struct task_struct *idle)
>> +{
>> +       /* Error out when hardware debug mode is enabled */
>> +       if (of_machine_is_compatible("renesas,r8a7791") &&
>> +           rcar_gen2_read_mode_pins() & BIT(21)) {
> While we indeed had this check on r8a7791 only, I think it also applies
> to r8a7790, cfr. the Lager board documentation.
> According to the R-Car Gen2 datasheet, this is the case on all family
> members but R-Car V2H.

I will fix it with v2 patch.

Regards,
Inami

