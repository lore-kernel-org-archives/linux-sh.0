From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 01 Jun 2014 08:50:20 +0000
Subject: Re: [PATCH 11/18] v4l: vsp1: wpf: Simplify cast to pipeline structure
Message-Id: <CAMuHMdUCT1rSQWn+B9zQ3a-BPJsBePK9K5NszR==AriaRm8BjQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1401593977-30660-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1401593977-30660-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1401593977-30660-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Linux Media Mailing List <linux-media@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Jun 1, 2014 at 5:39 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> USe the subdev pointer directly to_vsp1_pipeline() macro instead of

Use

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
