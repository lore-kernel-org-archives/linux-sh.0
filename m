From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 09 Apr 2014 16:48:21 +0000
Subject: Re: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Message-Id: <534579D5.10306@wwwdotorg.org>
List-Id: <linux-sh.vger.kernel.org>
References: <201404091757.16574.sergei.shtylyov@cogentembedded.com> <534567BA.5030208@wwwdotorg.org> <534574FB.7060901@cogentembedded.com>
In-Reply-To: <534574FB.7060901@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org
Cc: Peter.Chen@freescale.com, stern@rowland.harvard.edu, thierry.reding@gmail.com, balbi@ti.com, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, magnus.damm@gmail.com

On 04/09/2014 10:27 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 04/09/2014 07:31 PM, Stephen Warren wrote:
> 
>>> Return to the 'phy' field of 'struct usb_hcd' its historic name
>>> 'transceiver'.
>>> This is in preparation to adding the generic PHY support.
> 
>> Surely if the correct term is transceiver, we should be adding generic
>> transceiver support not generic PHY support? To be honest, this rename
>> feels like churn, especially since the APIs and DT bindings all still
>> include the work phy so now everything will be inconsistent.
> 
>    How about 'usb_phy'?

That certainly would make things more consistent, but I wonder why
"usb_phy" is better than "phy" when the code/struct in question is
something USB-specific; the "usb_" prefix seems implicit to me due to
context.
