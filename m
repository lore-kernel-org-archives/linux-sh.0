From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Sep 2017 07:02:59 +0000
Subject: Re: [PATCH 1/2] [RESEND] of: provide of_n_{addr,size}_cells wrappers for !CONFIG_OF
Message-Id: <CAMuHMdWQu8HVp2jc2qcs=vUuiBNdOMm96qSgTpJSNqTtm2gO5A@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <20170911200805.3363318-1-arnd@arndb.de> <CAL_JsqLGhQQOt_Ads2+JpVW=gRDOi141iEh-aWLFmTkg9p62XQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLGhQQOt_Ads2+JpVW=gRDOi141iEh-aWLFmTkg9p62XQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Frank Rowand <frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Magnus Damm <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>, Ben Dooks <ben.dooks-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sakari Ailus <sakari.ailus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

Hi Rob,

On Mon, Sep 18, 2017 at 11:28 PM, Rob Herring <robh+dt@kernel.org> wrote:
> On Mon, Sep 11, 2017 at 3:07 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> The pci-rcar driver is enabled for compile tests, and this has
>> shown that the driver cannot build without CONFIG_OF,
>> following the inclusion of f8f2fe7355fb "PCI: rcar: Use new OF
>> interrupt mapping when possible":
>>
>> drivers/pci/host/pcie-rcar.c: In function 'pci_dma_range_parser_init':
>> drivers/pci/host/pcie-rcar.c:1039:2: error: implicit declaration of function 'of_n_addr_cells' [-Werror=implicit-function-declaration]
>>   parser->pna = of_n_addr_cells(node);
>>   ^
>> As pointed out by Ben Dooks and Geert Uytterhoeven, this is actually
>> supposed to build fine, which we can achieve if we make the
>> declaration of of_irq_parse_and_map_pci conditional on CONFIG_OF
>> and provide an empty inline function otherwise, as we do for
>> a lot of other of interfaces.
>>
>> This lets us build the rcar_pci driver again without CONFIG_OF
>> for build testing. All platforms using this driver select OF,
>> so this doesn't change anything for the users.
>
> Sorry, I keep missing this. It's a flaw in my mail filtering...
>
> There's a patch series[1] to factor out pci_dma_range_parser_init of
> the driver which should also fix this. I'd prefer not to take this
> because ideally all address parsing should be within the DT core code.
>
> Rob
>
> [1] https://patchwork.kernel.org/patch/9927541/

Yes, that looks like a better solution.

(For those who didn't see the rest of the series: of_pci_dma_range_parser_init()
 in provided in of/address.c, and does have a dummy)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
