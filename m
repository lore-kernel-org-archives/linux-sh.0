From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 13 Apr 2013 21:22:56 +0000
Subject: Re: [PATCH v9 15/20] sh-mobile-ceu-driver: support max width and height in DT
Message-Id: <5169CCB0.9010705@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1365781240-16149-1-git-send-email-g.liakhovetski@gmx.de> <1365781240-16149-16-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1365781240-16149-16-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-media@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hverkuil@xs4all.nl>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Sakari Ailus <sakari.ailus@iki.fi>, Prabhakar Lad <prabhakar.lad@ti.com>

Hello.

On 12-04-2013 19:40, Guennadi Liakhovetski wrote:

> Some CEU implementations have non-standard (larger) maximum supported
> width and height values. Add two OF properties to specify them.

> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

    Minor grammar nitpicking.

> diff --git a/Documentation/devicetree/bindings/media/sh_mobile_ceu.txt b/Documentation/devicetree/bindings/media/sh_mobile_ceu.txt
> new file mode 100644
> index 0000000..1ce4e46
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/sh_mobile_ceu.txt
> @@ -0,0 +1,18 @@
> +Bindings, specific for the sh_mobile_ceu_camera.c driver:
> + - compatible: Should be "renesas,sh-mobile-ceu"
> + - reg: register base and size
> + - interrupts: the interrupt number
> + - interrupt-parent: the interrupt controller
> + - renesas,max-width: maximum image width, supported on this SoC
> + - renesas,max-height: maximum image height, supported on this SoC

    Commas not needed above.

WBR, Sergei

