From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 14 Feb 2013 12:20:10 +0000
Subject: Re: [PATCH/RFC 3/3] ARM: shmobile: switch SDHI and MMCIF interfaces on kzm9g-reference to pinctrl
Message-Id: <CANqRtoSoMB4DfXb3j0FQcJ7pLSAyHPFvz0Xa-doqp2VXLnzMqA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Feb 14, 2013 at 8:09 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Thursday 14 February 2013 18:00:12 Paul Mundt wrote:
>> On Thu, Feb 14, 2013 at 10:36:52AM +0900, Magnus Damm wrote:
>> > On Thu, Feb 14, 2013 at 3:15 AM, Laurent Pinchart wrote:
>> > > Hi Guennadi,
>> > >
>> > > Thank you for the patch.
>> > >
>> > > On Tuesday 12 February 2013 16:50:04 Guennadi Liakhovetski wrote:
>> > >> The recently added on sh73a0 DT pinctrl support enables us to switch
>> > >> SDHI
>> > >> and MMCIF interface pins to pinctrl and to add GPIO bindings for their
>> > >> card-detection pins and regulators.
>> > >>
>> > >> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > >> ---
>> > >>
>> > >>  arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |   61
>> > >>  ++++++++++++++++-----
>> > >>  arch/arm/boot/dts/sh73a0-reference.dtsi        |    9 ----
>> > >>  arch/arm/mach-shmobile/board-kzm9g-reference.c |   36 ++------------
>> > >>  3 files changed, 54 insertions(+), 52 deletions(-)
>> > >
>> > > [snip]
>> > >
>> > >> diff --git a/arch/arm/mach-shmobile/board-kzm9g-reference.c
>> > >> b/arch/arm/mach-shmobile/board-kzm9g-reference.c index d92da6d..1490246
>> > >> 100644
>> > >> --- a/arch/arm/mach-shmobile/board-kzm9g-reference.c
>> > >> +++ b/arch/arm/mach-shmobile/board-kzm9g-reference.c
>> > >> @@ -90,38 +90,12 @@ static void __init kzm_init(void)
>> > >>
>> > >>       regulator_register_fixed(2, dummy_supplies,
>> > >>       ARRAY_SIZE(dummy_supplies));
>> > >>       platform_device_register(&smsc_device);
>> > >>
>> > >> -     /* enable MMCIF */
>> > >> -     gpio_request(GPIO_FN_MMCCLK0,           NULL);
>> > >> -     gpio_request(GPIO_FN_MMCCMD0_PU,        NULL);
>> > >> -     gpio_request(GPIO_FN_MMCD0_0_PU,        NULL);
>> > >> -     gpio_request(GPIO_FN_MMCD0_1_PU,        NULL);
>> > >> -     gpio_request(GPIO_FN_MMCD0_2_PU,        NULL);
>> > >> -     gpio_request(GPIO_FN_MMCD0_3_PU,        NULL);
>> > >> -     gpio_request(GPIO_FN_MMCD0_4_PU,        NULL);
>> > >> -     gpio_request(GPIO_FN_MMCD0_5_PU,        NULL);
>> > >> -     gpio_request(GPIO_FN_MMCD0_6_PU,        NULL);
>> > >> -     gpio_request(GPIO_FN_MMCD0_7_PU,        NULL);
>> > >
>> > > Don't hate me, but... the PFC implementation doesn't support controlling
>> > > pull- ups through the pinctrl API yet :-( That's something I still need
>> > > to implement.
>> >
>> > Uhm, doesn't that smell like a functional regression...?
>> >
>> > Would it be possible for someone else to re-add pull-up support
>> > properly to the PFC code?
>>
>> No, because it's still supported by way of the GPIO API as above, which
>> in turn layers through the rest of the PFC code. Transitioning these
>> users over to the corresponding pinctrl API takes some more work, so I
>> don't believe any of the refactoring has introduced regressions in that
>> regard.
>
> Thanks Paul, I couldn't have said that better :-)

Good, as long as things keep on working as before I am happy.

Thanks guys.
