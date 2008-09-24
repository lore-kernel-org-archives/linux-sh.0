From: "Nobuhiro Iwamatsu" <iwamatsu@nigauri.org>
Date: Wed, 24 Sep 2008 04:29:56 +0000
Subject: about dma-sh driver
Message-Id: <29ab51dc0809232129j2a54662bg1e5ac50161f6cc94@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi, all.

I'm making  driver who used dma-sh.
I use a dma-sh driver and want to use another interrupt handler.
I want to use request, get_residue and other dma_ops functions
and  change only dma_tei function.

Dma-sh has a function for IRQ interrupts in dma-sh driver.
For an IRQ interrupt, we cannot register another interrupt handler.

Is this right?

I think about three suggestion.

1. Add interrupt handler override function to dma-sh and dma-api.
    I wrote quick hack this suggestion.

2. Create SuperH driver of dma engine and shift dma engine.
    I hear that dma-sh shifts to dma-engine.
    But I don't know schedule about dma engine.

3. Do both 1 and 2 in parallelism.

If there is other good suggestion, please teach it.

Best regards,
 Nobuhiro
-- 
Nobuhiro Iwamatsu
