From: Simon Horman <horms@verge.net.au>
Date: Mon, 18 Jan 2016 01:48:36 +0000
Subject: Re: [PATCH 3/3] ARM: shmobile: defconfig: Do not enable CONFIG_CPU_BPREDICT_DISABLE
Message-Id: <20160118014836.GF1905@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1452537674-20006-1-git-send-email-geert+renesas@glider.be>
 <1452537674-20006-4-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1452537674-20006-4-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 11, 2016 at 07:41:14PM +0100, Geert Uytterhoeven wrote:
> Do not disable branch prediction, as this has a big performance impact.
> 
> After re-enabling branch prediction, __loop_delay() runs 16 (Cortex A15)
> or 11 (Cortex A9) times faster than before.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> This used to be enabled in:
> 
>   - ag5evm_defconfig (sh73a0)
>   - ape6evm_defconfig (r8a73a4)
>   - armadillo800eva_defconfig (r8a7740)
>   - koelsch_defconfig (r8a7791)
>   - kota2_defconfig (sh73a0)
> 
> Was there ever a good reason for that?

If that was a concious decision then I believe it was made before my time.
I'm going ahead and queuing up this change for v4.6.
