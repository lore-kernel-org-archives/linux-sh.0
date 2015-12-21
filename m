From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 21 Dec 2015 13:16:36 +0000
Subject: Re: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
Message-Id: <CAMuHMdUKHO50n_OAhx-OcZX9FwN+dUbZCHnjP4HaPqgt3j=MzQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
	<1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
	<20151217133058.GA20372@katana>
	<PS1PR06MB1180304088ECF5384C497E40F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
	<20151218140412.GA4595@katana>
	<KL1PR06MB1174165C6112327548CD29DDF5E40@KL1PR06MB1174.apcprd06.prod.outlook.com>
In-Reply-To: <KL1PR06MB1174165C6112327548CD29DDF5E40@KL1PR06MB1174.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Phil,

(this time with full CC list)

On Mon, Dec 21, 2015 at 11:52 AM, Phil Edworthy
<phil.edworthy@renesas.com> wrote:
> On 18 December 2015 14:04, Wolfram Sang wrote:
>> > Since the hardware doesn't support hot plug, I believe this loop will
>> > always exit very quickly. Unless someone has taken a hammer to the HW
>> > of course.
>>
>> I know what you mean. But since readl_poll_timeout() makes it easy, we
>> should better be safe than sorry.
> Hmm, I changed the code, but now it doesn't come out of suspend unless
> sleep_us passed to readl_poll_timeout is 0. Any reason you can think of?

Timers or interrupts disabled?

Does the might_sleep_if() scream if CONFIG_DEBUG_ATOMIC_SLEEP=y?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
