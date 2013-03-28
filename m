From: Magnus Damm <magnus.damm@gmail.com>
Date: Thu, 28 Mar 2013 06:03:26 +0000
Subject: Re: [PATCH/RFC 00/12] Split PFC and GPIO for R8A7779
Message-Id: <CANqRtoQ37BcyBLiSdC=aALNS2Q=vgqEMntg2gqyKoEF1Fyt9fA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1362941928-18115-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1362941928-18115-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Mar 11, 2013 at 3:58 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Hello,
>
> This patch set replaces the GPIO handling code in the PFC driver with the
> Renesas R-Car (R8A7779) GPIO driver submitted by Magnus Damm.
>
> Patch 01/12 adds the R-Car GPIO driver. I've picked the patch from the
> linux-sh mailing as-is. Review for this patch should be directed to the
> mailing list in the "[PATCH] gpio: Renesas R-Car GPIO driver" thread. Patch
> 02/12 further extends the GPIO driver to add pinctrl support.
>
> Patch 03/12 adds a GPIO LEDs device to the Marzen board. This isn't strictly
> required by this patch series but is useful for test purposes.
>
> Patches 04/12 to 07/12 make GPIOs support optional in the PFC driver and fix
> the pin configuration code to support an external GPIO driver.
>
> Patches 08/12 to 10/12 remove function GPIOs from the R-Car platform and
> remove the now unused GPIO enumeration.
>
> Finally patches 11/12 and 12/12 register GPIO devices for the R-Car platform
> and remove GPIO data from the R-Car SoC data.
>
> The PFC GPIO code isn't removed as all platforms will need to be converted
> first. This is a first step towards that goal.
>
> Laurent Pinchart (11):
>   gpio-rcar: Add pinctrl support
>   ARM: shmobile: marzen: Add GPIO LEDs
>   sh-pfc: Make function GPIOs support optional
>   sh-pfc: Make GPIO support optional
>   sh-pfc: Skip gpiochip registration when no GPIO resource is found
>   sh-pfc: Configure pins as GPIOs at request time when handled
>     externally
>   sh-pfc: r8a7779: Remove function GPIOs
>   sh-pfc: r8a7779: Don't use GPIO enum entries
>   ARM: shmobile: r8a7779: Remove all GPIOs
>   ARM: shmobile: r8a7779: Register GPIO devices
>   sh-pfc: r8a7779: Remove GPIO data

Thanks, looking good. They work well too!

If it still matters, for the above patches:

Acked-by: Magnus Damm <damm@opensource.se>
