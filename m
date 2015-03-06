From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 06 Mar 2015 10:45:56 +0000
Subject: Re: [PATCH 1/4] pinctrl: sh-pfc: Do not overwrite bias configuration
Message-Id: <CACRpkdaCk26hq9ZjTbzn3dqPCnhALmN=96aQ30Cigk4nqGTJdg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1425058685-12956-1-git-send-email-geert+renesas@glider.be>
	<1425058685-12956-2-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1425058685-12956-2-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

On Fri, Feb 27, 2015 at 6:38 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:

> After the last user of the in_pd/in_pu bias parameters of the _PCRH()
> macro was removed in commit 80da8e02d22caaef ("sh-pfc: r8a7740: Add bias
> (pull-up/down) pinconf support"), bias parameters are supposed to be
> configured using the generic pinctl mechanism, which calls the
> .set_bias() method.
>
> However, the PORTCR() macro still represents the control register as
> consisting of two 4-bit fields. Hence the bias configuration in the
> uppermost 2 bits is always overwritten with zeroes when a pin is
> configured for GPIO, disabling any previously configured bias.
>
> Use the variable config register macro instead, to represent the
> register as having 4 fields, and to make sure only the input/output
> control and function fields are touched.
>
> This affects R-Mobile APE6 (r8a73a4), R-Mobile A1 (r8a7740), SH-Mobile
> AP4 (sh7372), and SH-Mobile AG5 (sh73a0).
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Patch applied with Laurent's ACK.

Yours,
Linus Walleij
