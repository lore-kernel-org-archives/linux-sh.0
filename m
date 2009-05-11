From: Manuel Lauss <mano@roarinelk.homelinux.net>
Date: Mon, 11 May 2009 09:44:48 +0000
Subject: Re: [PATCH] sh: multiple vectors per irq - sh7760
Message-Id: <20090511094448.GB25527@roarinelk.homelinux.net>
List-Id: <linux-sh.vger.kernel.org>
References: <49B0AF53.9090007@renesas.com>
In-Reply-To: <49B0AF53.9090007@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Mon, May 11, 2009 at 06:01:08PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> Update intc tables and platform data to use one linux irq
> per maskable interrupt source instead of keeping the one-to-one
> mapping between vectors and linux irqs.
> 
> This fixes potential irq masking issues for sh7760 hardware
> blocks such as DMAC/TMU2/REF.

With this patch applied, my 7760 system no longer boots.  I'll
try to figure out why as soon as I get my JTAG probe back.

Manuel Lauss
