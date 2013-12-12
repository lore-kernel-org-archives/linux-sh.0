From: Simon Horman <horms@verge.net.au>
Date: Thu, 12 Dec 2013 12:02:38 +0000
Subject: Re: [PATCH 00/02] irqchip: renesas-irqc: Lazy disable and mask-on-suspend
Message-Id: <20131212120235.GC18308@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131204120537.29642.942.sendpatchset@w520>
In-Reply-To: <20131204120537.29642.942.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org, rob.herring@calxeda.com, grant.likely@secretlab.ca, tglx@linutronix.de

On Wed, Dec 04, 2013 at 09:05:37PM +0900, Magnus Damm wrote:
> irqchip: renesas-irqc: Lazy disable and mask-on-suspend
> 
> [PATCH 01/02] irqchip: renesas-irqc: Use lazy disable
> [PATCH 02/02] irqchip: renesas-irqc: Enable mask on suspend
> 
> Update the IRQC driver to use lazy disable and mask on suspend. This fixes
> the Suspend-to-RAM behavior to make sure wakeup sources are left enabled
> while suspending.

Thanks, I will queue these up.
