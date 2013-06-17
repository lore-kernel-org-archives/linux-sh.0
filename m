From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 17 Jun 2013 09:22:06 +0000
Subject: Re: [PATCH] gpio-rcar: Use OUTDT when reading GPIOs configured as output
Message-Id: <CANqRtoSM78Yh_ZmOj2FSAvugmNcUj67Rgz1WHH9i+qfndJuASQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20130616234152.23721.85467.sendpatchset@w520>
In-Reply-To: <20130616234152.23721.85467.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Linus,

On Mon, Jun 17, 2013 at 5:35 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jun 17, 2013 at 1:41 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
>
>> From: Magnus Damm <damm@opensource.se>
>>
>> Testing on r8a7790 shows that INDT does not indicate the correct
>> pin state when reading a GPIO configured as output, so update
>> the gpio_rcar_get() function to handle this case.
>>
>> Signed-off-by: Magnus Damm <damm@opensource.se>
>
> Patch applied. Unless you need this to go through some SH
> tree, I'm carrying it in the GPIO tree.

Thanks a lot! You carrying it in the GPIO tree sounds perfect to me.

Cheers,

/ magnus
