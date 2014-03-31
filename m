From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Mon, 31 Mar 2014 13:59:06 +0000
Subject: Re: [PATCH 4/5] ARM: shmobile: r8a7791: Add IPMMU DT nodes
Message-Id: <2517875.vv2t3ch4DC@avalon>
List-Id: <linux-sh.vger.kernel.org>
References: <1396049781-12941-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<1396049781-12941-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
	<CAMuHMdV5kV_cz3b1gW7qW_z22JtWd9BpoXN2=_XjBqJfcG-yWQ@mail.gmail.com>
In-Reply-To: <CAMuHMdV5kV_cz3b1gW7qW_z22JtWd9BpoXN2=_XjBqJfcG-yWQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Geert,

On Monday 31 March 2014 10:52:28 Geert Uytterhoeven wrote:
> On Sat, Mar 29, 2014 at 12:36 AM, Laurent Pinchart wrote:
> > +       ipmmu_sy0: mmu@e6280800 {
> > +               compatible = "renesas,ipmmu-vmsa";
> > +               reg = <0 0xe6280800 0 0x800>;
> 
> Shouldn't this be "reg = <0 0xe6280000 0 0x1000>", i.e. expose both
> banks?
> 
> Is there any specific reason you're using the second bank of registers?
> These may read as zero, depending on the SoC mode.

That's a very good question, and I have no clear answer. According to the 
datasheet the second bank of registers is an alias for the non-secure IPMMU 
registers. It looks like we're running in secure mode (that's what I assume 
the "CPU: All CPU(s) started in SVC mode." kernel log message means), and the 
secure IPMMU didn't seem to be functional when I've tested it.

This requires more investigation, but I'm not familiar with secure mode, and 
the IPMMU documentation is really sparse in that area.

> > +               interrupts = <0 223 IRQ_TYPE_LEVEL_HIGH>;
> > +               status = "disabled";
> > +       };
> 
> Same comment for the other nodes.

-- 
Regards,

Laurent Pinchart

