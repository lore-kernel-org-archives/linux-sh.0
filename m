From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 17 Jun 2015 23:50:11 +0000
Subject: Re: possible regression caused by "clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast"
Message-Id: <CANqRtoTmAdVv0V8c5n4A3z9ZPpF0Ef7t8V4xJZQiWGY=hSqrZQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150617024833.GE5143@verge.net.au>
In-Reply-To: <20150617024833.GE5143@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Jun 17, 2015 at 5:42 PM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Jun 17, 2015 at 04:51:07PM +0900, Magnus Damm wrote:
>> Hi Geert,
>>
>> On Wed, Jun 17, 2015 at 4:45 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > On Wed, Jun 17, 2015 at 8:52 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> >> On Wed, Jun 17, 2015 at 11:48 AM, Simon Horman <horms@verge.net.au> wrote:
>> >>> I have observed what appears to be a regression caused by
>> >>> f2a5473861cf ("clocksource: sh_tmu: Set cpu_possible_mask to fix SMP
>> >>> broadcast"), which was included in v3.19.
>> >>>
>> >>> The problem I see is that with a kernel compiled using marzen_defconfig on
>> >>> the r8a7779/marzen board: i.e. a "legacy" kernel.
>> >>>
>> >>> The problem does not manifest when booting the same board using
>> >>> a kernel built with shmobile_defconfig: i.e. a multiplatform kernel.
>> >>>
>> >>> It does not appear to affect other boards I have access to:
>> >>> emev2/kzm9d, r7s72100/genmai, r8a73a4/ape6evm, r8a7740/armadillo900eva,
>> >>> r8a77798/bockw r8a7790/lager r8a7791/koelsch, r8a7794/alt, sh73a0/kzm9g.
>> >>>
>> >>> I have observed this problem on the renesas-devel-20150617-v4.1-rc8
>> >>> tag of my renesas tree. But I do not believe it is exclusive to that tag.
>> >>>
>> >>> The problem appears to be that there is no clocksource available during
>> >>> early boot. The boot log at the end of the email was obtained by
>> >>> enabling DEBUG_LL and earlyprintk.
>> >>
>> >> Thanks for reporting this. I suspect that the reason why this triggers
>> >> on legacy is that we i such case most likely don't have TWD together
>> >> with CCF. Since this is just old legacy code and the multiplatform
>> >
>> > We do have other A9 SMP SoCs (sh73a0, r8a7778).
>> >
>> > r8a7779.dtsi has an "arm,cortex-a9-twd-timer" node. r8a7778 hasn't.
>>
>> Right, r8a7778 is not SMP so I don't think there is any TWD there. Or
>> at least the Linux driver did not use to support running in UP mode.
>>
>> > sh73a0 also has it, but see http://www.spinics.net/lists/linux-sh/msg39128.html
>> > As bockw and marzen still have -reference variants, it may be more
>> > difficult to fix.
>>
>> Your TWD DT node is nicely pointing out the clock via CCF. On legacy
>> this is most likely not possible, so we end up with trying to
>> automatically determining the clock by assuming another clock is
>> running. At least it used to be like that.
>>
>> >> version should be equivalent I suggest that the correct approach is to
>> >> use multiplatform support instead of legacy. And legacy r8a7779
>> >> support should be removed right away if it hasn't already.
>> >
>> > Please wait, so I don't have to rebase the sh73a0/r8a7740 patches I'm
>> > about to send out ;-)
>>
>> Sure, please push out so we can clean up. =)
>
> I'm happy to proceed with an orderly removal of marzen legacy
> as a resolution to this problem.

I agree about removing the marzen legacy code. For anyone wanting to
use the legacy code then the following mangled patch can be used to
work around the "calibrating delay" issue:

From: Magnus Damm <damm+renesas@opensource.se>

Rely on CPU frequency information provided by the r8a7779 DTB for
delay calculation.

Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

---


 arch/arm/mach-shmobile/setup-r8a7779.c |    2 ++

 1 file changed, 2 insertions(+)


--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c

+++ work/arch/arm/mach-shmobile/setup-r8a7779.c 2015-06-18
08:46:21.062366518 +0900

@@ -675,6 +675,8 @@ void __init r8a7779_add_standard_devices



 void __init r8a7779_add_early_devices(void)

 {

+ shmobile_init_delay();

+

  early_platform_add_devices(r8a7779_early_devices,

    ARRAY_SIZE(r8a7779_early_devices));
