From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 06 Jan 2017 10:23:00 +0000
Subject: Re: [PATCH 10/19] sh: Don't set the sh-sci platform data scscr CKE0 bit
Message-Id: <CAMuHMdVmFyx8OM+cO8w0+3RYvRj9_+2yZRpj8eaXsPGRF-n-DQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-11-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20170103230639.19660-11-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The bit is only set by platforms that also set the CKE1 but, in which
> case its value is ignored by the device. Don't set it, this simplifies
> platform data and only leaves the CKE1 bit to be handled.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
