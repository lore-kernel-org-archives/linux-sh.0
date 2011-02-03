From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Date: Thu, 03 Feb 2011 01:29:49 +0000
Subject: Re: build error in ehci-hcd when disable PCI bus
Message-Id: <4D4A050D.40906@renesas.com>
List-Id: <linux-sh.vger.kernel.org>
References: <4D48D301.9080705@renesas.com>
In-Reply-To: <4D48D301.9080705@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Paul-san,

2011/02/03 8:36, Paul Mundt wrote:
> When the PCI bus is disabled we don't really have any concept of PIO, so
> PIO support and the associated accessors are explicitly disabled.
> 
> The quirk this refers to looks like it may depend on PCI, and if not, it
> certainly has a platform dependency that can be used to encapsulate it.
> 
> The proper fix here is to fix ehci-sched.c, not re-introduce broken PIO
> crap that wraps in to MMIO.

Thank you very much for your reply.
I will report it to linux-usb ml.

Best regards,
Yoshihiro Shimoda
