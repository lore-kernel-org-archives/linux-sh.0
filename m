From: Alexandre Courbot <gnurou@gmail.com>
Date: Tue, 02 Dec 2014 13:25:16 +0000
Subject: Re: [PATCH] gpio: remove gpio_descs global array
Message-Id: <CAAVeFuJm_UXHioENBg6himgZkEmopr=T8iCbt0xD6-ds6AHyxA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416383487-15993-1-git-send-email-acourbot@nvidia.com>
 <CACRpkdZV-nQPXDnxiBgPTZTpyQ2eiKNL8qJY9jRq=A5foc-xmw@mail.gmail.com> <CAMuHMdUQ+rPasUWuGCc0AnV-g6J9zf9HbozuodHaYpy36Khcpg@mail.gmail.com>
In-Reply-To: <CAMuHMdUQ+rPasUWuGCc0AnV-g6J9zf9HbozuodHaYpy36Khcpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <acourbot@nvidia.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Dec 2, 2014 at 7:32 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Linus, Alexandre,
>
> On Fri, Nov 28, 2014 at 11:29 AM, Linus Walleij
> <linus.walleij@linaro.org> wrote:
>> On Wed, Nov 19, 2014 at 8:51 AM, Alexandre Courbot <acourbot@nvidia.com> wrote:
>>> Replace the ARCH_NR_GPIOS-sized static array of GPIO descriptors by
>>> dynamically-allocated arrays for each GPIO chip.
>>>
>>> This change makes gpio_to_desc() perform in O(n) (where n is the number
>>> of GPIO chips registered) instead of O(1), however since n is rarely
>>> bigger than 1 or 2 no noticeable performance issue is expected.
>>> Besides this provides more incentive for GPIO consumers to move to the
>>> gpiod interface. One could use a O(log(n)) structure to link the GPIO
>>> chips together, but considering the low limit of n the hypothetical
>>> performance benefit is probably not worth the added complexity.
>>>
>>> This patch uses kcalloc() in gpiochip_add(), which removes the ability
>>> to add a chip before kcalloc() can operate. I am not aware of such
>>> cases, but if someone bisects up to this patch then I will be proven
>>> wrong...
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>
>> OK patch applied. Let's see if the world explodes.
>
> This patch changes a return value from -EPROBE_DEFER to -EINVAL in
> regulator-gpio when a GPIO cannot be found yet, causing probe failures
> on r8a7791/koelsch:

Hi Geert,

Thanks for signaling this. I think I understand what is going wrong
and will send a fixup patch in a few minutes.

Cheers,
Alex.
