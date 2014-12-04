From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Dec 2014 10:22:04 +0000
Subject: Re: [PATCH v2 0/6] ARM: shmobile: Change to using clock-indices
Message-Id: <CAMuHMdWXiMEEGXb3o+oo=H912o5wCgLD7WCWQMpRDueD6FxphQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1415645379-3366-1-git-send-email-geert+renesas@glider.be>
	<CAMuHMdX+EfnjZvnDyUprtuQ05Ekpnr7bxgTZA=2_CHMFTq1Y9A@mail.gmail.com>
	<20141204041144.GA9241@verge.net.au>
	<20141204070043.GA25806@verge.net.au>
In-Reply-To: <20141204070043.GA25806@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Mike Turquette <mturquette@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Ben Dooks <ben.dooks@codethink.co.uk>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

Hi Simon,

On Thu, Dec 4, 2014 at 8:00 AM, Simon Horman <horms@verge.net.au> wrote:
> On Thu, Dec 04, 2014 at 01:11:44PM +0900, Simon Horman wrote:
>> On Wed, Dec 03, 2014 at 12:27:13PM +0100, Geert Uytterhoeven wrote:
>> > On Mon, Nov 10, 2014 at 7:49 PM, Geert Uytterhoeven
>> > <geert+renesas@glider.be> wrote:
>> > > This patch series finalizes the conversion from the vendor-specific
>> > > "renesas,clock-indices" to the generic "clock-indices", started by Ben Dooks.
>> > >
>> > > The patches for r8a7790 and r8a7791 were extracted from a patch that Ben sent
>> > > before ("[PATCH 2/3] renesas: change to using clock-indices"), but it was never
>> > > split/updated.
>> >
>> > As Mike has accepted the bindings update in clk-next, can you please apply
>> > the dtsi updates?
>>
>> Sure, I will look into doing so; most likely tomorrow.
>
> Thanks, I have now done so.
>
> There was some fuzz when applying most of the patches,
> I'd appreciate it if you could check that I got things right.

Thanks, the result looks fine, both in devel and dt-for-v3.20.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
