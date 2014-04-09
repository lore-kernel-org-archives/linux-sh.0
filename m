From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 09 Apr 2014 15:31:06 +0000
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Message-Id: <534567BA.5030208@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201404091757.16574.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201404091757.16574.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: Peter.Chen@freescale.com, stern@rowland.harvard.edu, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

On 04/09/2014 07:57 AM, Sergei Shtylyov wrote:
> Return to the 'phy' field of 'struct usb_hcd' its historic name 'transceiver'. 
> This is in preparation to adding the generic PHY support.

Surely if the correct term is transceiver, we should be adding generic
transceiver support not generic PHY support? To be honest, this rename
feels like churn, especially since the APIs and DT bindings all still
include the work phy so now everything will be inconsistent.
