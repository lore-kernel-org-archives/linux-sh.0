From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 23 Apr 2014 08:38:58 +0000
Subject: Re: [PATCH RFC 2/2] ARM: shmobile: armadillo800eva defconfig: Enable REGULATOR_GPIO and LEDS_GPIO
Message-Id: <CAMuHMdV8EJ_edZKqtxft8fGjro-NcBwiRiXaDNRtoLC550xQCQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1398171667-24288-1-git-send-email-geert+renesas@glider.be>
	<1398171667-24288-2-git-send-email-geert+renesas@glider.be>
	<20140423005043.GF5738@verge.net.au>
In-Reply-To: <20140423005043.GF5738@verge.net.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Horman <horms@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi Simon,

On Wed, Apr 23, 2014 at 2:50 AM, Simon Horman <horms@verge.net.au> wrote:
> On Tue, Apr 22, 2014 at 03:01:07PM +0200, Geert Uytterhoeven wrote:
>> Refresh armadillo800eva_defconfig, and enable missing options for devices
>> in platform data and/or DT:
>>   - REGULATOR_GPIO
>>   - LEDS_GPIO
>
> I would prefer if changes were made in a more incremental patch.
>
> * A patch to enable LEDS_GPIO and REGULATOR_GPIO.

OK, will do for v2, when I know more about SHMOBILE_IOMMU.

> * Then a cleanup patch, if you really want to do that: but why?

It's a good idea to run a "make savedefconfig" once in a while, to get rid of
stale symbols, and symbols that are now auto-selected.
Anyway, although there were quite some changes in the actual defconfig, the
net impact on "make armadillo800eva_defconfig" is much smaller than I expected
(only CONFIG_NET_VENDOR_SAMSUNG gets enabled), so I'll leave the regular
refreshing to you ;-

>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>> Do we want SHMOBILE_IOMMU, too? The help text says "If unsure, say N."
>> If yes, is the default SHMOBILE_IOMMU_ADDRSIZE_2048MB OK?
>
> I defer to Magnus on that one.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
