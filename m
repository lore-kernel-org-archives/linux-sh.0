From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 06 May 2014 07:43:30 +0000
Subject: Re: [PATCH/RFC 3/4] of/clk: Register clocks suitable for Runtime PM with the PM core
Message-Id: <CAPDyKFoSOUfgvrKE8x3dih7xvm3VBoNZHjPxWCtFw_h-QALqvw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398334403-26181-1-git-send-email-geert+renesas@glider.be>
 <1398334403-26181-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFpTwPDu9afhOjhhQ2PKGFB+hWsp=mcaYTq8OvuGF7yT3Q@mail.gmail.com>
 <CAMuHMdUGdfF8x58dz46VWNsC4X0cmFng39Z2xSO_pXYqn9u=HA@mail.gmail.com>
In-Reply-To: <CAMuHMdUGdfF8x58dz46VWNsC4X0cmFng39Z2xSO_pXYqn9u=HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 2 May 2014 16:35, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Ulf,
>
> On Fri, May 2, 2014 at 10:56 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> +static int of_clk_pm_runtime_suspend(struct device *dev)
>>> +{
>>> +       int ret;
>>> +
>>> +       ret = pm_generic_runtime_suspend(dev);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = pm_clk_suspend(dev);
>>
>> What about slow clocks? Those aren't handled with pm_clk_suspend().
>
> How are slow clocks handled?

clk_prepare|unprepare - these functions may sleep.

Kind regards
Ulf Hansson

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
