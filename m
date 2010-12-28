From: Magnus Damm <magnus.damm@gmail.com>
Date: Tue, 28 Dec 2010 10:01:40 +0000
Subject: Re: [PATCH] [RFC] sh: sh7723 / ap325rxa enable SDIO IRQs
Message-Id: <AANLkTimxipcDMZ3sqNZB0eV0QyC0iL-3+oj213Hw-b6+@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTi=oaLjQmz+G8_kK70JCxVfGfzv0VhRt3s9OsVXw@mail.gmail.com>
	<1293101120-31162-1-git-send-email-arnd@arndnet.de>
In-Reply-To: <1293101120-31162-1-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Hannemann <arnd@arndnet.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

Hi Arnd,

On Thu, Dec 23, 2010 at 7:45 PM, Arnd Hannemann <arnd@arndnet.de> wrote:
> This patch enables the interrupt generation for SDIO IRQs
> of the sdhi controllers of the SoC. To make sure SDIO IRQs
> are used announce the MMC_CAP_SDIO_IRQ capability
> on ap325rxa. Untested, therefore RFC.
>
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>

Looking good, thanks a lot!

Acked-by: Magnus Damm <damm@opensource.se>
