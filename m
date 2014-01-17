From: Simon Horman <horms@verge.net.au>
Date: Fri, 17 Jan 2014 05:26:46 +0000
Subject: Re: [PATCH 2/2] ARM: dts: lager: Enable SATA1 in r8a7790-lager.dts
Message-Id: <20140117052646.GB9302@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1389719131-24376-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1389719131-24376-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 14, 2014 at 09:05:31PM +0400, Valentine Barshak wrote:
> This enables SATA1 in Lager device tree.
> SATA0 is not available on Lager since its
> pinmux is fixed to USB3.0.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Thanks. I have queued this up with Magnus's ack and dts: in the
subject changed to shmobile:
