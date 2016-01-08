From: Bjorn Helgaas <helgaas@kernel.org>
Date: Fri, 08 Jan 2016 20:37:37 +0000
Subject: Re: [PATCH 0/2] drivers/pci: use builtin_platform_driver in renesas
Message-Id: <20160108203737.GJ5354@localhost>
List-Id: <linux-sh.vger.kernel.org>
References: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1450745949-23882-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Phil Edworthy <phil.edworthy@renesas.com>, Simon Horman <horms@verge.net.au>, Valentine Barshak <valentine.barshak@cogentembedded.com>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org

On Mon, Dec 21, 2015 at 07:59:07PM -0500, Paul Gortmaker wrote:
> These two commits are extracted from what was a larger series[1] of
> demodularization in PCI host code that was bool Kconfig.
> 
> With the other commits, there was some mixed opinions whether we
> should make it explicitly non-modular or move towards making it
> functionally working as a tristate in order to reduce the size of
> built-in code for multi-platform kernels.
> 
> However with the renesas changes, there was no ".remove" and no
> "module_exit" code stripped out ; it is just a straight 1:1 mapping
> of the modular macros onto what they become in the non-modular case
> anyway -- meaning the runtime remains unchanged.

Is there any reason these drivers can't be made modular?  I'd rather
do that, if we can.

Bjorn
