From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 25 Aug 2014 12:59:46 +0000
Subject: Re: [PATCH v2 6/6] devicetree: bindings: Document Renesas JPEG Processing Unit.
Message-Id: <CAMuHMdXQAFVJ8Ezd30JNkT6hWoFYKUWk5e0cq88jYUSBTPOzRA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1408452653-14067-7-git-send-email-mikhail.ulyanov@cogentembedded.com>
	<1408970132-6690-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
In-Reply-To: <1408970132-6690-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Cc: Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Mauro Carvalho Chehab <m.chehab@samsung.com>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans Verkuil <hans.verkuil@cisco.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

Hi Mikhail,

On Mon, Aug 25, 2014 at 2:35 PM, Mikhail Ulyanov
<mikhail.ulyanov@cogentembedded.com> wrote:
> +  - compatible: should containg one of the following:
> +                       - "renesas,jpu-r8a7790" for R-Car H2
> +                       - "renesas,jpu-r8a7791" for R-Car M2
> +                       - "renesas,jpu-gen2" for R-Car second generation

Isn't "renesas,jpu-gen2" meant as a fallback?

I.e. the DTS should have one of '7790 and '7791, AND the gen2 fallback,
so we can make the driver match against '7790 and '7791 is we find
out about an incompatibility.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
