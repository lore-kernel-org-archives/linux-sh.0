From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 13 Jul 2013 22:26:14 +0000
Subject: Re: [PATCH] misc: add driver for Renesas R-Car Gyro-ADC/speed-pulse interfaces
Message-Id: <51E1D406.9090702@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201307130351.42967.sergei.shtylyov@cogentembedded.com> <20130713005702.GA14788@kroah.com> <51E0AA24.6070203@cogentembedded.com> <201307130958.16533.arnd@arndb.de>
In-Reply-To: <201307130958.16533.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

On 07/13/2013 11:58 AM, Arnd Bergmann wrote:

>>> And are you sure you want to control this through sysfs?  There's no
>>> other better user/kernel apis for it?

>>      I found none, besides ioctl(), as the device driven is rather
>> unique. But I thought that sysfs is "ioctl() today", so I went with it...

> It does sound like it would fit better into IIO than just a misc driver,
> even if it's the only hardware of its kind.

    I got somewhat familiarized myself with drivers/iio/ infrastructure 
and I have found a place only the for ADC device in which the customer 
currently has no interest.
    The other trouble is that I'll have to backport this driver to 3.4 
which doesn't contain the IIO infrastructure at all. :-(

> 	Arnd

WBR, Sergei


