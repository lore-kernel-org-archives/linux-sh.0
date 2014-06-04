From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Wed, 04 Jun 2014 15:54:26 +0000
Subject: Re: [PATCH v2 8/9] DMA: shdma: initial of common code
Message-Id: <538F4132.4030204@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1397511312-4845-1-git-send-email-ben.dooks@codethink.co.uk>	<1397511312-4845-9-git-send-email-ben.dooks@codethink.co.uk>	<4431489.B0PGdfS6ct@wuerfel>	<534D01EB.3080702@codethink.co.uk> <CAMuHMdU-FEnAjjcACaFt_-5i4EFDnj=uqrM_ew+nz7n9+ndbSQ@mail.gmail.com>
In-Reply-To: <CAMuHMdU-FEnAjjcACaFt_-5i4EFDnj=uqrM_ew+nz7n9+ndbSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@lists.codethink.co.uk, dmaengine@vger.kernel.org, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Linux-sh list <linux-sh@vger.kernel.org>, magnus.damm@opensource.se, Simon Horman <horms@verge.net.au>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>

On 21/05/14 21:14, Geert Uytterhoeven wrote:
> Hi Ben,
> 
> On Tue, Apr 15, 2014 at 11:54 AM, Ben Dooks <ben.dooks@codethink.co.uk> wrote:
>>>>   static struct dma_chan *shdma_of_xlate(struct of_phandle_args
>>>> *dma_spec,
>>>>                                        struct of_dma *ofdma)
>>>>   {
>>>> +       struct platform_device *pdev = ofdma->of_dma_data;
>>>>         u32 id = dma_spec->args[0];
>>>>         dma_cap_mask_t mask;
>>>>         struct dma_chan *chan;
>>>>
>>>> -       if (dma_spec->args_count != 1)
>>>> +       if (dma_spec->args_count = 2) {
>>>> +               struct shdma_of_state *state >>>> platform_get_drvdata(pdev);
>>>> +               struct shdma_of_client *client;
>>>> +
>>>> +               client = shdma_of_find_client(state, id);
>>>> +               if (!client) {
>>>> +                       client = devm_kzalloc(&pdev->dev,
>>>> sizeof(*client),
>>>> +                                             GFP_KERNEL);
>>>> +                       if (!client)
>>>> +                               return NULL;
>>>> +
>>>> +                       client->index >>>> atomic_inc_return(&of_slave_index);
>>>> +                       client->cfg.slave_id = id;
>>>> +                       client->cfg.mid_rid = id;
>>>> +                       client->cfg.chcr = dma_spec->args[1];
>>>
>>>
>>> Can you explain the purpose of setting the chcr in DT? For all I can
>>> tell, this should come from the device driver when that calls the
>>> dma_slave_config function, unlike the mid_rid value.
>>
>>
>> See previous note about transfer-widths and register-sizes not always
>> matching. I also do not have any idea about other SoCs in the series
>> if there are any differences between channel settings.
> 
> If you look for sh_dmae_slave_config in arch/arm arch/sh, you find the values
> for the existing board support.
> 
> The same device always seem to use the same value, i.e. MMC always uses
> 32-bit, SCIF uses 8-bit, SDHI uses 16-bit. So I think it could be hardcoded
> in the device driver (passed via enum dma_slave_buswidth {src,dst}_addr_width
> in dma_slave_config?), and you can drop the field in the bindings.
> 
> Notes:
>   - RSPI is special: on SH, it's 16-bit, while QSPI on R-Car uses 8-bit.
>   - SDHI uses 32-bit according to the R-Car docs, but the (working) code
>     uses 16-bit?

I will move to using the configuration passed when the slave is used
instead of the one in the slave table.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
