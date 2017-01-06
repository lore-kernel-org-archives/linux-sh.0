From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 06 Jan 2017 10:11:00 +0000
Subject: Re: [PATCH 01/19] serial: sh-sci: Set the SCSCR TE and RE bits in the driver
Message-Id: <CAMuHMdXi42wjmgBAdAkn2AuGKP_YSFz0ZLiotA-e6_5Bmn3D7w@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170103230639.19660-1-laurent.pinchart+renesas@ideasonboard.com> <20170103230639.19660-2-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <20170103230639.19660-2-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>

On Wed, Jan 4, 2017 at 12:06 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> The Transmit Enable and Receive Enable bits are set in the scscr field
> of all instances of the sh-sci platform data. Set them in the driver
> directly to prepare for their removal from platform data.
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
