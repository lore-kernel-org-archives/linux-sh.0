From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 15 Dec 2014 13:07:52 +0000
Subject: Re: [PATCH 10/10] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Message-Id: <CAMuHMdWtkk=Q=Mfcyz03LBzXMuBOr8BZGNyCsQb9bwDty-4OiQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1418602429-11276-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1418602429-11276-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1418602429-11276-11-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: iommu@lists.linux-foundation.org, Linux-sh list <linux-sh@vger.kernel.org>

On Mon, Dec 15, 2014 at 1:13 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> Add the seven IPMMU instances found in the r8a7791 to DT with a disabled
> status.
>
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The addresses and interrupt numbers look OK to me.
However, my comment about the "0x800" offset is still valid.
Shouldn't we have two register blocks, and let the driver use only the
second one?

If you ignore, feel free to add my
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
