From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 26 Nov 2010 12:04:44 +0000
Subject: Re: [PATCH 2/3] mmc: tmio: implement a bounce buffer for unaligned
Message-Id: <20101126120443.GI5520@sortiz-mobl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange>
 <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1011231723090.25676@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>

Hi Guennadi,

On Tue, Nov 23, 2010 at 05:24:15PM +0100, Guennadi Liakhovetski wrote:
> For example, with SDIO WLAN cards, some transfers happen with buffers at odd
> addresses, whereas the SH-Mobile DMA engine requires even addresses for SDHI.
> This patch extends the tmio driver with a bounce buffer, that is used for
> single entry scatter-gather lists both for sending and receiving. If we ever
> encounter unaligned transfers with multi-element sg lists, this patch will have
> to be extended. For now it just falls back to PIO in this and other unsupported
> cases.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
I'm not sure about who is going to carry those patches, probably not me
though.
So, for the MFD part:
Acked-by: Samuel Ortiz <sameo@linux.intel.com>

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
