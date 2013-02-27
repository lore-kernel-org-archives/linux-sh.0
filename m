From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 27 Feb 2013 10:13:46 +0000
Subject: Re: [PATCH] gpio: em: Add Device Tree support
Message-Id: <CANqRtoRUqDsspHQQ11d3c2jc+MvoROwfbv3so5=SGhHOs9k7WA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130226132623.18365.36583.sendpatchset@w520>
	<20130226224106.GC20670@core.coreip.homeip.net>
In-Reply-To: <20130226224106.GC20670@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org, grant.likely@secretlab.ca, horms@verge.net.au, linus.walleij@linaro.org, linux-sh@vger.kernel.org

Hi Dmitry,

Thanks for your feedback!

On Wed, Feb 27, 2013 at 7:41 AM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Hi Magnus,
>
> On Tue, Feb 26, 2013 at 10:26:23PM +0900, Magnus Damm wrote:
>> From: Magnus Damm <damm@opensource.se>
>>
>> Update the Emma Mobile GPIO driver to add DT support.
>>
>
> ...
>
>> @@ -366,15 +387,33 @@ static int em_gio_remove(struct platform
>>       return 0;
>>  }
>>
>
> #ifdef CONFIG_OF here? No need to have extra aliases in modules if OF
> support is not enabled (or is entire ARM arch now enables device tree?).
>
>> +static const struct of_device_id em_gio_dt_ids[] = {
>> +     { .compatible = "renesas,em-gio", },
>> +     {},
>> +};
>> +MODULE_DEVICE_TABLE(of, em_gio_dt_ids);
>> +

I suppose we could sprinkle a couple of #ifdefs across the code, but I
have to say that I'm not that fond of #ifdefs in general. So if it was
up to me only then I would aim at having exactly zero #ifdefs in my
drivers at the expense of slightly larger binaries in some cases.

Are you interested in hacking on EMEV2 in general? I assume you're
busy, but I could try to locate a developer board for you if you'd
like.

Cheers,

/ magnus
