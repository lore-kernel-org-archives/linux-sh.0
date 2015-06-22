From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 22 Jun 2015 09:49:35 +0000
Subject: Re: [PATCH 00/08] clocksource: sh_cmt: DT binding rework
Message-Id: <CAMuHMdX_BG7gaXvU9Dp7_idrAi9MKwEkGCaLYcS0U1+6pZ0Dbw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20150621080903.10187.20998.sendpatchset@little-apple>
In-Reply-To: <20150621080903.10187.20998.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: Magnus Damm <magnus.damm@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux-sh list <linux-sh@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Simon Horman <horms+renesas@verge.net.au>, Thomas Gleixner <tglx@linutronix.de>

Hi Magnus,

On Sun, Jun 21, 2015 at 10:09 AM, Magnus Damm <magnus.damm@gmail.com> wrote:
> clocksource: sh_cmt: DT binding rework
>
> [PATCH 01/08] devicetree: bindings: Remove sh7372 CMT binding
> [PATCH 02/08] clocksource: sh_cmt: Use 0x3f mask for SH_CMT_48BIT case
> [PATCH 03/08] devicetree: bindings: R-Car Gen2 CMT0 and CMT1 bindings
> [PATCH 04/08] clocksource: sh_cmt: Support separate R-Car Gen2 CMT0/1
> [PATCH 05/08] devicetree: bindings: r8a73a4 and R-Car Gen2 CMT bindings
> [PATCH 06/08] ARM: shmobile: Update CMT compat string users in DTS
> [PATCH 07/08] devicetree: bindings: Deprecate property, update example
> [PATCH 08/08] ARM: shmobile: Remove CMT renesas,channels-mask from DTS
>
> This series reworks the CMT DT bindings to try to deal with the following:
> - R-Car Gen2 CMT0 and CMT1 hardware instances are not identical
> - The property renesas,channels-mask is not enough to describe the differ=
ence
> - DT should describe the hardware, not the software implementation
> - Not all documented DT bindings are actually used

Thanks for your series!

> Without these patches the binding "renesas,cmt-48-gen2" is used for both
> CMT0 and CMT1 on R-Car Gen2 SoCs. CMT0 and CMT1 are currently seen by the
> Linux device driver as compatible hardware, and the device-specific prope=
rty
> "renesas,channels-mask" is used to point out some of the hardware configu=
ration
> differences. Since the driver is not feature complete only some differenc=
es are
> described and when diving into the data sheet we can see that:
>
> 1) CMT0 is not 48-bit at all, instead it only supports 32-bit counters.
> 2) Some channels of CMT1 are 48-bit, some 32-bit.
> 3) A couple of CMT1 channels have even more features.
>
> It turns out that none of the above differences are described in our curr=
ent
> DT files. And since we use the same compat string for CMT0 and CMT1 the d=
river
> itself cannot enable features specific only to CMT1 without first updating
> the DTS. So this series is ground work for future feature patches.
>
> It seems that we have two choices if we want to support CMT1 features:
> A) Keep existing DT bindings, add more properties for CMT1
> B) Rework the compatible strings and keep configuration in the driver
>
> Judging by above it seems that DT update is inevitable. In my mind it is
> rather painful to update the DT so I'd like to minimize the number of
> updates and let the majority of the changes only happen in the driver.
> And since we should really describe hardware in DT but driver features te=
nd
> to be implemented incrementally then B) seems like a good fit to me.
>
> I wouldn't mind going with A) but to be honest I must say that the existi=
ng
> compat string "renesas,cmt-48-gen2" is just too confusing with "48"
> (when CMT0 is 32bit-only) and also "gen2" (used without product line R-Ca=
r).
>
> Because of that I've gone with B) and reworked the bindings to separate
> CMT0 from CMT1 and keep channel configuration in the device driver.

I'm also in favor of B. I'd also like to use this opportunity to point
to slide 30
of my presentation "Engaging Device Trees" at ELC2014:

  - Avoid adding more properties to differentiate
      - You may be/guess wrong about compatibility
      - What if you discover an incompatibility later?
        =E2=86=92 Use SoC-specific compatible properties from the start

(http://elinux.org/images/e/e2/Engaging_Device_Trees_0.pdf)

> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

(if you implemented my comment on 01/08)
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

(with 02/08 fixed)
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
on sh73a0/kzm9g, r8a7740/armadillo, r8a73a4/ape6evm, r8a7791/koelsch.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-sh" in
