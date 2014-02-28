From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 28 Feb 2014 17:48:22 +0000
Subject: Re: [PATCH 1/2] iommu: Add driver for Renesas VMSA-compatible IPMMU
Message-Id: <CAMuHMdUcrANSqUmS6QJkcms_bU=aYLBXjBUL5ep=k0eQxYzw6g@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1393601099-4413-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1393601099-4413-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1393601099-4413-2-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, Feb 28, 2014 at 4:24 PM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> +/*
> + * VMSA that states in section B3.6.3 "Control of Secure or Non-secure memory

VMSA states

> + * access, Long-descriptor format" that the NStable bit being set in a table
> + * descriptor will result in the NStable and NS bits of all child entries being
> + * ignored and considered as being set. The IPMMU seems not to comply with this,
> + * as it generates a secure access page fault if any of the NStable and NS bits
> + * isn't set when running in non-secure mode.
> + */

> +       /*
> +        * TTBCR
> +        * We use long descriptor, with inner-shareable WBWA tables and allocate

descriptors

> +        * the whole 32-bit VA space to TTBR0.
> +        */

> +       /*
> +        * Clear the error status flags. Unlike traditionnal interrupt flag

traditional

Sorry, only comments on the comments ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
