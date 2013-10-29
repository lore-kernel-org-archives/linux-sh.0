From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Oct 2013 08:52:59 +0000
Subject: gpio-rcar: DT and IRQ_TYPE_EDGE_BOTH
Message-Id: <20131029085258.GE15731@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: SH-Linux <linux-sh@vger.kernel.org>, devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Laurent,

In 7e1092b5a264c4 ("gpio-rcar: Add support for IRQ_TYPE_EDGE_BOTH")
I added a 'has_both_edge_trigger' field to struct gpio_rcar_config.
Setting this adds support IRQ_TYPE_EDGE_BOTH. The motivation for
this was to allow use of the gpio-keys driver on the lager board.

I am now looking at enabling gpio-keys via DT for koelsch and lager
and find myself needing to set has_both_edge_trigger somehow.
I am wondering if you have any ideas on how best to do this.

So far I have two ideas:

1. Expose has_both_edge_trigger as a binding.

2. Set has_both_edge_trigger in the driver if the
   compat string is renesas,gpio-r8a7791 or renesas,gpio-r8a7790
   but not for other supported compat strings (as is currently the case).

