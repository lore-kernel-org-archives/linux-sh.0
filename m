From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 28 Dec 2015 10:21:08 +0000
Subject: Re: [PATCH/RFC] ARM: shmobile: LPAE memory bank CMA assignment prototype
Message-Id: <CAMuHMdXhjob53a0EtSwCLyfsgr0b9qapBiWMLOtwnXfKP6CYpg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20151219014005.6274.87661.sendpatchset@little-apple>
In-Reply-To: <20151219014005.6274.87661.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Dec 28, 2015 at 11:10 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> Regarding this patch, it is just a proof of concept to test allocation
>> from a high memory address without modifying any hardware description.
>>
>> > I don't want to see board code coming back through the back door. What's
>> > wrong with just reserving memory in DT with the reserved-memory bindings
>> > and assigning it to the DU ?
>>
>> Describing device-to-memory bank assignment in DT equals mixing
>> software policy with hardware description. I prefer to keep the
>> software policy in C and the hardware description in DT.
>>
>> If you think there are better ways to reserve memory, why don't you
>> cook up a counter proposal and post it in a public space? =)
>
> Doing it in DT is the better way in my opinion :-) There are established DT
> bindings for that purpose, and that's what upstream is using.

I'm a bit sceptical about describing this in DT, too, as this is a software
policy, not a hardware description, but it's indeed described in
Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
