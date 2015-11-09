From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 09 Nov 2015 09:07:20 +0000
Subject: Re: [PATCH v6 00/12] arm64: renesas: add sound support
Message-Id: <CAMuHMdWv1Ae1JTDyN2JkuHC1Fmfw25gtmmUkSMUitrUQnv82Ug@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87egg3k5g6.wl%kuninori.morimoto.gx@renesas.com>
 <20151109012943.GF4832@verge.net.au>
 <CAMuHMdXBQNCibJU4EDuFZX0zRzUZfC_4KTyXFNVLL81a51Q4RA@mail.gmail.com>
 <20151109090139.GM4832@verge.net.au>
In-Reply-To: <20151109090139.GM4832@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Mon, Nov 9, 2015 at 10:01 AM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Nov 09, 2015 at 09:08:08AM +0100, Geert Uytterhoeven wrote:
>> On Mon, Nov 9, 2015 at 2:29 AM, Simon Horman <horms@verge.net.au> wrote:
>> >>       arm64: renesas: salvator-x: Sound SSI PIO support
>> >
>> > The above patch seemed to have some fuzz. Please check that
>> > I resolved that correctly.
>>
>> The ak4613 node is now a child node of scif2 instead of i2c2, which is
>> definitely not correct.
>>
>> "git diff topic/r8a7795-sound-v5..topic/r8a7795-sound-v6" will show you.
>
> Thanks, that is a bit of a disaster. Sorry about that.
>
> I have tried to fix the problem and re-pushed topic/r8a7795-sound-v6.
> The head commit is now:
>
> 03a185979391 ("arm64: defconfig: add Renesas sound and AK4613 support")

Thanks, looks much better now.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
