From: Arnd Hannemann <arnd@arndnet.de>
Date: Wed, 05 Jan 2011 22:31:00 +0000
Subject: Re: [PATCH 1/2 v2] mmc: tmio: handle missing HW interrupts
Message-Id: <4D24F124.9000303@arndnet.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1293628874-8140-1-git-send-email-arnd@arndnet.de> <1293628874-8140-2-git-send-email-arnd@arndnet.de> <20110105212223.GJ9198@void.printf.net>
In-Reply-To: <20110105212223.GJ9198@void.printf.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, linux-sh@vger.kernel.org

Hi Chris,

Am 05.01.2011 22:22, schrieb Chris Ball:
> Hi Arnd,
> 
> On Wed, Dec 29, 2010 at 02:21:13PM +0100, Arnd Hannemann wrote:
>> This patch addresses this problem by introducing timeouts for outstanding
>> interrupts. If a hardware interrupt is missing, a soft reset will be performed
>> to bring the hardware back to a working state.
>> Tested with the SDHI hardware block in sh7372 / AP4EVB.
>>
>> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
> 
> This breaks compilation without CONFIG_TMIO_MMC_DMA=y, because it
> attempts to compile tmio_mmc_reset_work() unconditionally even though
> delayed_reset_work is only a member of tmio_mmc_host if TMIO_MMC_DMA=y:
> 
> drivers/mmc/host/tmio_mmc.c: In function ‘tmio_mmc_reset_work’:
> drivers/mmc/host/tmio_mmc.c:357:31: error: ‘struct tmio_mmc_host’ has no member named ‘delayed_reset_work’

Hmm, I could not reproduce this.
delayed_reset_work should not be in the #ifdef TMIO_MMC_DMA #endif scope.
And it isn't according to the patch.

I tried with mmc-next last commit "549bad416ef62f09711cb22e77adff029e27ce07".
The patch would apply with some fuzz, but compilation without CONFIG_TMIO_MMC_DMA=y works.

With what tree and .config did you try?

Maybe I confused you with my email mentioning the older patches, did you try the (rebased) v2:
https://patchwork.kernel.org/patch/439421/
https://patchwork.kernel.org/patch/439431/


Thanks
Arnd
