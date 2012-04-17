From: Paul Mundt <lethal@linux-sh.org>
Date: Tue, 17 Apr 2012 07:38:22 +0000
Subject: Re: [PATCH 1/4] sh: sh4a: Change the specification method of IRQ to SCIx_IRQ_MUXED
Message-Id: <20120417073822.GA25751@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1334286843-3297-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
In-Reply-To: <1334286843-3297-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Apr 13, 2012 at 12:14:00PM +0900, Nobuhiro Iwamatsu wrote:
> Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for this.
> And change use to evt2irq(), without specifying the value of IRQ directly.
> This is correction to the SH4A series.

On Fri, Apr 13, 2012 at 12:14:01PM +0900, Nobuhiro Iwamatsu wrote:
> Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for this.
> And change use to evt2irq(), without specifying the value of IRQ directly.
> This is correction to the SH4 series.

On Fri, Apr 13, 2012 at 12:14:02PM +0900, Nobuhiro Iwamatsu wrote:
> Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for this.
> And change use to evt2irq(), without specifying the value of IRQ directly.
> This is correction to the SH3 series.

On Fri, Apr 13, 2012 at 12:14:03PM +0900, Nobuhiro Iwamatsu wrote:
> Some SCIF devices specify the same IRQ. We can use SCIx_IRQ_MUXED for this.
> This is correction to the SH2/SH2A series.

All applied, thanks.
