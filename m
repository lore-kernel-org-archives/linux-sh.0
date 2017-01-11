From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Jan 2017 12:37:58 +0000
Subject: Re: [PATCH v1.1 19/19] serial: sh-sci: Compute the regshift value for SCI ports
Message-Id: <CAMuHMdXr5sd8F0HhGJCnpv+8b4koueqmVoLuL0YqjUr-_Jj1og@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <CAMuHMdVgTMb56mogTSCA0ePCMoy4SCW-5qKCasZYDPU3TJRsKQ@mail.gmail.com>
 <20170106122129.8554-1-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20170106122129.8554-1-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

Hi Laurent,

On Fri, Jan 6, 2017 at 1:21 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> SCI instances found in SH SoCs have different spacing between registers
> depending on the SoC. The platform data contains a regshift field that
> tells the driver by how many bits to shift the register offset to
> compute its address. We can compute the regshift value automatically
> based on the memory resource size, there's no need to pass the value
> through platform data.
>
> Fix the sh7750 SCI and sh7760 SIM port memory resources length to ensure
> proper computation of the regshift value.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

I've also verified that all H8 DTS files use length "8" in their "renesas,sci"
reg properties.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
