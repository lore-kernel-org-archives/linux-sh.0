From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 05 Jun 2014 21:34:56 +0000
Subject: Re: [PATCH 00/08] ARM: shmobile: Suspend on non-SMP update for r8a7790
Message-Id: <CANqRtoSznRVRd7TB3LEouTySAzfKx+pN2kf3W7xvbcct8cReHw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20140605051505.18075.76727.sendpatchset@w520>
In-Reply-To: <20140605051505.18075.76727.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Thu, Jun 5, 2014 at 5:01 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Magnus,
>
> On Thu, Jun 5, 2014 at 7:15 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> ARM: shmobile: Suspend on non-SMP update for r8a7790
>>
>> [PATCH 01/08] ARM: shmobile: Allow use of boot code for non-SMP case
>> [PATCH 02/08] ARM: shmobile: Adjust APMU code to build for non-SMP
>> [PATCH 03/08] ARM: shmobile: Move r8a7790 reset code to pm-r8a7790.c
>> [PATCH 04/08] ARM: shmobile: Allow r8a7790 to build non-SMP APMU code
>> [PATCH 05/08] ARM: shmobile: Use __init for APMU suspend init function
>> [PATCH 06/08] ARM: shmobile: Setup APMU for suspend in non-SMP case
>> [PATCH 07/08] ARM: shmobile: Hook up r8a7790 PM code for Multiplatform
>> [PATCH 08/08] ARM: shmobile: Use shmobile_init_late on r8a7790 DT-only
>>
>> These patches update mach-shmobile and r8a7790 to allow build of
>> early boot code and APMU power management code in case of CONFIG_SMP=n.
>
> Thanks!
>
>> The reason for this change is to allow use of Suspend-to-RAM for recent
>> SoCs like r8a7790 with simplified kernel configuration such as when
>> SMP is disabled. Power management code like CPUFreq, CPUIdle and
>> Suspend-to-RAM should work regardless of what kind of CONFIG_SMP
>> setting the user decides.
>
> Perhaps the non-SMP-specific code can be factored out of headsmp.c and
> platsmp.c into one or more separate files, and the "smp" dropped from the
> function names, or is it too entangled with the SMP-specific code?

Yes, eventually I'd like to do this. You are right that both file and
function names should probably be updated.

At this point I'm mainly focused on being able to compile the code in
UP mode. I want to make sure that the UP case of Core Standby
Suspend-to-RAM is working. I know that SMP at least used to work at
some point, but Suspend-to-RAM with Core Standby on UP may need more
attention.

> Things like (in [6/8]):
>
>  void __init shmobile_smp_apmu_suspend_init(void)
>  {
> +#ifndef CONFIG_SMP
> +       /* initialize APMU for non-SMP case */
> +       shmobile_smp_apmu_prepare_cpus(1);
> +#endif
>         shmobile_suspend_ops.enter = shmobile_smp_apmu_enter_suspend;
>  }
>  #else
>
> can look really confusing: shmobile_*SMP*_apmu_suspend_init() has a
> !CONFIG_SMP section calling into shmobile_*SMP*_apmu_prepare_cpus()
> (the latter is OK, due to the "1" parameter indicating there's only one CPU).

I agree that this portion is far from pretty. Ideally in my opinion
the ARM SMP callbacks should be updated to allow executing some SMP
setup code even though UP is used. Right now we need to call setup
code from various directions depending on mode which results in
italian pasta dish coding. =)

Cheers,

/ magnus
