From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 17 Nov 2014 14:42:02 +0000
Subject: Re: [PATCH/RFC] gpio: em: Use dynamic allocation of GPIOs
Message-Id: <CAMuHMdUGC=15doK2tJB80jqbk1BBTnGK--D3yW93APOoW_ZFqQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416234632-16166-1-git-send-email-geert+renesas@glider.be>
	<3857937.SYWZS9fGq6@wuerfel>
In-Reply-To: <3857937.SYWZS9fGq6@wuerfel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Arnd,

On Mon, Nov 17, 2014 at 3:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 17 November 2014 15:30:32 Geert Uytterhoeven wrote:
>> Use dynamic allocation of GPIOs instead of looking at the gpio%u alias
>> in DT.
>> ---
>>   - Is this correct? Not having to care about the alias would simplify the
>>     to-be-written DT binding documentation.
>>   - Completely untested.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>>
>
> This will obviously break any user that expects a particular gpio
> number, in particular board files, but I guess also user space
> that tries to access the gpios through sysfs.
>
> If you don't have any of those, I guess it's correct.

Emev2/kzm9d was the first DT-only shmobile SoC/board, so the kernel
part should be OK.

No idea about userspace.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
