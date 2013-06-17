From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Jun 2013 11:45:22 +0000
Subject: Re: [PATCH] gpio-rcar: Use OUTDT when reading GPIOs configured as output
Message-Id: <CANqRtoQ5UyU7=9sgN7w-3aLReecDeCZMnRzXfQZS-RxeShrYVg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130616234152.23721.85467.sendpatchset@w520>
In-Reply-To: <20130616234152.23721.85467.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Mon, Jun 17, 2013 at 7:58 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> On Monday 17 June 2013 08:41:52 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Testing on r8a7790 shows that INDT does not indicate the correct
>> pin state when reading a GPIO configured as output, so update
>> the gpio_rcar_get() function to handle this case.
>
> Have you checked whether this is true on the other SoCs as well ? Reading back
> the output register instead of the input register will not allow detection of
> conflicts. If the hardware can't provide that, fine, but otherwise it would be
> a nice feature to keep (although it might not get used in practice).

I have not tested this patch myself, but I've received feedback from
an internal team at Renesas. Regarding other SoCs, I'm quite confident
in this change, the data sheet for both R-Car H2 and R-Car H1 have the
following sentence in them:

"INDT is valid only for the ports for which general input/output mode
is selected by the general IO/interrupt switching
register and then general input mode is selected by the general
input/output switching register"

I agree it would be nice with hardware that allowed reading the pin
state regardless independently of any mode setting. =)

>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

/ magnus
