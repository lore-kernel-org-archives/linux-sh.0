From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 28 Nov 2008 14:02:09 +0000
Subject: Re: [PATCH] sh: pci-sh7780: fix pci memory address mask
Message-Id: <20081128140209.GA18785@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <492E6F0F.8040400@renesas.com>
In-Reply-To: <492E6F0F.8040400@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Nov 27, 2008 at 06:57:35PM +0900, Yoshihiro Shimoda wrote:
> Fix the problem that cannot work a PCI device when system memory size is
> 256Mbyte in 29bit address mode.
> 
> Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>

I have applied this for now, but this really should be reflected in the
pci address map instead of being hardcoded to the memory size. If the
board gets the address map wrong, it is not the fault of the SH7780 PCIC
management code. That said, there are some bugfixes in here, so I have
applied it.
