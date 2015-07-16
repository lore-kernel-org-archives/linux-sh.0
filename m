From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Jul 2015 09:00:56 +0000
Subject: Re: [PATCH] pinctrl: sh-pfc: Convert to platform_get_*()
Message-Id: <CAMuHMdVoC9iR0PTZ5TD9w8H8DbnuLxNyUAu6gHObFPx=oKhB7Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435225193-10078-1-git-send-email-geert+renesas@glider.be>
	<1971413.ULIg8n17Hy@avalon>
In-Reply-To: <1971413.ULIg8n17Hy@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, Pantelis Antoniou <pantelis.antoniou@konsulko.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Laurent,

On Thu, Jul 16, 2015 at 10:41 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>>  drivers/pinctrl/sh-pfc/core.c | 46 ++++++++++++++++++----------------------
>>  1 file changed, 21 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sh-pfc/core.c b/drivers/pinctrl/sh-pfc/core.c
>> index 865d235612c5200a..9796238959047508 100644
>> --- a/drivers/pinctrl/sh-pfc/core.c
>> +++ b/drivers/pinctrl/sh-pfc/core.c
>> @@ -29,24 +29,25 @@
>>  static int sh_pfc_map_resources(struct sh_pfc *pfc,
>>                               struct platform_device *pdev)
>>  {
>> -     unsigned int num_windows = 0;
>> -     unsigned int num_irqs = 0;
>> +     unsigned int num_windows, num_irqs;
>>       struct sh_pfc_window *windows;
>>       unsigned int *irqs = NULL;
>>       struct resource *res;
>>       unsigned int i;
>> +     int irq;
>>
>>       /* Count the MEM and IRQ resources. */
>> -     for (i = 0; i < pdev->num_resources; ++i) {
>> -             switch (resource_type(&pdev->resource[i])) {
>> -             case IORESOURCE_MEM:
>> -                     num_windows++;
>> +     for (num_windows = 0;; num_windows++) {
>
> Just a bit of nit-picking, I'd add a space between the two ; (same for the
> next loop).

I had done my research ;-)

$ git grep 'for.*;;' | wc -l
1410
$ git grep 'for.*; ;' | wc -l
190
$

>> +             res = platform_get_resource(pdev, IORESOURCE_MEM, num_windows);
>> +             if (!res)
>>                       break;
>> -
>> -             case IORESOURCE_IRQ:
>> -                     num_irqs++;
>> +     }
>
> And a blank line here.

I didn't add one, to make clear the block falls under the "Count the MEM
and IRQ resources. " comment, too.

Let's leave this to Linus to decide...

> The rest looks fine to me.
>
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
