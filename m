From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 04 Dec 2014 13:51:19 +0000
Subject: Re: [PATCH v6 3/7] ARM: shmobile: R-Mobile: Enable module clocks if !CONFIG_PM_RUNTIME
Message-Id: <CAMuHMdVsuCnqwEoP6k4iM0mnsdTiB=d7y4=EAicB_E_ZSec48Q@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1417614107-5985-1-git-send-email-geert+renesas@glider.be>
 <1417614107-5985-4-git-send-email-geert+renesas@glider.be>
 <CAPDyKFogROGA+MtQcGNfa052wPKxcs9cpT43NcpcyeGVFCwPoQ@mail.gmail.com>
In-Reply-To: <CAPDyKFogROGA+MtQcGNfa052wPKxcs9cpT43NcpcyeGVFCwPoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Ulf,

On Thu, Dec 4, 2014 at 2:41 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> diff --git a/arch/arm/mach-shmobile/pm-rmobile.c b/arch/arm/mach-shmobile/pm-rmobile.c
>> index 168046c355fc8368..6d912ce801aa88bd 100644
>> --- a/arch/arm/mach-shmobile/pm-rmobile.c
>> +++ b/arch/arm/mach-shmobile/pm-rmobile.c
>> @@ -118,6 +118,14 @@ static int rmobile_pd_attach_dev(struct generic_pm_domain *domain,
>>                 goto fail;
>>         }
>>
>> +       if (!IS_ENABLED(CONFIG_PM_RUNTIME)) {
>
> This will require a fixup later on, since using genpd will always be
> done for CONFIG_PM_RUNTIME (or CONFIG_PM actually) ).

Indeed. But this is queued up in a branch that doesn't have the PM unification
yet.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
