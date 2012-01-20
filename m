From: Nicolas Pitre <nico@fluxnic.net>
Date: Fri, 20 Jan 2012 21:11:03 +0000
Subject: Re: [PATCH v2 11/13] ARM: only include mach/irqs.h for !SPARSE_IRQ
Message-Id: <alpine.LFD.2.02.1201201608400.19587@xanadu.home>
List-Id: <linux-sh.vger.kernel.org>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
 <1327091591-27125-12-git-send-email-robherring2@gmail.com>
In-Reply-To: <1327091591-27125-12-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, 20 Jan 2012, Rob Herring wrote:

> From: Rob Herring <rob.herring@calxeda.com>
> 
> Make mach/irqs.h optional for SPARSE_IRQ. With this change irqs.h can be
> removed by converting platforms over to sparse irq.
> 
> This intentionally breaks platforms that enable SPARSE_IRQ.

I don't get what you mean here.  The above seems contradictory.


Nicolas
