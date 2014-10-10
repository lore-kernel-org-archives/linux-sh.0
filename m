From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 10 Oct 2014 06:48:46 +0000
Subject: Re: [PATCH] usb: host: xhci-plat: fix suspend/resume on xhci-rcar
Message-Id: <CAMuHMdVt3X3q3Tqm8mZGkooj5FbtL6+sO0QhpB_Cc3oqfegb4A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1412829947-736-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 9, 2014 at 4:14 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Thu, Oct 09, 2014 at 01:45:47PM +0900, Yoshihiro Shimoda wrote:
>> This patch fixes an issue that suspend/resume cannot work correctly
>> on xhci-rcar because the xhci driver output the following log:
>>
>>         xhci-hcd ee000000.usb: WARN: xHC CMD_RUN timeout
>>
>> So, this patch adds to set the XHCI_SLOW_SUSPEND quirk if xhci-rcar.
>
> do you have erratum number confirming this is needed for your platform ?
> We really don't want to enable quirks just because they help, we need to
> be sure HW is quirky. For example, we triggered the same thing on DRA7xx
> (which uses dwc3) but after digging a little, it seems like we're having
> memory access latency issues, not a problem with XHCI.

FWIW, xhci_handshake() runs a tight loop around udelay(1) for up to 16 ms
(160 ms when the quirk is enabled --- not counting loop overhead),
which looks like an area for improvement.

As the individual udelay() calls wait for only 1 us, the __bad_udelay()
sanity check "Use only for very small delays ( < 2 msec)" doesn't kick in.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
