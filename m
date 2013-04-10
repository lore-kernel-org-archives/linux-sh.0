From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 10 Apr 2013 15:01:14 +0000
Subject: Re: [PATCH v3 2/9] ehci-platform: add pre_setup() method to platform data
Message-Id: <Pine.LNX.4.44L0.1304101100570.1891-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201304100230.24883.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201304100230.24883.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, 10 Apr 2013, Sergei Shtylyov wrote:

> Sometimes there is a need  to initialize some non-standard registers mapped to
> the EHCI region before accessing the standard EHCI registers.  Add pre_setup()
> method with 'struct usb_hcd *' parameter to be called just before ehci_setup()
> to the 'ehci-platform'  driver's platform data for this purpose...
> 
> While at it, add the missing incomplete declaration of 'struct platform_device'
> to <linux/usb/ehci_pdriver.h>...
> 
> The patch has been tested on the Marzen and BOCK-W boards.
> 
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

