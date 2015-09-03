From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 03 Sep 2015 10:34:48 +0000
Subject: Re: [PATCH v8 00/07] Renesas R-Car H3 (r8a7795) integration patches V8
Message-Id: <CANqRtoSJCe4bqw-bzOo2xQUF0FcHFLhNcsG7br5d7cecY0J15w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150831062907.24004.79614.sendpatchset@little-apple>
In-Reply-To: <20150831062907.24004.79614.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Mon, Aug 31, 2015 at 4:11 PM, Simon Horman <horms@verge.net.au> wrote:
> Hi Magnus,
>
> I have pushed these patches to the renesas tree in a topic branch as
> described below.
>
> To be quite clear none of these patches are queued up for mainline yet and
> as such they are not included in the next or devel branches of the renesas
> tree.

Thanks for your help! I've pushed out a new V9 series now and marked
it as [RFC]. I will most likely focus on CPG again after this and
release a new series for that. I may also cook up a V10 integration
series early next week.

> On Mon, Aug 31, 2015 at 03:29:07PM +0900, Magnus Damm wrote:
>> Renesas R-Car H3 (r8a7795) integration patches V8
>>
>> [PATCH v8 01/07] arm64: renesas: r8a7795: Add Renesas R8A7795 SoC support
>> [PATCH v8 02/07] arm64: renesas: r8a7795 dtsi: Add all common divider clocks
>> [PATCH v8 03/07] arm64: renesas: r8a7795 dtsi: Add dummy dma-controller nodes
>> [PATCH v8 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
>> [PATCH v8 05/07] arm64: renesas: r8a7795: enable PFC
>> [PATCH v8 06/07] arm64: renesas: add Salvator-X board support on DTS
>> [PATCH v8 07/07] arm64: defconfig: renesas: Enable Renesas r8a7795 SoC
>>
>> This is V8 of the R-Car H3 SoC support which contains a simplified
>> series of initial r8a7795 support including:
>> - Single CPU core, Arch timer, GIC
>> - CPG and MSTP
>> - r8a7795 SCIF0->SCIF6
>> - PFC
>> - Salvator-X DEBUG0 and DEBUG1 serial ports.
>>
>> The latest version posted by Morimoto-san is V7:
>> [PATCH 00/25 v7][RFC] arm64: Renesas Gen3 initial patch
>>
>> Previous V7 version contained both driver modifications and arm64 integration
>> code in a single series including USB support. The series contained 25 patches
>> (and growning) but the base portion with PFC and CPG were not yet stabilized
>> due to too large PFC patch and CPG DT binding discussions.
>>
>> In this series several patches have been folded together. My apoligies to
>> people with large out of tree collections for causing rebase pain, but
>> without changing this may turn into an unmanageable mess.
>>
>> The following example hopefully shows how this series simplifies things:
>> Looking and SCIF2 and the Salvator-X serial ports, the initial SCIF2 patch
>> only enabled SCIF2 while the other SCIF instances were added by a separate
>> patch later on. The second Salvator-X serial port was then also enabled. On
>> top of this the SCIF2 serial port had some issues which resulted in pinctrl
>> changes. On top of that we had CPG changes that needed to go in as well...
>>
>> So in previous series we had:
>>   [PATCH 9/25] arm64: renesas: r8a7795: Add SCIF2 support
>>   [PATCH 1/6] arm64: renesas: r8a7795 dtsi: Mark scif2 disabled
>>   [PATCH 3/6] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
>>   [PATCH 15/25] arm64: renesas: add Salvator-X board support on DTS
>>   [PATCH 5/5] arm64: renesas: salvator-x: Update SCIF2 pin group
>>   [PATCH 5/6] arm64: renesas: salvator-x: Enable SCIF1 on serial1
>>
>> With this series we have:
>>  [PATCH v8 04/07] arm64: renesas: r8a7795 dtsi: Add all SCIF nodes
>>  [PATCH v8 06/07] arm64: renesas: add Salvator-X board support on DTS
>>
>> I believe we should keep on folding in changes in a smaller manageable
>> patch series until we get the base and the dependencies stabilized.
>
> Small does seem more manageable.
> Hopefully this approach will allow us to move forwards faster.

I hope so too. There are zillions of things to fix!!

>>
>> Regarding dependencies, this V8 integration series depends on the following:
>>
>> CPG:
>> [PATCH v4 00/05] Renesas R-Car Gen3 CPG support V4
>>
>> PFC:
>> [PATCH 0/2][RFC] pinctrl: sh-pfc: r8a7795 support
>>
>> SCIF:
>> [PATCH] serial: sh-sci: Add device tree support for r8a7795
>
>
> I have pushed this series to a new topic/arm64-rcar-gen3-v8 branch.
>
> I have based this on a merge of:
> * The next/arm64 branch of the arm-soc tree[1],
>   which is in turn based on is v4.2-rc2.
> * The next/soc branch of the arm-soc tree [2],
>   which is also based on v4.2-rc2.
>
> The reason for including next/arm64 in the base is that there were several
> patches in arm-soc required to apply the patchset cleanly. In particular
> eed6b3eb20b9 ("arm64: Split out platform options to separate Kconfig")
> which adds arch/arm64/Kconfig.platforms.
>
> The reason for including next/soc in the base is that it appears to
> be needed for next/arm64 to compile with the arm64 defconfig.
> In particular
> c84e358718a6 ("soc: Mediatek: Add SCPSYS power domain driver")
> appears to be required by
> c02e0e86d304 ("arm64: dts: mt8173: Add afe device node").
>
> As the dependencies you mention above are run-time rather than
> build-time I have not included them in the topic branch.
>
>
> [1] Head commit:
>     bcfff4d961fb ("arm64: Enable Marvell Berlin SoC family in def config")
> [2] Head commit:
>     341a670abd1c ("ARM64: dts: vexpress: Use assigned-clock-parents for
>     sp810")

Thanks. I based the latest version of a recent commit from
renesas-drivers. Once the dependencies become more stable I'll start
sending out this series for upstream inclusion and then i'll adjust
the base.

Cheers,

/ magnus
