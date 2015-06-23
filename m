From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Jun 2015 13:45:43 +0000
Subject: Re: [PATCH 2/2] PM / Domains: Avoid infinite loops in attach/detach code
Message-Id: <CAMuHMdU8sHuAKrRvVF1pV7FOCLYrdi1xfAiqb50tfJWhKK3jDQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1434622954-26747-3-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Rafael,

On Tue, Jun 23, 2015 at 3:38 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
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
> A usual approach to this kind of thing is to use exponential fallback
> where you increase the delay twice with respect to the previous one
> every time.

Right, but when do you give up?

Note that udelay() is a busy loop. Should it fall back to msleep() after
a while?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
