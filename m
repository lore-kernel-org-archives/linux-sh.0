From: Rob Herring <robherring2@gmail.com>
Date: Tue, 06 Oct 2015 14:52:17 +0000
Subject: Re: [PATCH] pwm: pwm-rcar: Revise the device tree binding document about compatible
Message-Id: <CAL_JsqJHv+_q-eGVOhjcdsL2SRvzogRqS8Z_6rKjZDCGZOxnrQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1444130908-8180-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1444130908-8180-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Linux PWM List <linux-pwm@vger.kernel.org>, SH-Linux <linux-sh@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Oct 6, 2015 at 6:28 AM, Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> The compatible should be "renesas,pwm-rcar", and one the the SoC
> specific string. So, this patch revises the documentation.
>
> Reported-by: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
>  Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> index ea0a27b..0822a08 100644
> --- a/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> +++ b/Documentation/devicetree/bindings/pwm/renesas,pwm-rcar.txt
> @@ -1,8 +1,7 @@
>  * Renesas R-Car PWM Timer Controller
>
>  Required Properties:
> -- compatible: should be one of the following.
> - - "renesas,pwm-rcar": for generic R-Car compatible PWM Timer
> +- compatible: should be "renesas,pwm-rcar" and one of the following.
>   - "renesas,pwm-r8a7778": for R-Car M1A
>   - "renesas,pwm-r8a7779": for R-Car H1
>   - "renesas,pwm-r8a7790": for R-Car H2
> --
> 1.9.1
>
