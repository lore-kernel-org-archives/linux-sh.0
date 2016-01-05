From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 Jan 2016 12:55:44 +0000
Subject: Re: [PATCH 4/6] arm64: renesas: salvator-x: enable usb2_phy
Message-Id: <CAMuHMdW7odgpbiPTjd27JMA2axvqXjHHsEGCdPxcy6K4QueqiA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1451037839-572-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
	<1451037839-572-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1451037839-572-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, linux-arm-kernel@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>

Hi Shimoda-san,

On Fri, Dec 25, 2015 at 11:03 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> index 265d12f..7353407 100644
> --- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> +++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
> @@ -122,8 +122,22 @@
>                                  "audio_clkout_a", "audio_clkout3_a";
>                 renesas,function = "audio_clk";
>         };
> -};
>
> +       usb0_pins: usb0 {
> +               renesas,groups = "usb0";
> +               renesas,function = "usb";
> +       };
> +
> +       usb1_pins: usb1 {
> +               renesas,groups = "usb1";
> +               renesas,function = "usb";
> +       };
> +
> +       usb2_pins: usb2 {
> +               renesas,groups = "usb2";
> +               renesas,function = "usb";
> +       };

sh-pfc e6060000.pfc: function 'usb' not supported
sh-pfc e6060000.pfc: invalid function usb in map table
sh-pfc e6060000.pfc: function 'usb' not supported
sh-pfc e6060000.pfc: invalid function usb in map table
sh-pfc e6060000.pfc: function 'usb' not supported
sh-pfc e6060000.pfc: invalid function usb in map table

As the usb patches for pfc-r8a7795 haven't been posted yet, it's difficult
to test/comment.

Note that the functions were called "usb%u" in a previous version, and in the
pfc-r8a7795 code in the BSP.

Can you please post the pfc-r8a7795 patches, too?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
