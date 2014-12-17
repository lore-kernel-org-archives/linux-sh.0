From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Dec 2014 13:59:21 +0000
Subject: Re: [PATCH] clocksource: sh_tmu: Set cpu_possible_mask to fix SMP broadcast
Message-Id: <CAMuHMdWGUyyy=DHGK=1anZ3cEdCpMM9=y27pEtZo81eR6g4T7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20141216094854.22639.69181.sendpatchset@w520>
In-Reply-To: <20141216094854.22639.69181.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

[reduced cc-list]

On Wed, Dec 17, 2014 at 1:14 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > What are we missing ?
>> >
>> > - The DIV6 multiparent series has been merged by Mike, and the sh73a0 CCF
>> > is nearly ready.
>>
>> Yep.
>>
>> > - We need proper BSC support to get LAN working, although it could be
>> > worked around temporarily by specifying the BSC clock in the LAN node if
>> > I recall correctly.
>>
>> Working on that. I hope to send out v2 later today...
>>
>> > - Accelerometer and RTC have no DT bindings, but they should work with the
>> > I2C core OF match support.
>>
>> I have RTC in my DTS, and it works.
>
> Great.
>
> I can help with at least some of the remaining pieces if you share your
> working branch.

I pushed my local working branch to
https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git/log/?h=wip

Please wear sun glasses, and keep the kbuild test robot away ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
