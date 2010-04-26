From: Paul Mundt <lethal@linux-sh.org>
Date: Mon, 26 Apr 2010 07:09:19 +0000
Subject: Re: [PATCH] SH: fix error paths in DMA driver
Message-Id: <20100426070918.GF11770@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1004191035480.4080@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1004191035480.4080@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, Apr 19, 2010 at 10:39:39AM +0200, Guennadi Liakhovetski wrote:
> If channel allocation is failing, mark the channel unused and give PM a chance
> to power down the hardware.

On Wed, Apr 21, 2010 at 05:14:19PM +0200, Guennadi Liakhovetski wrote:
> CHCR_TS_HIGH_SHIFT is defined as a shift of TS high bits in CHCR register,
> relative to low bits. The TS_INDEX2VAL() macro has to take this into account.

Both applied for 2.6.34, thanks.
