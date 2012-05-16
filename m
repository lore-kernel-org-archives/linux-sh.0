From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 16 May 2012 15:47:17 +0000
Subject: Re: [PATCH] gpio: Emma Mobile GPIO driver V2
Message-Id: <CANqRtoT5g7zttqp6Nw58O=Xvo+hPKsBhZGXW_UGutKVh2-SD9w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20120515154333.6659.66479.sendpatchset@w520>
	<20120516072927.GN7988@linux-sh.org>
	<CANqRtoSSEb9jwEmvbhBuyHp-9BfUSRabQzqjrrVGTFDP-AHutQ@mail.gmail.com>
	<201205161209.03985.arnd@arndb.de>
In-Reply-To: <201205161209.03985.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-kernel@vger.kernel.org, rjw@sisk.pl, linus.walleij@stericsson.com, linux-sh@vger.kernel.org, horms@verge.net.au, grant.likely@secretlab.ca, olof@lixom.net

On Wed, May 16, 2012 at 9:09 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 16 May 2012, Magnus Damm wrote:
>> > irq_domain_add_legacy() exists for existing static ranges, which there is
>> > really no reason to be adding in new board/platform support. You don't
>> > have to worry about virq overlap since irq_create_mapping() already wraps
>> > on top of irq_alloc_desc_xxx() for lookup.
>>
>> So I intentionally made use of the legacy domain in the non-DT case.
>> This because I want to let the SoC code set the static IRQ ranges via
>> platform data.
>
> I think it's generally better to use just one code path for both cases,
> if you need both DT and non-DT support, which means you would always
> use irq_domain_add_legacy. Once you have the final patch to convert it
> to DT, you can remove the legacy domain and just convert it to linear.

Sure, I don't mind that at all - it will make the DT bits even easier.

Thanks,

/ magnus
