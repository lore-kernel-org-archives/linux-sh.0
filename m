From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 24 Dec 2010 11:03:31 +0000
Subject: Re: [PATCH 2/6 v2] mfd: sh_mobile_sdhi: activate SDIO IRQ for
Message-Id: <20101224110330.GD27832@sortiz-mobl>
List-Id: <linux-sh.vger.kernel.org>
References: <AANLkTi=HuQKRuTLLKt3Y4r9Boo71dq4qGtHLNy2=RD-V@mail.gmail.com>
 <1292860431-16195-3-git-send-email-arnd@arndnet.de>
In-Reply-To: <1292860431-16195-3-git-send-email-arnd@arndnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Hannemann <arnd@arndnet.de>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, g.liakhovetski@gmx.de, Ian Molton <ian@mnementh.co.uk>

Hi Arnd,

On Mon, Dec 20, 2010 at 03:53:47PM +0000, Arnd Hannemann wrote:
> The SDHI Controller on SH-Mobile SoCs supports SDIO IRQ signalling.
> This patch advertises this fact to the tmio_mmc driver.
> 
> Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
Since this one depends on the first patch on the series, I won't be able to
carry it. Please add my:

Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
