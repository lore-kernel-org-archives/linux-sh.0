From: Arnd Bergmann <arnd@arndb.de>
Date: Sat, 13 Jul 2013 07:58:16 +0000
Subject: Re: [PATCH] misc: add driver for Renesas R-Car Gyro-ADC/speed-pulse interfaces
Message-Id: <201307130958.16533.arnd@arndb.de>
List-Id: <linux-sh.vger.kernel.org>
References: <201307130351.42967.sergei.shtylyov@cogentembedded.com> <20130713005702.GA14788@kroah.com> <51E0AA24.6070203@cogentembedded.com>
In-Reply-To: <51E0AA24.6070203@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Saturday 13 July 2013, Sergei Shtylyov wrote:
> > And are you sure you want to control this through sysfs?  There's no
> > other better user/kernel apis for it?
> 
>     I found none, besides ioctl(), as the device driven is rather 
> unique. But I thought that sysfs is "ioctl() today", so I went with it...
> 

It does sound like it would fit better into IIO than just a misc driver,
even if it's the only hardware of its kind.

	Arnd
