From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 31 Mar 2014 08:45:00 +0000
Subject: Re: [PATCH 3/5] iommu/ipmmu-vmsa: Add device tree support
Message-Id: <CAMuHMdU7esZ35xe+iTRNbeXmD7bSHXEakTOrTfXEs8h5yQLFfA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1396049781-12941-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1396049781-12941-4-git-send-email-laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Laurent,

On Sat, Mar 29, 2014 at 12:36 AM, Laurent Pinchart
<laurent.pinchart+renesas@ideasonboard.com> wrote:
> @@ -828,16 +829,31 @@ static phys_addr_t ipmmu_iova_to_phys(struct iommu_domain *io_domain,
>
>  static int ipmmu_find_utlb(struct ipmmu_vmsa_device *mmu, struct device *dev)
>  {

> +       ret = of_parse_phandle_with_fixed_args(dev->of_node, "iommus",
> +                                              1, 0, &args);

drivers/of/base.c:of_parse_phandle_with_fixed_args():

"Caller is responsible to call of_node_put() on the returned out_args->node
 pointer."

> +       if (ret < 0)
> +               return -1;
> +
> +       if (args.np != mmu->dev->of_node)
> +               return -1;
> +
> +       return args.args[0];
>  }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
