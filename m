From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Sat, 13 Jul 2013 01:15:16 +0000
Subject: Re: [PATCH] misc: add driver for Renesas R-Car Gyro-ADC/speed-pulse interfaces
Message-Id: <51E0AA24.6070203@cogentembedded.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201307130351.42967.sergei.shtylyov@cogentembedded.com> <20130713005702.GA14788@kroah.com>
In-Reply-To: <20130713005702.GA14788@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@linuxfoundation.org>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

Hello.

    Can't get to sleep, sigh...

On 07/13/2013 04:57 AM, Greg KH wrote:

>> Add the driver for Gyro-ADC/speed-pulse interfaces found in Renesas R-Car SoCs.
>> Though  being two separate devices, they have to be driven together because of
>> the shared start/stop register (located in Gyro-ADC still). At this time, only
>> speed-pulse interface is fully supported, the Gyro-ADC is just initialized and
>> started/stopped synchronously with the speed-pulse interface.  A user interface
>> is implemented via several sysfs files which allow to read and reset the speed-
>> pulse interface's registers.

> If you modify/create/remove sysfs files, you also have to document them
> in Documentation/ABI/ which is missing from this patch.

    I've looked there and didn't find the documentation for my closest
model driver, drivers/misc/ti_dac7512.c (or for many other drivers), so 
I thought I too can do without it.

> Your sysfs files are also being created in a "racy" way, i.e. after
> userspace is told about the device, please fix that as well.

    Not sure I understand you. Could you elaborate?

> And are you sure you want to control this through sysfs?  There's no
> other better user/kernel apis for it?

    I found none, besides ioctl(), as the device driven is rather 
unique. But I thought that sysfs is "ioctl() today", so I went with it...

> thanks,

> greg k-h

WBR, Sergei

