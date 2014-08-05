From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 05 Aug 2014 11:48:47 +0000
Subject: Re: [PATCH v2 5/8] dmaengine: rcar-dmac: Add Renesas R-Car Gen2 DMA Controller (DMAC) driver
Message-Id: <CAMuHMdXh0c5LXRYZWfFxd6B7BGNQW4VJGSoSdcbavCE+uVYQXw@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1405727425-6237-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1405727425-6237-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Aug 4, 2014 at 5:02 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>> > +                                     GFP_KERNEL);
>> > +       if (!rchan->irqname)
>> > +               return -ENOMEM;
>> > +       sprintf(rchan->irqname, "%s:%u", dev_name(dmac->dev), index);
>>
>> We really need devm_kasprintf() (coding it up)...
>>
>> > +static int rcar_dmac_probe(struct platform_device *pdev)
>> > +{
>> >
>> > +       dmac->irqname = devm_kmalloc(dmac->dev,
>> > strlen(dev_name(dmac->dev)) + 7, +
>> > GFP_KERNEL);
>> > +       if (!dmac->irqname)
>> > +               return -ENOMEM;
>> > +       sprintf(dmac->irqname, "%s:error", dev_name(&pdev->dev));
>>
>> We really need devm_kasprintf()...
>
> I'll update the driver to use it once it will be upstream :-)

Apparently someone already implemented it during my holidays, and it's
now upstream, causing rebase conflicts in my local tree...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
