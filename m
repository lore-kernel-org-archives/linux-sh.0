From: Greg KH <gregkh@linuxfoundation.org>
Date: Sat, 13 Jul 2013 00:57:02 +0000
Subject: Re: [PATCH] misc: add driver for Renesas R-Car Gyro-ADC/speed-pulse interfaces
Message-Id: <20130713005702.GA14788@kroah.com>
List-Id: <linux-sh.vger.kernel.org>
References: <201307130351.42967.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201307130351.42967.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc: arnd@arndb.de, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

On Sat, Jul 13, 2013 at 03:51:42AM +0400, Sergei Shtylyov wrote:
> Add the driver for Gyro-ADC/speed-pulse interfaces found in Renesas R-Car SoCs.
> Though  being two separate devices, they have to be driven together because of
> the shared start/stop register (located in Gyro-ADC still). At this time, only
> speed-pulse interface is fully supported, the Gyro-ADC is just initialized and
> started/stopped synchronously with the speed-pulse interface.  A user interface
> is implemented via several sysfs files which allow to read and reset the speed-
> pulse interface's registers.

If you modify/create/remove sysfs files, you also have to document them
in Documentation/ABI/ which is missing from this patch.

Your sysfs files are also being created in a "racy" way, i.e. after
userspace is told about the device, please fix that as well.

And are you sure you want to control this through sysfs?  There's no
other better user/kernel apis for it?

thanks,

greg k-h
