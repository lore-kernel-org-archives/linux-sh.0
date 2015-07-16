From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 16 Jul 2015 06:29:01 +0000
Subject: Re: [PATCH] clk: shmobile: Remove unneeded #include <linux/clkdev.h>
Message-Id: <CAMuHMdXnUgWFCrEt6hBh9bThzk-VexoyU54h-xmiWeShMLmzeg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1435064967-12299-1-git-send-email-geert+renesas@glider.be>
	<20150716000819.GU30412@codeaurora.org>
In-Reply-To: <20150716000819.GU30412@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, linux-clk@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>

Hi Stephen,

On Thu, Jul 16, 2015 at 2:08 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> On 06/23, Geert Uytterhoeven wrote:
>> diff --git a/drivers/clk/shmobile/clk-rcar-gen2.c b/drivers/clk/shmobile/clk-rcar-gen2.c
>> index 9612e3145b7ea370..745496f7ee9c7402 100644
>> --- a/drivers/clk/shmobile/clk-rcar-gen2.c
>> +++ b/drivers/clk/shmobile/clk-rcar-gen2.c
>> @@ -11,15 +11,13 @@
>>   */
>>
>>  #include <linux/clk-provider.h>
>> -#include <linux/clkdev.h>
>>  #include <linux/clk/shmobile.h>
>>  #include <linux/init.h>
>>  #include <linux/kernel.h>
>>  #include <linux/math64.h>
>>  #include <linux/of.h>
>>  #include <linux/of_address.h>
>> -#include <linux/pm_clock.h>
>> -#include <linux/pm_domain.h>
>> +#include <linux/slab.h>
>
> Is this the right diff? I wanted to apply this to clk-next but it
> fails here because we don't have the pm_clock.h and pm_domain.h
> includes in this file.
>
>>  #include <linux/spinlock.h>

Oops, these two lines were due to a bad rebase, and shouldn't be there.
Just ignore them. Sorry for the trouble.

Shall I send a new patch?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
