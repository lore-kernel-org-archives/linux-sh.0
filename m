From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 09 May 2014 07:01:09 +0000
Subject: Re: [PATCH v3 2/7] adv7180: add of match table
Message-Id: <CAMuHMdX5=TSQ_x0_cJ7HQ3VTG8QcGAfXo-eQnTNSeks9AbB4Vw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1397471802-27216-3-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, May 9, 2014 at 1:47 AM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 05/09/2014 03:23 AM, Sergei Shtylyov wrote:
>
>>> Add a proper of match id for use when the device is being bound via
>>> device tree, to avoid having to use the i2c old-style binding of the

"to avoid having to use the i2c old-style binding"

>>> device.
>
>>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>
>>     From looking at of_i2c_register_devices() in drivers/i2c/i2c-core.c, I
>> got
>> an impression we don't need this patch. This function builds the I2C
>> device
>> name by calling of_modalias_node() which just strips the vendor prefix (if
>> any) from the "compatible" prop.
>
>    Yeah, I was able to get the ADV7180 device from DT probed without this
> patch. So, no, we don't need the patch.

So it works without, but it's better to use the full name.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
