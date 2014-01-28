From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Tue, 28 Jan 2014 09:50:26 +0000
Subject: Re: [PATCH 3/3] PCI: rcar: fix bridge logic abort
Message-Id: <52E77D62.9010704@codethink.co.uk>
List-Id: <linux-sh.vger.kernel.org>
References: <1390902468-7753-1-git-send-email-ben.dooks@codethink.co.uk> <1390902468-7753-4-git-send-email-ben.dooks@codethink.co.uk>
In-Reply-To: <1390902468-7753-4-git-send-email-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-kernel@lists.codethink.co.uk, Valentine Barshak <valentine.barshak@cogentembedded.com>, Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-sh@vger.kernel.org

On 28/01/14 09:47, Ben Dooks wrote:
> The bridge logic at slot 0 only supports reads up to 0x40 and the
> rest of the PCI configuration space for this slot is marked as
> reserved in the manual.
>
> Trying a read from offset 0x100 is producing an error from the
> bridge. With error interrupts enabled, the following is printed:
>
> pci-rcar-gen2 ee0d0000.pci: error irq: status 00000014
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

apologies, did not remove the debug code from this.

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
