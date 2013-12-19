From: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Date: Thu, 19 Dec 2013 05:17:05 +0000
Subject: Re: [PATCH] arm: shmobile: r8a7790: Fix I2C controller names
Message-Id: <87vbylv2r5.wl%kuninori.morimoto.gx@gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1387379302-20223-1-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1387379302-20223-1-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org


Hi

> The R8A7790 is an R-Car Gen2 SoC. The clock division factor
> (CDF) width is 3 bits on Gen2 as opposed to 2 bits on Gen1.
> Fix the device names for R8A7790 SoC to make the R-Car I2C
> driver configure the hardware properly.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> ---

Grr... this is correct
sorry my fault.

Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Simon, this patch is based on below patch

043a3f113ce41e3e6fdbb49551df75e82e8c4ae7
(i2c: rcar: fixup rcar type naming)


Best regards
---
Kuninori Morimoto
