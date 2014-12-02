From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 02 Dec 2014 13:26:20 +0000
Subject: Re: [PATCH] gpio: remove gpio_descs global array
Message-Id: <CACRpkda9PbzEOpYABFy46pqow2yyhWJ0iE71GhAS61j5odZArw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1416383487-15993-1-git-send-email-acourbot@nvidia.com>
	<CACRpkdZV-nQPXDnxiBgPTZTpyQ2eiKNL8qJY9jRq=A5foc-xmw@mail.gmail.com>
	<CAMuHMdUQ+rPasUWuGCc0AnV-g6J9zf9HbozuodHaYpy36Khcpg@mail.gmail.com>
	<CAAVeFuJm_UXHioENBg6himgZkEmopr=T8iCbt0xD6-ds6AHyxA@mail.gmail.com>
In-Reply-To: <CAAVeFuJm_UXHioENBg6himgZkEmopr=T8iCbt0xD6-ds6AHyxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alexandre Courbot <gnurou@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Alexandre Courbot <acourbot@nvidia.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Tue, Dec 2, 2014 at 2:25 PM, Alexandre Courbot <gnurou@gmail.com> wrote:
> On Tue, Dec 2, 2014 at 7:32 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:

>> This patch changes a return value from -EPROBE_DEFER to -EINVAL in
>> regulator-gpio when a GPIO cannot be found yet, causing probe failures
>> on r8a7791/koelsch:
>
> Hi Geert,
>
> Thanks for signaling this. I think I understand what is going wrong
> and will send a fixup patch in a few minutes.

OK standing by.

Yours,
Linus Walleij
