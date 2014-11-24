From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 24 Nov 2014 20:15:33 +0000
Subject: Re: [PATCH RFC 0/3] Add "Simple" / Renesas Bus State Controller Driver
Message-Id: <6261300.I132f1jLqB@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1416859808-18503-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1416859808-18503-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Ulrich Hecht <ulrich.hecht+renesas@gmail.com>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday 24 November 2014 21:10:05 Geert Uytterhoeven wrote:
> As this minimal BSC driver isn't hardware-specific at all, I'm wondering
> if there's a simpler way to do this?
>   - Should the driver be renamed to "simple-bus", and match "simple-bus"?
>   - Should this be moved to core code, without an explicit driver for
>     "simple-bus"? I.e. should the driver core just enable runtime PM for
>     all devices not bound to a driver, as they may represent buses with
>     child devices that do rely on runtime PM?
> 
> Thanks for your comments and suggestions!

My understanding of simple-bus is that it's something that does
not have any power-management capabilities, and I'd rather not
add clocks or interrupts to it.

What I think makes more sense is to have a bus driver for it
in drivers/bus, remove the "simple-bus" compatibility value
and have the driver take care of registering the power domain
and probing the child devices using of_platform_populate on
itself.

	Arnd
