From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Sep 2014 10:44:59 +0000
Subject: Re: [PATCH] ARM: shmobile: r8a7790: switch from scif to scifa
Message-Id: <CAMuHMdXgqTvwJK9wUTK+G75-1kNs-17qhH1gGNJBij3y51QzLA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
In-Reply-To: <1410883837-5611-1-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Tue, Sep 30, 2014 at 12:40 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 30 September 2014 13:30:29 Simon Horman wrote:
>> On Fri, Sep 19, 2014 at 12:28:28PM +0900, Simon Horman wrote:
>> > On Thu, Sep 18, 2014 at 10:57:12AM +0300, Laurent Pinchart wrote:
>> >> On Thursday 18 September 2014 08:55:43 Simon Horman wrote:
>> >>> On Wed, Sep 17, 2014 at 05:40:07PM +0300, Laurent Pinchart wrote:
>> >>>> On Tuesday 16 September 2014 18:10:37 Wolfram Sang wrote:
>> >>>>> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> >>>>>
>> >>>>> SCIF and SCIFA can be plexed onto the same wires on Lager board.
>> >>>>> The datasheet also describes the wires as SCIFA. So, to make use
>> >>>>> of the bigger FIFOs switch to SCIFA instead.
>> >>>>>
>> >>>>> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
>> >>>>> ---
>> >>>>>
>> >>>>> Currently, I use this patch to check if the DMA RX issue is the
>> >>>>> same on SCIF and SCIFA (yes, it is). However, I still think it
>> >>>>> makes sense to use the bigger FIFOs. I will check this next week
>> >>>>> with Bastian's FIFO patches. Until then, I send this as RFC to
>> >>>>> collect opinions speaking for/against this change.
>> >>>>
>> >>>> I have nothing against this change, but I believe the aliases should
>> >>>> now be serial0 and serial1 to match the legacy code (OK, that's a
>> >>>> lame excuse, we all know that I just want to change the aliases
>> >>>> ;-)).
>> >>>
>> >>> Thanks Laurent, I think its probably time we had that conversation
>> >>> again. But I think that change can be done (or not ^) separately to
>> >>> this change.
>> >>
>> >> It could, but I believe it would make sense to do both in one patch,
>> >> otherwise there will be a console serial port device mismatch between
>> >> the legacy and multiplatform cases.
>> >
>> > I'm a little confused.
>> > Does this patch introduce such a miss-match?
>>
>> Hi Laurent,
>>
>> I'd like to move this forwards somehow.
>
> This patch switches the Lager board to use SCIFA[01] instead of SCIF[01],
> while keeping the Linux devices named /dev/ttySC[67]. With legacy boot,
> SCIFA[01] are named /dev/ttySC[01]. There would thus be a mismatch in that
> sense, even if this change doesn't prevent using the same Linux serial devices
> on both legacy and DT boot.

So if I understand if correctly, booting with the current
"console=ttySC6,115200"
in /chosen/bootargs will give a working console for both legacy and
multi-platform,
but the underlying serial hardware block for the console differs (legacy uses
SCIF0, multi-platform uses SCIFA0)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
