From: Alan Stern <stern@rowland.harvard.edu>
Date: Thu, 07 Nov 2013 15:18:20 +0000
Subject: Re: [RFC V2 PATCH 1/2] usb: hcd: Remove USB phy if needed
Message-Id: <Pine.LNX.4.44L0.1311071017250.1401-100000@iolanthe.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <1383822869-20283-2-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1383822869-20283-2-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, 7 Nov 2013, Valentine Barshak wrote:

> This adds remove_phy flag to the HCD structure. If the flag is
> set and if hcd->phy is valid, the phy is shutdown and released
> whenever usb_add_hcd fails or usb_hcd_remove is called.
> This can be used by the HCD drivers to auto-remove
> the external USB phy when it is no longer needed.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>

