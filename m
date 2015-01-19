From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 19 Jan 2015 10:30:48 +0000
Subject: Re: [GIT PULL FOR v3.20] R-Car DMA engine driver
Message-Id: <CAMuHMdWPj3Oz2UU96JTszk7KP39tTYrv+0wWDd5j6tbgd+=mFg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <25808042.z3ylOLx5GF@avalon>
In-Reply-To: <25808042.z3ylOLx5GF@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Vinod,

On Wed, Dec 24, 2014 at 6:35 AM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Dec 23, 2014 at 11:16:52AM +0200, Laurent Pinchart wrote:
>> The following changes since commit fbde286783f7c1e55e6c33575fa1a56f8ea77c90:
>>
>>   dmaengine: nbpfaxi: update the driver comments (2014-12-22 20:28:04 +0530)
>>
>> are available in the git repository at:
>>
>>   git://linuxtv.org/pinchartl/fbdev.git dma/next
>>
>> for you to fetch changes up to ee4b876bbee2c5c53518110849f23c117eec099c:
>>
>>   dmaengine: rcar-dmac: Handle hardware descriptor allocation failure
>> (2014-12-23 11:13:03 +0200)
> Merged now, Thanks

The following commits seems to have been lost on today's slave-dma/next?

+ 534a729866f9edc9264340c5b96cb94878ffda00 dmaengine: Add 16 bytes, 32
bytes and 64 bytes bus widths
+ c4d7635280f24cfa8c3ef34c122600d148749030 dmaengine: rcar-dmac:
Remove duplicate sentence from DT bindings
+ 87244fe5abdf1dbaf4e438d80cf641bf3c01d5cf dmaengine: rcar-dmac: Add
Renesas R-Car Gen2 DMA Controller (DMAC) driver
+ ccadee9b1e90dc6d3d97a20ac96cb1a82e0d5a1d dmaengine: rcar-dmac:
Implement support for hardware descriptor lists
+ 1ed1315f9b63c45f57f607e7ad2dac066b101f16 dmaengine: rcar-dmac: Cache
hardware descriptors memory
+ ee4b876bbee2c5c53518110849f23c117eec099c dmaengine: rcar-dmac:
Handle hardware descriptor allocation failure

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
