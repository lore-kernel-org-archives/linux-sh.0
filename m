From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Jan 2015 13:41:24 +0000
Subject: Re: [GIT PULL FOR v3.20] R-Car DMA engine driver
Message-Id: <CAMuHMdUxLekE0EN2XVLLf0JNCNbrXsdkXB97WQPWVqT2aE+jKA@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <25808042.z3ylOLx5GF@avalon>
In-Reply-To: <25808042.z3ylOLx5GF@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

On Mon, Jan 19, 2015 at 2:32 PM, Vinod Koul <vinod.koul@intel.com> wrote:
>> The following commits seems to have been lost on today's slave-dma/next?
>>
>> + 534a729866f9edc9264340c5b96cb94878ffda00 dmaengine: Add 16 bytes, 32
>> bytes and 64 bytes bus widths
>> + c4d7635280f24cfa8c3ef34c122600d148749030 dmaengine: rcar-dmac:
>> Remove duplicate sentence from DT bindings
>> + 87244fe5abdf1dbaf4e438d80cf641bf3c01d5cf dmaengine: rcar-dmac: Add
>> Renesas R-Car Gen2 DMA Controller (DMAC) driver
>> + ccadee9b1e90dc6d3d97a20ac96cb1a82e0d5a1d dmaengine: rcar-dmac:
>> Implement support for hardware descriptor lists
>> + 1ed1315f9b63c45f57f607e7ad2dac066b101f16 dmaengine: rcar-dmac: Cache
>> hardware descriptors memory
>> + ee4b876bbee2c5c53518110849f23c117eec099c dmaengine: rcar-dmac:
>> Handle hardware descriptor allocation failure
> My bad, I rebased -next of latest greates rc and missed mergic topic/rcar.
> Fixed and pushed now

Thanks, confirmed fixed.

> Thanks for reporting

You're welcome.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
