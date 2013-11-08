From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 08 Nov 2013 15:02:35 +0000
Subject: Re: [PATCH 05/10] ARM: shmobile: lager-reference: Switch to multiplaform
Message-Id: <CANqRtoTi=tg3nbNDG0iqfRA2Ny5n3YQV-wxYcUACFdEtB4Y4ew@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383059082-26315-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383059082-26315-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Fri, Nov 8, 2013 at 10:50 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Simon,
>
> On Friday 08 November 2013 15:25:47 Simon Horman wrote:
>> On Wed, Nov 06, 2013 at 06:15:33PM +0900, Magnus Damm wrote:
>> > Hi Simon, Laurent,
>> >
>> > On Wed, Nov 6, 2013 at 5:23 PM, Simon Horman <horms@verge.net.au> wrote:
>> > > On Tue, Oct 29, 2013 at 04:04:37PM +0100, Laurent Pinchart wrote:
>> > >> Move the Lager reference board to multiplaform ARM architecture. As
>> > >> multiplatform requires usage of the common clock framework, switch from
>> > >> legacy clocks to CCF by replacing the legacy clock framework
>> > >> initialization code in the machine init handler with a common clock
>> > >> framework initialization call in the time init handler.
>> > >>
>> > >> Signed-off-by: Laurent Pinchart
>> > >> <laurent.pinchart+renesas@ideasonboard.com>
>> > >> ---
>> > >>
>> > >>  arch/arm/mach-shmobile/Kconfig                 |  7 +++++++
>> > >>  arch/arm/mach-shmobile/Makefile                |  1 +
>> > >>  arch/arm/mach-shmobile/board-lager-reference.c | 13 +++++++++----
>> > >>  3 files changed, 17 insertions(+), 4 deletions(-)
>> > >>
>> > >> diff --git a/arch/arm/mach-shmobile/Kconfig
>> > >> b/arch/arm/mach-shmobile/Kconfig index 4bb548f..b39f6b6 100644
>> > >> --- a/arch/arm/mach-shmobile/Kconfig
>> > >> +++ b/arch/arm/mach-shmobile/Kconfig
>> > >> @@ -20,6 +20,9 @@ comment "SH-Mobile System Type"
>> > >>
>> > >>  config ARCH_EMEV2
>> > >>
>> > >>       bool "Emma Mobile EV2"
>> > >>
>> > >> +config ARCH_R8A7790
>> > >> +     bool "R-Car H2 (R8A77900)"
>> > >> +
>> > >
>> > > I realise that up until now there has only been one entry,
>> > > but in keeping with the non-SHMOBILE_MULTI entries I think it
>> > > would be good to have the SHMOBILE_MULTI entries sorted in alphabetical
>> > > order. With this in mind could you move ARCH_R8A7790 to
>> > > above ARCH_EMEV2?
>> >
>> > Actually, since we have multiple boards that all want to go into
>> > SHMOBILE_MULTI, I wonder if we can merge the initial code early
>> > somehow?
>> >
>> > Ideally I'd like to keep the DT reference board build for both CCF and
>> > legacy clocks for a while. So we want the same code to be built with
>> > SHMOBILE and SHMOBILE_MULTI. When we have got the CCF DT bindings
>> > merged then we can get rid of the legacy DT reference build option.
>> >
>> > See the following commit for an example:
>> >
>> > cbc60e7c04f3c1390144d4a881f0a7b98b49da98
>>
>> cbc60e7c04f3c139 ("ARM: shmobile: Add EMEV2 and KZM9D to
>> ARCH_SHMOBILE_MULTI") seems like a reasonable approach to me.
>
> On r8a7790 board code needs to explicitly call a function exported by the
> drivers/clk/shmobile/clk-r8a7790.c driver. I thus need to merge that driver
> before modifying board code, which can be done unconditionally at that point.

I guess we still need to work on figuring out what the interface
between arch/arm and drivers/clk will look like. This will affect a
whole bunch of SoCs that use the boot mode to determine clock
dividers. So instead of thinking of this as an issue specific to the
r8a7790 SoC or the Lager board we need to include at least r8a7791 and
probably r8a7779 as well.

When you've posted your next version of r8a7790 patches for testing
then I'd like to spend some time seeing how good or bad it will look
like with using a dt property for this. So in my mind I sort of see
the SoC and board code making use of a single shared function to pass
the boot mode to the CCF code. This will among other things make it
possible to merge these bits independently.

But for now, please cook up your next version so we can give it a try.
Since we still are a bit away from merge timing it would be good to
optimize for easy consumption, so a single complete series of patches
would be really nice to see.

Cheers,

/ magnus
