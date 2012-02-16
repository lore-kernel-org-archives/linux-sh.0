From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Thu, 16 Feb 2012 08:45:36 +0000
Subject: Re: [PATCH v2 00/13] Make mach/irqs.h optional
Message-Id: <20120216084536.GH13673@n2100.arm.linux.org.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
In-Reply-To: <1327091591-27125-1-git-send-email-robherring2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 20, 2012 at 02:32:58PM -0600, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series removes the include of mach/irqs.h from asm/irq.h when
> SPARSE_IRQ is selected. Platforms which select SPARSE_IRQ have been
> updated.

Rob,

Last night, I merged devel-stable into the stuff which gets built, and it
seems your IRQ changes are breaking PXA:

Before merge:
http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx9

After merge:
http://www.arm.linux.org.uk/developer/build/result.php?type=build&idx7
