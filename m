From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 27 Nov 2014 14:17:41 +0000
Subject: Re: [PATCH/RFC] gpio: em: Use dynamic allocation of GPIOs
Message-Id: <CACRpkdZ-y1bgJBYSzBRLNxughMKS86QWfauzNYGreFG_uB-0uA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416234632-16166-1-git-send-email-geert+renesas@glider.be>
	<CAAVeFuKGYM56KP8TOZAwSjDGWrVNoK1phpxoOdEJ=Ng9haSnmg@mail.gmail.com>
In-Reply-To: <CAAVeFuKGYM56KP8TOZAwSjDGWrVNoK1phpxoOdEJ=Ng9haSnmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-SH <linux-sh@vger.kernel.org>

On Tue, Nov 18, 2014 at 4:11 AM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Mon, Nov 17, 2014 at 11:30 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:

>> -               ret = of_alias_get_id(pdev->dev.of_node, "gpio");
>> -               if (ret < 0) {
>> -                       dev_err(&pdev->dev, "Couldn't get OF id\n");
>> -                       goto err0;
>> -               }
>> -               pdata->gpio_base = ret * 32; /* 32 GPIOs per instance */
>> +               pdata->gpio_base = -1;
>
> User-space might break because of GPIO renumbering. Why not setting
> gpio_base to -1 when the property is not present (instead of
> triggering an error), keeping support for the property so existing
> boards remain safe, and marking the property as deprecated in the
> bindings documentation?

I don't like the way aliases are used here.

These bindings are undocumented by the way :( :( :(

I've applied it to wait and see what happens instead.

Yours,
Linus Walleij
