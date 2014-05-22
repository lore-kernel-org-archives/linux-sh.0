From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 22 May 2014 08:19:38 +0000
Subject: R-CAR's arch
Message-Id: <20140522101938.51fec16f@endymion.delvare>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

Hi Simon and all,

I am in the process of cleaning up dependencies for hardware-specific
linux drivers. I'm looking into R-CAR drivers now and I have to admit I
am confused. Some drivers (drm, gpio) depend on ARM, some (i2c, gen2
pci, thermal, sata) depend on ARCH_SHMOBILE, sound depends on SUPERH ||
ARCH_SHMOBILE, gen2 usb depends on ARCH_R8A7790 || ARCH_R8A7791, while
gen1 usb and video-in have no architecture/platform dependency at all.

Shouldn't all these drivers have the same architecture/platform
dependency? If so, what would the correct one be?

I admit I don't really understand how SHMOBILE relates to ARM and
SUPERH (which so far I thought were two different and totally
independent architectures, but apparently I was wrong?)

Thanks,
-- 
Jean Delvare
SUSE L3 Support
