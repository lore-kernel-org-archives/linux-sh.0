From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Mar 2014 08:39:48 +0000
Subject: Re: [PATCH 2/5] iommu/ipmmu-vmsa: Add device tree bindings documentation
Message-Id: <CAMuHMdUF6MmH_eK=SbG-q6Kai_q+5ufm-Vsd8z-bYKGj7Z-Spw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1396049781-12941-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396049781-12941-3-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Laurent,

On Sat, Mar 29, 2014 at 12:36 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> +Required Properties:
> +
> +  - compatible: Must contain "renesas,ipmmu-vmsa".
> +  - reg: Base address and size of the IPMMU registers.
> +  - interrupts: Specifier for the MMU fault interrupt.

Does it make sense to have a property for the number of micro-TLBs,
or is this handled transparently?

E.g. ipmmu_mx has 24 micro-TLBs, but ipmmu_mp has 30.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
