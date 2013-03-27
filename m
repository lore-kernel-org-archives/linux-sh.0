From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Mar 2013 16:44:57 +0000
Subject: Re: [PATCH 02/13] sh-pfc: r8a73a4: Support sparse GPIO numbers
Message-Id: <CANqRtoRcQRnBeCk3hZXfH_CYRSrzTqotY9JNJWbUJzhFedX5uA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130326134959.31366.93833.sendpatchset@w520>
In-Reply-To: <20130326134959.31366.93833.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Laurent,

On Wed, Mar 27, 2013 at 12:52 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> Hi Magnus,
>
> Thanks for the patch.
>
> On Tuesday 26 March 2013 22:49:59 Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> The r8a73a4 SoC has sparse GPIO numbers. Declare ranges for
>> pin numbers in the PFC SoC data. Pin numbers shall be used
>> with the GPIO API from this point on.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>
>> ---
>>
>>  arch/arm/mach-shmobile/include/mach/r8a73a4.h |    2 +-
>>  drivers/pinctrl/sh-pfc/pfc-r8a73a4.c          |   16 ++++++++++++++++
>>  2 files changed, 17 insertions(+), 1 deletion(-)
>>
>> --- 0007/arch/arm/mach-shmobile/include/mach/r8a73a4.h
>> +++ work/arch/arm/mach-shmobile/include/mach/r8a73a4.h        2013-03-26
>> 20:20:54.000000000 +0900 @@ -86,7 +86,7 @@ enum {
>>       GPIO_PORT325, GPIO_PORT326, GPIO_PORT327, GPIO_PORT328, GPIO_PORT329,
>>
>>       /* Port0 */
>> -     GPIO_FN_LCDD0,
>> +     GPIO_FN_LCDD0 = 330,
>>       GPIO_FN_PDM2_CLK_0,
>>       GPIO_FN_DU0_DR0,
>>       GPIO_FN_IRQ0,
>> --- 0007/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c
>> +++ work/drivers/pinctrl/sh-pfc/pfc-r8a73a4.c 2013-03-26
> 21:12:07.000000000
>> +0900 @@ -1424,6 +1424,20 @@ static struct sh_pfc_pin pinmux_pins[] >>       GPIO_PORT_ALL(),
>>  };
>>
>> +static const struct pinmux_range pinmux_ranges[] = {
>> +     {.begin = 0, .end = 30,},
>> +     {.begin = 32, .end = 40,},
>> +     {.begin = 64, .end = 85,},
>> +     {.begin = 96, .end = 126,},
>> +     {.begin = 128, .end = 134,},
>> +     {.begin = 160, .end = 178,},
>> +     {.begin = 192, .end = 222,},
>> +     {.begin = 224, .end = 250,},
>> +     {.begin = 256, .end = 283,},
>> +     {.begin = 288, .end = 308,},
>> +     {.begin = 320, .end = 329,},
>> +};
>
> I wonder whether it wouldn't be a better idea to add the pin number to the
> sh_pfc_pin structure and compute the ranges array at runtime. Pin numbers
> would be hidden in the GPIO_PORT_ALL() macro. What's your opinion ?

I think the current duplication is unfortunate, so some other way to
handle this would be nice. Keeping it with sh_pfc_pin sounds like a
good place to me.

At the same time, I'm not sure what our current memory footprint is.
It may be rather pointless these days with development boards with 4
GiB on them, but still. The old PFC code and the INTC were developed
to be both efficient in hot paths and as small as possible from a
memory foot print point of view.

So I'd like this new-and-improved code to be as small as possible too.
But from a priority point of view, avoiding duplication of information
must be much more important. So please try to figure out something
good.

> I'm of course not asking you to implement that solution, your patch is fine as
> it is.

Thanks!

/ magnus
