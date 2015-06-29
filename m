From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 29 Jun 2015 05:52:22 +0000
Subject: Re: [PATCH 03/05] ARM: shmobile: r8a7779: Generic SoC SMP support
Message-Id: <CANqRtoT_NTVHJU62drp00NMHk4DODXcDc+bUKhoJ47doyqSbRQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150218023842.12588.17833.sendpatchset@little-apple>
In-Reply-To: <20150218023842.12588.17833.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Geert,

On Fri, Jun 26, 2015 at 3:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Fri, Jun 26, 2015 at 8:38 AM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>>> >> >> --- 0003/arch/arm/mach-shmobile/setup-r8a7779.c
>>> >> >> +++ work/arch/arm/mach-shmobile/setup-r8a7779.c       2015-02-17
>>> >> >> 00:46:51.566221714 +0900 @@ -773,6 +773,7 @@ static const char
>>> >> >> *r8a7779_compat_dt[] _
>>> >> >>
>>> >> >>  };
>>> >> >>
>>> >> >>  DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device
>>> >> >>  Tree)")
>>> >> >>
>>> >> >> +     .smp            = smp_ops(r8a7779_smp_ops),
>>> >> >>
>>> >> >>       .map_io         = r8a7779_map_io,
>>> >> >>       .init_early     = shmobile_init_delay,
>>> >> >>       .init_time      = r8a7779_init_time,
>>> >> >
>>> >> > I've been told by Arnd last week that an alternate method exists to
>>> >> > select SMP operations when booting from DT. The CPU_METHOD_OF_DECLARE()
>>> >> > registers SMP operations with a CPU enabling method name, which can
>>> >> > then be specified in DT using the enable-method property. This allows
>>> >> > using the same DT machine description for several SoCs when only the
>>> >> > SMP operations differ.
>>> >> >
>>> >> > We unfortunately can't switch to this method completely for Gen2,
>>> >> > otherwise we would break backward compatibility with older DT that
>>> >> > don't specify the enable-method property. For newer addition, though,
>>> >> > we could avoid introducing a dependency on SMP operations in the DT
>>> >> > machine descriptions.
>>> >>
>>> >> I've started to address this in the series "[PATCH 00/05] ARM:
>>> >> shmobile: APMU DT support via SMP Enable method", but this only covers
>>> >> R-Car Gen2 so it does not apply to the r8a7779 case. My priority at
>>> >> this point is to get rid of the Marzen reference board code, and
>>> >> enabling SMP in the generic r8a7779 machvec is a blocker for that. So
>>> >> my current plan is to migrate r8a7779 smp over as-is and then
>>> >> incrementally fix it up as a separate issue - ideally after converting
>>> >> over R-Car Gen2 to the new way.
>>> >
>>> > I understand that, but if we do so in two steps we will need to keep
>>> > backward compatibility code for SMP based on the machine compatible
>>> > string. It won't be possible to switch the code to
>>> > CPU_METHOD_OF_DECLARE() and get rid of the old code.
>>>
>>> In my mind this is just a question of timing. Say we move to using
>>> enable-method more or less now. Then we would force the Marzen user to
>>> update the DTB now due to requirement of using enable-method to get
>>> SMP working. Or we chose to do it later, and then we have to force the
>>> user to update the DTB then. Either way we need to force an update.
>>
>> The reason why I would prefer doing it now is that switching later would be a
>> regression from a DT ABI point of view (users who don't update their DTB would
>> lose SMP support), while doing it now wouldn't introduce a regression given
>> that SMP is currently disabled when booting r8a7779 with DT.
>
> As far as I understand, we only care about DT regressions for R-Car Gen2,
> not for SH-Mobile/R-Mobile/R-Car Gen1/RZ?

You are right that we tend to be most strict about R-Car Gen2, but in
general I believe we should try to avoid DT breakage as much as
possible. It seems that we need to discuss this more before being able
to decide exactly what to do.

Thanks,

/ magnus
