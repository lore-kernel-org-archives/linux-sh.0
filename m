From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 25 Nov 2015 07:58:20 +0000
Subject: Re: [PATCH] drm: adv7511: really enable interrupts for EDID detection
Message-Id: <CANqRtoQMSoydbmj8W7Vjc7r-sFo5iz3_5dA2MVipsaec+BRebQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1448376627-12255-1-git-send-email-wsa@the-dreams.de>
	<20151124210501.GA1584@katana>
	<CANqRtoTAPU3zni__J2MQR+KK=SUUGYLgHz5j9s04CjEq55s3hg@mail.gmail.com>
	<20151125064851.GA1511@tetsubishi>
In-Reply-To: <20151125064851.GA1511@tetsubishi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: dri-devel@lists.freedesktop.org, SH-Linux <linux-sh@vger.kernel.org>, Simon Horman <horms@verge.net.au>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>

Hi Wolfram,

On Wed, Nov 25, 2015 at 3:48 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > This has been tackled as well now. The clock for the GPIO controller was
>> > off, so no interrupt was passed through.
>>
>> Thanks a lot for your efforts! When you have time, can you please show
>> me the patch that fixes that GPIO interrupt problem? I'm asking
>> because I may have ran into a similar issue on Gose or Alt.
>
> For Koelsch, this simply meant I reverted Geert's clocks-off patch. But
> there is a fundamental problem below: GPIO interrupts described with the
> "interrupts" property in DT do not get the underlying GPIO requested.
> And if noone else is using the GPIO block, its clock may be turned off.
>
> I have an idea how to fix it, need to check priorities of the other
> tasks, though.

I guess you mean that the GPIO callbacks include Runtime PM handling
however for irq_chip Runtime PM may not be hooked up so the GPIO block
is in such case is not powered on / get clock enabled?

> BTW, the continous EDID read test on your board is currently at >360000
> successful reads, a not a single failure :)

Excellent, thank you!

/ magnus
