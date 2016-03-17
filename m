From: Rich Felker <dalias@libc.org>
Date: Thu, 17 Mar 2016 03:24:41 +0000
Subject: Availability of SH hardware?
Message-Id: <20160317032441.GA22517@brightrain.aerifal.cx>
List-Id: <linux-sh.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

One of my goals in taking on maintainership of arch/sh is to gradually
replace all of the hard-coded legacy board/subtype support with device
tree based board descriptions, and clean up the related board support
infrastructure in arch/sh to be more in line with how things are done
on other archs these days. However the ability to make and test these
changes depends on having some actual hardware to work with.

I'm working on the J-Core (currently J2) open hardware revival of the
SH architecture and don't have any original SH hardware (except
perhaps embedded in old appliances). Does anyone have pointers (direct
add-to-cart'able links) to where SH dev boards are still available, or
even better, any old hardware lying around that's not being used that
you'd be willing to donate?

I'm especially interested in getting an SH-X3 board since it seems to
be the only model with existing SMP support, and moving it over to
device tree would eliminate the need for keeping around the
non-device-tree SMP register_smp_ops and cross-core cache invalidation
infrastructure, which are low-hanging fruit for refactoring/cleanup.
But really anything would be great to have.

Rich
