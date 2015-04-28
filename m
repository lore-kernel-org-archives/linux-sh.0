From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2015 16:55:37 +0000
Subject: Re: [PATCH] usb: phy: Remove the phy-rcar-gen2-usb driver
Message-Id: <CAMuHMdXoJQ4=U+jOK+zb+ZsDjd+TJWZeOTCiFRcBR=iu5gs6ow@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1430222647-1845-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1430222647-1845-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Felipe,

On Tue, Apr 28, 2015 at 6:50 PM, Felipe Balbi <balbi@ti.com> wrote:
> On Tue, Apr 28, 2015 at 02:04:07PM +0200, Geert Uytterhoeven wrote:
>> The phy-rcar-gen2-usb driver, which supports legacy platform data only,
>> is no longer used since commit a483dcbfa21f919c ("ARM: shmobile: lager:
>> Remove legacy board support").
>>
>> This driver was superseded by the DT-only phy-rcar-gen2 driver, which
>> was introduced in commit 1233f59f745b237d ("phy: Renesas R-Car Gen2 PHY
>> driver").
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> ---
>>  drivers/usb/phy/Kconfig                         |  13 --
>>  drivers/usb/phy/Makefile                        |   1 -
>>  drivers/usb/phy/phy-rcar-gen2-usb.c             | 246 ------------------------
>>  include/linux/platform_data/usb-rcar-gen2-phy.h |  22 ---
>>  4 files changed, 282 deletions(-)
>>  delete mode 100644 drivers/usb/phy/phy-rcar-gen2-usb.c
>>  delete mode 100644 include/linux/platform_data/usb-rcar-gen2-phy.h
>>
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index 2175678e674ebf44..3cd3bee54ca6f9b3 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -186,19 +186,6 @@ config USB_RCAR_PHY
>>         To compile this driver as a module, choose M here: the
>>         module will be called phy-rcar-usb.
>>
>> -config USB_RCAR_GEN2_PHY
>
> $ git grep -e USB_RCAR_GEN2_PHY
> arch/arm/configs/multi_v7_defconfig:448:CONFIG_USB_RCAR_GEN2_PHY=m
> arch/arm/configs/shmobile_defconfig:163:CONFIG_USB_RCAR_GEN2_PHY=y
>
> Are you sending patches to fix both defconfigs ?

http://www.spinics.net/lists/arm-kernel/msg414542.html
http://www.spinics.net/lists/arm-kernel/msg414543.html

The driver doesn't work anyway in these (DT-only) configs, as it supports
platform data only.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
