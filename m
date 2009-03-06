From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 06 Mar 2009 05:15:27 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7763
Message-Id: <20090306051527.GB16737@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Mar 06, 2009 at 02:06:27PM +0900, Nobuhiro Iwamatsu wrote:
> Update intc tables and platform data to use one linux irq
> per maskable interrupt source instead of keeping the one-to-one
> mapping between vectors and linux irqs.
> 
> This fixes potential irq masking issues for sh7763 hardware
> blocks such as RTC/SCIF/DMAC/GETHER/PCIC5/MMCIF/SIM/GPIO/USBF.
> 
> Signed-off-by: Nobuhiro Iwamatsu <iwamatsu.nobuhiro@renesas.com>

Applied, thanks.
