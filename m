From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 29 Nov 2013 12:23:55 +0000
Subject: Re: [PATCH] gpio: rcar: Support both edge trigger with DT
Message-Id: <CACRpkdZdggOu9h58hABix3=x6dETipzueCDKMKxVLP+yYjHSeQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1384359983-29178-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CANqRtoRhHhWp0zDcc8jN3eqV=O-=4uBG_a9Xb1-+Lk4eEiZoiw@mail.gmail.com>
	<2124422.xP76KsfKRo@avalon>
In-Reply-To: <2124422.xP76KsfKRo@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, SH-Linux <linux-sh@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, Simon Horman <horms@verge.net.au>

On Thu, Nov 28, 2013 at 4:31 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Linus,
> On Thursday 14 November 2013 15:12:46 Magnus Damm wrote:
>> On Thu, Nov 14, 2013 at 1:26 AM, Laurent Pinchart wrote:
>> > Some versions of the R-Car GPIO controller support triggering on both
>> > edges of the input signal. Whether this capability is supported is
>> > currently specified in platform data. R-Car GPIO devices instantiated
>> > from the device tree have the capability turned off even when the
>> > hardware supports it.
>> >
>> > To fix this, add DT match data support to the driver, initialize both
>> > edge trigger support from match data and enable both edge trigger in
>> > r8a7790 and r8a7791 match data.
>> >
>> > Signed-off-by: Laurent Pinchart
>> > <laurent.pinchart+renesas@ideasonboard.com>
>> > ---
>> >
>> >  drivers/gpio/gpio-rcar.c | 56 +++++++++++++++++++++++++++++++++----------
>> >  1 file changed, 43 insertions(+), 13 deletions(-)
>>
>> Looks fine to me, thanks!
>>
>> Acked-by: Magnus Damm <damm@opensource.se>
>
> Could you please pick this patch up for v3.14 ?

I have never seen this patch before.

I checked my spam folder and all, and it's not on the
marc.info mail archive for linux-gpio either, so something
has really screwed up here :-(

Care to resend with Magus' ACK?

Yours,
Linus Walleij
