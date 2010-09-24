From: Arnd Hannemann <arnd@arndnet.de>
Date: Fri, 24 Sep 2010 08:13:28 +0000
Subject: Re: [PATCH 2/2] tmio_mmc: fix CMD irq handling
Message-Id: <4C9C5DA8.5080904@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
References: <4C9B5BF4.3070109@arndnet.de> <AANLkTi=B=pcxVTMSxk2Orftp8zH7o8jebL1hbQ52dyzH@mail.gmail.com>
In-Reply-To: <AANLkTi=B=pcxVTMSxk2Orftp8zH7o8jebL1hbQ52dyzH@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Molton <ian@mnementh.co.uk>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, linux-sh@vger.kernel.org

Added MLs into CC

Am 23.09.2010 21:28, schrieb Ian Molton:
> This looks good - what testing has it had ?

Tested with the SDHI hardware block in sh7372 (on AP4EVB).
Both with PIO and DMA. Tested with MMC and SD cards.

Regards
Arnd
