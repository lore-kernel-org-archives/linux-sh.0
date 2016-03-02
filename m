From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 02 Mar 2016 09:39:15 +0000
Subject: Re: [PATCH 1/6] rtc: generic: allow building on all architectures
Message-Id: <CAMuHMdX2Jc4dT5omKmiie7GK+xDYDgJwm34hwANx3HzHt7LzxA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1456851608-3374907-1-git-send-email-arnd@arndb.de>
 <1456851608-3374907-2-git-send-email-arnd@arndb.de>
 <CAMuHMdW5+jZ1n9WnCwBrGSGjUa8ziNTTqf-H15EFTQC_iwnw+Q@mail.gmail.com>
 <mvmwpplns8n.fsf@hawking.suse.de>
In-Reply-To: <mvmwpplns8n.fsf@hawking.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Mar 2, 2016 at 10:28 AM, Andreas Schwab <schwab@linux-m68k.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>>> +#else
>>> +#define generic_rtc_ops *(struct rtc_class_ops*)NULL
>>> +#endif
>>>
>>>  static int __init generic_rtc_probe(struct platform_device *dev)
>>>  {
>>>         struct rtc_device *rtc;
>>> +       const struct rtc_class_ops *ops;
>>> +
>>> +       ops = dev_get_platdata(&dev->dev);
>>> +       if (!ops)
>>> +               ops = &generic_rtc_ops;
>>
>> I hope no compiler version treats "&*(struct rtc_class_ops*)NULL" as
>> undefined behavior?
>
> Yes, that is guaranteed, the operations cancel each other (6.5.3.2#3: If
> the operand is the result of a unary * operator, neither that operator
> nor the & operator is evaluated and the result is as if both were
> omitted).

Thanks for confirming.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
