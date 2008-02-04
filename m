From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Date: Mon, 04 Feb 2008 08:27:55 +0000
Subject: Re: [PATCH] SH/Dreamcast - fix regressions, whitespace and memory
Message-Id: <1202113675.6489.6.camel@localhost.localdomain>
List-Id: <linux-sh.vger.kernel.org>
References: <1202068847.6262.7.camel@localhost.localdomain>
	 <20080204052900.GB7585@kroah.com>
In-Reply-To: <20080204052900.GB7585@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Paul Mundt <lethal@linux-sh.org>, linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>


On Sun, 2008-02-03 at 21:29 -0800, Greg KH wrote:
> On Sun, Feb 03, 2008 at 08:00:47PM +0000, Adrian McMenamin wrote:
> > From: Adrian McMenamin
> > 
> > This patch fixes the regression noted here:
> > http://lkml.org/lkml/2008/1/26/189 as well as whitespace issues in the
> > previous commit of this driver and the memory leaks noted here:
> > http://lkml.org/lkml/2008/2/2/143 (as well as one or two other minor
> > cleanups).
> 
> Which portion of the patch fixes the kobject WARN_ON()?



+	if (mdev->registered = 0) {
+		retval = device_register(&mdev->dev);
+		if (retval) {
+			printk(KERN_INFO
+			"Maple bus: Attempt to register device"
+			" (%x, %x) failed.\n",
+			mdev->port, mdev->unit);
+			maple_free_dev(mdev);
+			mdev = NULL;
+			return;
+		}
+		mdev->registered = 1;
+	}
 }


Specifically the check on mdev->registered

Unfortunately the previous commit was completely corrupted by whitespace
everywhere so the patch essentially covers the whole dirver (I had a
choice of submitting broken code with whitespace removed or working code
with whitespace removed)

