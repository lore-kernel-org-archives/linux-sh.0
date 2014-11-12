From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 12 Nov 2014 09:06:34 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: r8a7740 legacy: Correct IIC0 parent clock
Message-Id: <CAMuHMdV8dQ4YWc_E9RGAs=ZL__yEA44AG4koj+S2usPVjYMKDg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415181874-21549-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1415181874-21549-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon,

On Wed, Nov 12, 2014 at 3:27 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Nov 12, 2014 at 09:34:23AM +0900, Simon Horman wrote:
>> On Mon, Nov 10, 2014 at 09:52:38AM +0900, Simon Horman wrote:
>> > On Wed, Nov 05, 2014 at 11:04:33AM +0100, Geert Uytterhoeven wrote:
>> > > According to the datasheet, the operating clock for IIC0 is the HPP
>> > > (RT Peri) clock, not the SUB (Peri) clock. Both clocks run at the same
>> > > speed (50 Mhz).
>> > >
>> > > This is consistent with IIC0 being located in the A4R PM domain, and
>> > > IIC1 in the A3SP PM domain.
>> >
>> > Thanks, I have queued this up.
>>
>> Hi Geert,
>>
>> As this appears to be a bug fix I would like to accompany this patch with
>> some text describing when the problem was introduced and what its effects
>> are. In short a rough guide to if it should be applied to -stable. To that
>> end I prepared the following which I would appreciate your feedback on.
>>
>> * ARM: shmobile: r8a7740 legacy: Correct IIC0 parent clock
>>
>>   This problem appears to have been introduced when IIC0 support was
>>   added to the r8a7740 by 6831f3a9184a1c540 ("ARM: mach-shmobile: r8a7740:
>>   add i2c support") in v3.2.

That's the commit where it became effective. The bug was introduced in
commit 6c01ba445cecb2d8 ("ARM: mach-shmobile: R-Mobile A1 support.").

> s/v3.2/v3.3/
>
>
>>   I am not aware of any run-time effect of this problem

Indeed. Both clocks run at the same frequency, and TTBOMK the HPP clock
cannot be disabled (is that correct?), so the IIC0 clock cannot be inadvertently
be disabled because the common part is disabled through another clock.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
