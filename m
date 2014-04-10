From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 10 Apr 2014 09:20:28 +0000
Subject: RE: [PATCH 1/2] usb: rename 'phy' field of 'struct usb_hcd' to 'transceiver'
Message-Id: <063D6719AE5E284EB5DD2968C1650D6D0F6F43C3@AcuExch.aculab.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.44L0.1404091354560.28384-100000@netrider.rowland.org>
 <53458E95.4080505@cogentembedded.com> <534598EF.3010102@wwwdotorg.org>
 <53459A48.1010003@cogentembedded.com>
In-Reply-To: <53459A48.1010003@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: 'Sergei Shtylyov' <sergei.shtylyov@cogentembedded.com>, Stephen Warren <swarren@wwwdotorg.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "Peter.Chen@freescale.com" <Peter.Chen@freescale.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "balbi@ti.com" <balbi@ti.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>

From: Sergei Shtylyov
>     It doesn't do any pin muxing. It switches SoC internal USB signals between
> USB controllers. The pins remain the same.

Doesn't something like that already happen for the companion USB1
controllers for USB2 ports?

That also doesn't sound like you are changing the PHY.
I'd have thought that would happen if you had a single controller
that select between multiply PHY. 

	David



