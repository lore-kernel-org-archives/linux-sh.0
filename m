From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Jun 2015 08:35:44 +0000
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Message-Id: <CAMuHMdUzj_jZXw8OdsH89fVmrK-hQZx-wQR7cVbo9d3QJ8JJVg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jun 24, 2015 at 10:33 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> [...]
>
>>>>
>>>> @@ -2183,6 +2191,7 @@ int genpd_dev_pm_attach(struct device *dev)
>>>>  {
>>>>         struct of_phandle_args pd_args;
>>>>         struct generic_pm_domain *pd;
>>>> +       unsigned int i;
>>>>         int ret;
>>>>
>>>>         if (!dev->of_node)
>>>> @@ -2218,10 +2227,13 @@ int genpd_dev_pm_attach(struct device *dev)
>>>>
>>>>         dev_dbg(dev, "adding to PM domain %s\n", pd->name);
>>>>
>>>> -       while (1) {
>>>> +       for (i = 0; i < GENPD_RETRIES; i++) {
>>>>                 ret = pm_genpd_add_device(pd, dev);
>>>>                 if (ret != -EAGAIN)
>>>>                         break;
>>>> +
>>>> +               if (i > GENPD_RETRIES / 2)
>>>> +                       udelay(GENPD_DELAY_US);
>>>
>>> In this execution path, we retry when getting -EAGAIN while believing
>>> the reason to the error are only *temporary* as we are soon waiting
>>> for all devices in the genpd to be system PM resumed. At least that's
>>> my understanding to why we want to deal with -EAGAIN here, but I might
>>> be wrong.
>>>
>>> In this regards, I wonder whether it could be better to re-try only a
>>> few times but with a far longer interval time than a couple us. What
>>> do you think?
>>
>> That's indeed viable. I have no idea for how long this temporary state can
>> extend.
>
> That will depend on the system PM resume time for the devices residing
> in the genpd. So, I guess we need a guestimate then. How about a total
> sleep time of a few seconds?
>
>>
>>> However, what if the reason to why we get -EAGAIN isn't *temporary*,
>>> because we are about to enter system PM suspend state. Then the caller
>>> of this function which comes via some bus' ->probe(), will hang until
>>> the a system PM resume is completed. Is that really going to work? So,
>>> for this case your limited re-try approach will affect this scenario
>>> as well, have you considered that?
>>
>> There's a limit on the number of retries, so it won't hang indefinitely.
>
> What happens with the timer functions (like msleep()) during the
> system PM suspend transition?

I guess we can no longer call msleep() after syscore suspend?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
