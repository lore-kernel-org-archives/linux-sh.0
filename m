From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Mar 2014 08:52:28 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Message-Id: <CAMuHMdV5kV_cz3b1gW7qW_z22JtWd9BpoXN2=_XjBqJfcG-yWQ@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1396049781-12941-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396049781-12941-5-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Laurent,

On Sat, Mar 29, 2014 at 12:36 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> +       ipmmu_sy0: mmu@e6280800 {
> +               compatible = "renesas,ipmmu-vmsa";
> +               reg = <0 0xe6280800 0 0x800>;

Shouldn't this be "reg = <0 0xe6280000 0 0x1000>", i.e. expose both
banks?

Is there any specific reason you're using the second bank of registers?
These may read as zero, depending on the SoC mode.

> +               interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>;
> +               status = "disabled";
> +       };

Same comment for the other nodes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
