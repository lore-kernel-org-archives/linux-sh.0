From: Magnus Damm <magnus.damm@gmail.com>
Date: Wed, 05 Feb 2014 12:36:14 +0000
Subject: Re: [PATCH 08/11] ARM: shmobile: lager.dtb: add usbphy reference
Message-Id: <CANqRtoTmkbmTrVwaXuSJ98SjQJ21yTbgsuk5-7YbN9n_mtXkLg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1391595554-20640-9-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1391595554-20640-9-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Feb 5, 2014 at 7:19 PM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
> Enable the usbphy node so that the phy driver is available.
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> Reviewed-by: Ian Molton <ian.molton@codethink.co.uk>
> ---
> Cc: linux-sh@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Cc: Simon Horman <horms@verge.net.au>
> ---
>  arch/arm/boot/dts/r8a7790-lager.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/r8a7790-lager.dts b/arch/arm/boot/dts/r8a7790-lager.dts
> index 15e21d0..f6d795d 100644
> --- a/arch/arm/boot/dts/r8a7790-lager.dts
> +++ b/arch/arm/boot/dts/r8a7790-lager.dts
> @@ -129,3 +129,7 @@
>         pinctrl-0 = <&usb2_pins>;
>         pinctrl-names = "default";
>  };
> +
> +&usbphy {
> +       status = "okay";
> +};

This looks a bit too simple to be 100% correct. =)

I don't have any experience with using DT to describe a USB PHY
driver, so perhaps this rather simple proposal is the best way
forward. I'm afraid that I don't have any good counter proposal, but
despite this I somehow expected that the relationship between USB0,
USB2 and the PHY should be pointed out in DT somehow. Also, what is
available may vary with SoC so port configuration may not be entirely
static unfortunately.

When we add DT bindings to the USBHS driver we may be able to add some
nesting or pointer to the PHY, so we may be able to handle the PHY in
that case somehow. We anyway need to convert all the usbhs board
callbacks so perhaps there is some overlap. But for OHCI / EHCI I'm
not sure sure how to hook in a PHY in a sane way. Especially with DT.

On r8a7791 Koelsch we have proper cable detection, but is switching
between USBHS and OHCI/EHCI on the fly really a sane expected use
case? I'd say stick to USBHS in Host or Gadget mode only for simple
software support. I'm not sure if the PHY needs to be configured
depending on USBHS Host or Gadget. Anyway, we want the binding to
allow some flexibility for the future too.

Thanks,

/ magnus
