From: Stephen Warren <swarren@wwwdotorg.org>
Date: Mon, 12 Aug 2013 17:43:01 +0000
Subject: Re: [PATCH] pwm: renesas-tpu: Add DT support
Message-Id: <52091EA5.7070000@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1374791261-9850-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: linux-pwm@vger.kernel.org, linux-sh@vger.kernel.org, devicetree@vger.kernel.org, Ian Campbell <ian.campbell@citrix.com>, Mark Rutland <Mark.Rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <rob.herring@calxeda.com>, Kumar Gala <galak@codeaurora.org>

On 07/25/2013 04:27 PM, Laurent Pinchart wrote:
> Specify DT bindings for the TPU PWM controller and add OF support to the
> driver.

> diff --git a/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt b/Documentation/devicetree/bindings/pwm/renesas,tpu-pwm.txt

> +  - compatible: should be one of the following.
> +    - "renesas,tpu-r8a73a4": for R8A77A4 (R-Mobile APE6) compatible PWM controller.
> +    - "renesas,tpu-r8a7740": for R8A7740 (R-Mobile A1) compatible PWM controller.

In the bindings I've seen, it's more typical for the compatible value to
be ${vendor},${soc}-${unit} than ${vendor},${unit}-${soc}. I guess I
don't know how common one format or the other is though.

Other than that, the binding,
Acked-by: Stephen Warren <swarren@nvidia.com>
