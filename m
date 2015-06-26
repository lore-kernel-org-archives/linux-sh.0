From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 26 Jun 2015 01:12:20 +0000
Subject: Re: [PATCH 03/05] ARM: shmobile: r8a7779: Generic SoC SMP support
Message-Id: <CANqRtoQSNd6UDX3PM0vNthpGYa-pNn1SMuRbKujq9Wd+1x9+Qg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150218023842.12588.17833.sendpatchset@little-apple>
In-Reply-To: <20150218023842.12588.17833.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Jun 26, 2015 at 6:01 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Thursday 25 June 2015 17:45:59 Magnus Damm wrote:
>> On Wed, Feb 18, 2015 at 4:27 PM, Laurent Pinchart wrote:
>> > On Wednesday 18 February 2015 11:38:42 Magnus Damm wrote:
>> >> From: Magnus Damm <damm+renesas@opensource.se>
>> >>
>> >> Add a r8a7779-specific SMP operation pointer to support
>> >> all 4 CPU cores through SMP on r8a7779 without C board code.
>> >>
>> >> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>
>> >> ---
>> >>  arch/arm/mach-shmobile/setup-r8a7779.c |    1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> --- 0003/arch/arm/mach-shmobile/setup-r8a7779.c
>> >> +++ work/arch/arm/mach-shmobile/setup-r8a7779.c       2015-02-17
>> >> 00:46:51.566221714 +0900 @@ -773,6 +773,7 @@ static const char
>> >> *r8a7779_compat_dt[] _
>> >>  };
>> >>
>> >>  DT_MACHINE_START(R8A7779_DT, "Generic R8A7779 (Flattened Device Tree)")
>> >> +     .smp            = smp_ops(r8a7779_smp_ops),
>> >>       .map_io         = r8a7779_map_io,
>> >>       .init_early     = shmobile_init_delay,
>> >>       .init_time      = r8a7779_init_time,
>> >
>> > I've been told by Arnd last week that an alternate method exists to select
>> > SMP operations when booting from DT. The CPU_METHOD_OF_DECLARE()
>> > registers SMP operations with a CPU enabling method name, which can then
>> > be specified in DT using the enable-method property. This allows using
>> > the same DT machine description for several SoCs when only the SMP
>> > operations differ.
>> >
>> > We unfortunately can't switch to this method completely for Gen2,
>> > otherwise we would break backward compatibility with older DT that don't
>> > specify the enable-method property. For newer addition, though, we could
>> > avoid introducing a dependency on SMP operations in the DT machine
>> > descriptions.
>>
>> I've started to address this in the series "[PATCH 00/05] ARM:
>> shmobile: APMU DT support via SMP Enable method", but this only covers
>> R-Car Gen2 so it does not apply to the r8a7779 case. My priority at
>> this point is to get rid of the Marzen reference board code, and
>> enabling SMP in the generic r8a7779 machvec is a blocker for that. So
>> my current plan is to migrate r8a7779 smp over as-is and then
>> incrementally fix it up as a separate issue - ideally after converting
>> over R-Car Gen2 to the new way.
>
> I understand that, but if we do so in two steps we will need to keep backward
> compatibility code for SMP based on the machine compatible string. It won't be
> possible to switch the code to CPU_METHOD_OF_DECLARE() and get rid of the old
> code.

In my mind this is just a question of timing. Say we move to using
enable-method more or less now. Then we would force the Marzen user to
update the DTB now due to requirement of using enable-method to get
SMP working. Or we chose to do it later, and then we have to force the
user to update the DTB then. Either way we need to force an update.
I'd rather collect a couple of different reasons for DT update in one
bunch. Because of this postponing the update must be good if possible.

> Is it really that difficult to go straight to CPU_METHOD_OF_DECLARE() ?

From a purely technical point of view I don't think it is very hard.
But I'd like to have a face-to-face discussion to clarify the purpose
of the enable-method DT binding. I'm all for being standard and
consolidating code, but I believe DT should be used to describe
hardware.

As for the marzen-reference board code, I'd like to simply get rid of
it without adding any dependencies.

Thanks,

/ magnus
