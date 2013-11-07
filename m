From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 07 Nov 2013 15:18:35 +0000
Subject: Re: [RFC V2 PATCH 2/2] usb: hcd: Initialize USB phy if needed
Message-Id: <Pine.LNX.4.44L0.1311071018260.1401-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383822869-20283-3-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383822869-20283-3-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 7 Nov 2013, Valentine Barshak wrote:

> This adds external USB phy support to USB HCD driver that
> allows to find and initialize external USB phy, bound to
> the HCD, when the HCD is added.
> The usb_add_hcd function returns -EPROBE_DEFER if the USB
> phy, bound to the HCD, is not ready.
> If no USB phy is bound, the HCD is initialized as usual.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

