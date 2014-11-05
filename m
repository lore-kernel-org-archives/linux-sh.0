From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Wed, 05 Nov 2014 17:14:00 +0000
Subject: Re: [PATCH 5/7] pinctrl: Add driver for Zynq
Message-Id: <77a9809bf6a8476c80d9308a7d3b1ac0@BN1AFFO11FD047.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-6-git-send-email-soren.brinkmann@xilinx.com>
 <5459B1B5.6030001@suse.de>
In-Reply-To: <5459B1B5.6030001@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2014-11-05 at 06:12AM +0100, Andreas Färber wrote:
> Am 03.11.2014 um 20:05 schrieb Soren Brinkmann:
> > +enum zynq_pinmux_functions {
> > +	ZYNQ_PMUX_ethernet0,
> > +	ZYNQ_PMUX_ethernet1,
> > +	ZYNQ_PMUX_mdio0,
> > +	ZYNQ_PMUX_mdio1,
> > +	ZYNQ_PMUX_qspi0,
> > +	ZYNQ_PMUX_qspi1,
> > +	ZYNQ_PMUX_qspi_fbclk,
> > +	ZYNQ_PMUX_qspi_cs1,
> 
> Are usb0 and usb1 intentionally missing in this patch for lack of
> upstream USB driver? If so, then please mention what you left out in the
> commit message.

I don't know how that could happen, but no, it's not intentionally
missing, let's call it accidentally. It just slipped through. Don't
ask me how I could miss USB.

	Thanks,
	Sören
