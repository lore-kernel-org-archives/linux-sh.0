From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 30 Nov 2015 12:46:29 +0000
Subject: Re: [PATCH v2] pinctrl: sh-pfc: Improve pinmux macros documentation
Message-Id: <CAMuHMdWPcq5q9jDGcwdnuHHHr4tKwL4ZkVP0u493HbDYh=HfTA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1445368482-24278-1-git-send-email-geert+renesas@glider.be>
	<7920206.k8fTIRXnzu@avalon>
In-Reply-To: <7920206.k8fTIRXnzu@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niso@kth.se>, Koji Matsuoka <koji.matsuoka.xm@rms.renesas.com>, Magnus Damm <damm@opensource.se>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Linus Walleij <linus.walleij@linaro.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>

Hi Laurent,

On Wed, Nov 25, 2015 at 2:37 AM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 20 October 2015 21:14:42 Geert Uytterhoeven wrote:
>> Fix some s/ispr/ipsr/ typos in macro parameters while we're at it.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> v2:
>>   - Clarify same width vs. different widths,
>>   - Mention GPSR for PINMUX_IPSR_DATA(),
>>   - Document NOGM (= NOGP + MSEL),
>>   - Fix s/ispr/ipsr/ typos.
>> ---
>>  drivers/pinctrl/sh-pfc/sh_pfc.h | 84 ++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 81 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sh-pfc/sh_pfc.h
>> b/drivers/pinctrl/sh-pfc/sh_pfc.h index 7b373d43d981899f..63e6cd050d0fb7d2
>> 100644
>> --- a/drivers/pinctrl/sh-pfc/sh_pfc.h
>> +++ b/drivers/pinctrl/sh-pfc/sh_pfc.h

>> -#define PINMUX_IPSR_NOGP(ispr, fn)                                   \
>> +/*
>> + * Describe a pinmux configuration without GPIO function that needs
>> + * configuration in a Peripheral Function Select Register (IPSR)
>> + *   - ipsr: IPSR field (unused, for documentation purposes only)
>> + *   - fn: Function name
>> + */
>> +#define PINMUX_IPSR_NOGP(ipsr, fn)                                   \
>>       PINMUX_DATA(fn##_MARK, FN_##fn)
>
> That's very confusing, as the ipsr argument is indeed unused, but the fn
> argument refers to a field value in an IPSR register. Could we fix that ? The

Long live reverse-engineering pinctrl macros...

> same comment applies for other macros below.

OK.

>> +/*
>> + * Describe a pinmux configuration with GPIO function that needs
>> configuration
>> + * in both a Peripheral Function Select Register (IPSR) and in a
>> + * GPIO/Peripheral Function Select Register 1 (GPSR)
>> + *   - ipsr: IPSR field
>> + *   - fn: Function name
>> + */
>>  #define PINMUX_IPSR_DATA(ipsr, fn)                                   \
>>       PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ipsr)
>
> Should we rename this to PINMUX_IPSR_GPSR ?

No, I don't want to show up in "git blame" for every single sh-pfc line!

Kidding, yes, will do in a separate patch.

>> -#define PINMUX_IPSR_NOGM(ispr, fn, ms)                                       \
>> +
>> +/*
>> + * Describe a pinmux configuration without GPIO function that needs
>> + * configuration in a Peripheral Function Select Register (IPSR), and where
>> the
>> + * pinmux function has a representation in a configuration register.
>
> I'd talk about module select register instead of configuration register.
> Configuration register is too vague.

OK.

>> + *   - ipsr: IPSR field
>> + *   - fn: Function name
>> + *   - ms: Configuration register selector
>
> I'd rename ms to msel to be more explicit.

OK.

>> +#define PINMUX_IPSR_NOGM(ipsr, fn, ms)                                       \
>>       PINMUX_DATA(fn##_MARK, FN_##fn, FN_##ms)
>> +
>> +/*
>> + * Describe a pinmux configuration where the pinmux function has no
>> + * representation in the configuration registers but instead solely
>> + * depends on a group selection.
>> + *   - ipsr: IPSR field
>> + *   - fn: Function name
>> + *   - ms: Group selector
>> + */
>>  #define PINMUX_IPSR_NOFN(ipsr, fn, ms)                                       \
>>       PINMUX_DATA(fn##_MARK, FN_##ipsr, FN_##ms)
>
> Those pins can be used as GPIO as well, right ? I think that should be
> mentioned.

Indeed.

> The macro is used for emev2 only. It refers to a GPSR bit, not to an IPSR
> register. I think the ipsr argument should be renamed to reflect that.

Done.

>> +/*
>> + * Describe a pinmux configuration where the pinmux function has a
>> + * representation in a configuration register.
>
> You mention "configuration register" here (and in the PINMUX_IPSR_NOGM
> description), while you talk about "group selector" for PINMUX_IPSR_NOFN.
> Aren't they the same ?

More or less. PINMUX_IPSR_NOFN() is special as EMEV2 has different
register sets than other Renesas SoCs.

> As the comments I've made here have an air of déjà vu, I checked my review to
> v1 and realized you haven't replied to it. I don't think all the comments I
> made have been addressed in v2.

I thought I addressed all comments, modulo a few open questions.

Stay tuned for v3...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
