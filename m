From: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 13 Jul 2013 23:17:52 +0000
Subject: Re: [PATCH] misc: add driver for Renesas R-Car Gyro-ADC/speed-pulse interfaces
Message-Id: <20130713231752.GA8408@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201307130351.42967.sergei.shtylyov@cogentembedded.com>
 <20130713005702.GA14788@kroah.com>
 <51E0AA24.6070203@cogentembedded.com>
 <201307130958.16533.arnd@arndb.de>
 <51E1D406.9090702@cogentembedded.com>
In-Reply-To: <51E1D406.9090702@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Sun, Jul 14, 2013 at 02:26:14AM +0400, Sergei Shtylyov wrote:
>    The other trouble is that I'll have to backport this driver to
> 3.4 which doesn't contain the IIO infrastructure at all. :-(

That doesn't matter to us, we can't accept a driver that should be using
the iio subsystem, but isn't.  So please port it to use that.

thanks,

greg k-h
