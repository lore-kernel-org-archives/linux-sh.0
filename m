From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Sep 2014 14:02:14 +0000
Subject: Re: [PATCH 1/6] V4L2: Add Renesas R-Car JPEG codec driver.
Message-Id: <CAMuHMdWnMz3P8tk_f_EQoZjgYS7SzH_2jYv_32aPnfM_hQgr1A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1408452653-14067-1-git-send-email-mikhail.ulyanov@cogentembedded.com>
	<1408452653-14067-2-git-send-email-mikhail.ulyanov@cogentembedded.com>
In-Reply-To: <1408452653-14067-2-git-send-email-mikhail.ulyanov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikhail Ulyanov <mikhail.ulyanov@cogentembedded.com>
Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-sh list <linux-sh@vger.kernel.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On Tue, Aug 19, 2014 at 2:50 PM, Mikhail Ulyanov
<mikhail.ulyanov@cogentembedded.com> wrote:
> +static void put_short_be(unsigned long *p, u16 v)
> +{
> +       u16 *addr = (u16 *)*p;
> +
> +       *addr = cpu_to_be16(v);
> +       *p += 2;
> +}
> +
> +static void put_word_be(unsigned long *p, u32 v)
> +{
> +       u32 *addr = (u32 *)*p;
> +
> +       *addr = cpu_to_be32(v);
> +       *p += 4;
> +}

Is the address in *p guaranteed to be aligned to 2 resp. 4  bytes?

If not, you can use put_unaligned*().

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
