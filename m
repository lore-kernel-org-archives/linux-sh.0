From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 08 Jan 2014 10:23:16 +0000
Subject: Re: [PATCH 3/4] thermal: rcar: Add missing clock handling
Message-Id: <CAMuHMdW+1yP2PqvLTc0tjyrnhGssvn_iK8mCO6u-++pjGYR9KQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1389121036-3555-1-git-send-email-geert@linux-m68k.org>
 <1389121036-3555-4-git-send-email-geert@linux-m68k.org>
 <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87ha9fxoua.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Jan 8, 2014 at 2:08 AM, Kuninori Morimoto
<kuninori.morimoto.gx@gmail.com> wrote:
>> +     common->clk = devm_clk_get(&pdev->dev, NULL);
>> +     if (IS_ERR(common->clk)) {
>> +             dev_err(&pdev->dev, "cannot get clock\n");
>> +             return PTR_ERR(common->clk);
>> +     }
>> +
>> +     ret = clk_prepare(common->clk);
>> +     if (ret < 0) {
>> +             dev_err(&pdev->dev, "unable to prepare clock\n");
>> +             return ret;
>> +     }
>> +
>> +     clk_enable(common->clk);
>> +
>>       pm_runtime_enable(dev);
>>       pm_runtime_get_sync(dev);
>
> And this patch seems strange for me.
> pm_runtime_xxx() is doing same things.
> If it didn't work, wrong place is not driver, clock side ?

That's an interesting observation...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
