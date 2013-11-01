From: Bastian Hecht <hechtb@gmail.com>
Date: Fri, 01 Nov 2013 09:47:37 +0000
Subject: Re: [PATCH 4/5] serial: sh-sci: Add OF support
Message-Id: <CABYn4sxC02bX7XqN8yQ-gYgZEdaHAUohOjyL3pjGYXK9kd8WXg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1383042599-25151-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1383042599-25151-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383042599-25151-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, linux-serial@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>

Hi Laurent!

> +struct sci_port_info {
> +       unsigned int type;
> +       unsigned int regtype;
> +       unsigned int brr_algo;
> +};
> +
> +static const struct of_device_id of_sci_match[] = {
> +       {
> +               .compatible = "renesas,scif-generic",
> +               .data = (void *)&(const struct sci_port_info) {
> +                       .type = PORT_SCIF,
> +                       .regtype = SCIx_SH4_SCIF_REGTYPE,
> +                       .brr_algo = SCBRR_ALGO_2,
> +               },
> +       }, {
> +               .compatible = "renesas,scifa-generic",
> +               .data = (void *)&(const struct sci_port_info) {
> +                       .type = PORT_SCIFA,
> +                       .regtype = SCIx_SCIFA_REGTYPE,
> +                       .brr_algo = SCBRR_ALGO_4,
> +               },
> +       }, {
> +               .compatible = "renesas,scifb-generic",
> +               .data = (void *)&(const struct sci_port_info) {
> +                       .type = PORT_SCIFB,
> +                       .regtype = SCIx_SCIFB_REGTYPE,
> +                       .brr_algo = SCBRR_ALGO_4,
> +               },
> +       }, {
> +               .compatible = "renesas,hscif-generic",
> +               .data = (void *)&(const struct sci_port_info) {
> +                       .type = PORT_HSCIF,
> +                       .regtype = SCIx_HSCIF_REGTYPE,
> +                       .brr_algo = SCBRR_ALGO_6,
> +               },
> +       }, {
> +               /* Terminator */
> +       },
> +};
> +MODULE_DEVICE_TABLE(of, of_sci_match);

I like this version way better than my initial approach, given that we
only support ARM based ports and we hope the regtype and brr_algo
won't deviate a lot from the given generic settings for new chips -
else the of_sci_match[] array might become a bit bloated. This was the
former reasoning to introduce all the clumsy OF fields.

I'm happy that the sci OF support will finally make it into the
mainline, thanks Laurent!

Bastian
