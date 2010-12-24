From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 24 Dec 2010 11:11:00 +0000
Subject: Re: [PATCH 2/3 v2] mmc: tmio: implement a bounce buffer for
Message-Id: <20101224111100.GF27832@sortiz-mobl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
 <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
 <Pine.LNX.4.64.1012221156580.14483@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1012221156580.14483@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Magnus Damm <damm@opensource.se>

On Wed, Dec 22, 2010 at 12:02:15PM +0100, Guennadi Liakhovetski wrote:
> For example, with SDIO WLAN cards, some transfers happen with buffers at odd
> addresses, whereas the SH-Mobile DMA engine requires even addresses for SDHI.
> This patch extends the tmio driver with a bounce buffer, that is used for
> single entry scatter-gather lists both for sending and receiving. If we ever
> encounter unaligned transfers with multi-element sg lists, this patch will have
> to be extended. For now it just falls back to PIO in this and other unsupported
> cases.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

for the MFD part.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
