From: Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 09 Apr 2014 17:56:30 +0000
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Message-Id: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org>
List-Id: <linux-sh.vger.kernel.org>
References: <534588F1.2050406@cogentembedded.com>
In-Reply-To: <534588F1.2050406@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, Peter.Chen@freescale.com, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

On Wed, 9 Apr 2014, Sergei Shtylyov wrote:

> > Ok, the existing field is being replaced by something? I didn't get that
> 
>     No, not replaced. I'm adding the support for generic PHY to the existing 
> USB PHY support. I thought that was clear from the changelog.
> 
> > from the patch description; I thought the new name in this patch was
> > going to be it. In that case, a temporary name of usb_phy for the
> > existing field, or adding the new field as gen_phy sound reasonable.
> 
>     OK, I'll respin the patch #2 with 'gen_phy' and remove the patch #1.

What is the reason for all of this?  That is, can you explain the
difference between USB PHY support and general PHY support, and why we
need both?

Alan Stern

