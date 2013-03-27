From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 06:42:57 +0000
Subject: Re: [PATCH 00/08] ARM: shmobile: CPU Hotplug and SMP CA9 SCU rework part 2
Message-Id: <CANqRtoSjO641YBUGjfEBV0b4pEzi7nN1F2snGd4assAiVcmi3A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130218134648.17303.97576.sendpatchset@w520>
In-Reply-To: <20130218134648.17303.97576.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 26, 2013 at 5:53 PM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Feb 19, 2013 at 07:09:14PM +0900, Magnus Damm wrote:
>> On Tue, Feb 19, 2013 at 9:49 AM, Simon Horman <horms@verge.net.au> wrote:
>> > On Mon, Feb 18, 2013 at 10:46:48PM +0900, Magnus Damm wrote:
>> >> ARM: shmobile: CPU Hotplug and SMP CA9 SCU rework part 2
>> >>
>> >> [PATCH 01/08] ARM: shmobile: Fix base address readout in headsmp-scu.S
>> >> [PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
>> >> [PATCH 03/08] ARM: shmobile: Use R8A7779_SCU_BASE with TWD
>> >> [PATCH 04/08] ARM: shmobile: Update r8a7779 to check SCU for hotplug
>> >> [PATCH 05/08] ARM: shmobile: Update r8a7779 to use scu_power_mode()
>> >> [PATCH 06/08] ARM: shmobile: Use sh73a0-specific cpu disable code
>> >> [PATCH 07/08] ARM: shmobile: Rearrange r8a7779 cpu hotplug code
>> >> [PATCH 08/08] ARM: shmobile: Remove unused hotplug.c
>> >>
>> >> Finalize the SCU rework by performing minor fixes and converting
>> >> the r8a7779 SMP code to make use of common scu_power_mode() code
>> >> and the early SCU setup code in headsmp-scu.S.
>> >>
>> >> Also, to save a few line remove hotplug.c while at it.
>> >>
>> >> The only remaining itch to scratch here is to fix up CPU Hotplug
>> >> of CPU0 on r8a7779, but for that to happen we first need to start
>> >> accounting for spurious interrupts during shut down.
>> >>
>> >> Signed-off-by: Magnus Damm <damm@opensource.se>
>> >> ---
>> >>
>> >>  No known dependencies apart from previous SMP cleanup series
>> >>  "[PATCH 00/06] ARM: shmobile: SMP Cortex-A9 SCU rework"
>> >>  Written against -next in renesas.git.
>> >
>> > I believe those are queued up for upstream in the soc5 branch.
>> >
>> > Please let me know when you are comfortable with me applying these patches
>> > to that branch. I'm fine with that answer being "now".
>>
>> Now sounds wonderful. Thanks Simon.
>
> [some time passes]
>
> Thanks, applied to the soc5 branch.

[more time passes]

Thanks for your help.

Here's a list of the recent SMP/SCU/CPU Hotplug patches:

[PATCH 00/06] ARM: shmobile: Trivial SMP cleanups
[PATCH 01/06] ARM: shmobile: Remove unused headers from hotplug.c
[PATCH 02/06] ARM: shmobile: Remove partial CPU Hotplug from EMEV2
[PATCH 03/06] ARM: shmobile: Move EMEV2 CPU boot vector setup code
[PATCH 04/06] ARM: shmobile: Remove sh73a0_get_core_count()
[PATCH 05/06] ARM: shmobile: Remove r8a7779_get_core_count()
[PATCH 06/06] ARM: shmobile: Remove emev2_get_core_count()

[PATCH 00/06] ARM: shmobile: SMP Cortex-A9 SCU rework
[PATCH 01/06] ARM: shmobile: Kill off sh73a0 scu_base_addr() function
[PATCH 02/06] ARM: shmobile: Kill off r8a7779 scu_base_addr() function
[PATCH 03/06] ARM: shmobile: Rework EMEV2 scu_base variable
[PATCH 04/06] ARM: shmobile: Move headsmp-sh73a0.S to headsmp-scu.S
[PATCH 05/06] ARM: shmobile: Common shmobile_scu_base in headsmp-scu.S
[PATCH 06/06] ARM: shmobile: Update EMEV2 to use scu_power_mode()

[PATCH 00/08] ARM: shmobile: CPU Hotplug and SMP CA9 SCU rework part 2
[PATCH 01/08] ARM: shmobile: Fix base address readout in headsmp-scu.S
[PATCH 02/08] ARM: shmobile: Rework SH73A0_SCU_BASE IOMEM() usage
[PATCH 03/08] ARM: shmobile: Use R8A7779_SCU_BASE with TWD
[PATCH 04/08] ARM: shmobile: Update r8a7779 to check SCU for hotplug
[PATCH 05/08] ARM: shmobile: Update r8a7779 to use scu_power_mode()
[PATCH 06/08] ARM: shmobile: Use sh73a0-specific cpu disable code
[PATCH 07/08] ARM: shmobile: Rearrange r8a7779 cpu hotplug code
[PATCH 08/08] ARM: shmobile: Remove unused hotplug.c

I've now gotten around to once more test the above patches on KZM9D,
and both CPU0 and CPU1 boots as expected when SMP is enabled in the
kernel configuration.

To test I used renesas.git with the tag renesas-next-20130321.

Thanks,

/ magnus
