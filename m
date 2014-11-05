From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Date: Wed, 05 Nov 2014 17:10:30 +0000
Subject: Re: [PATCH 5/7] pinctrl: Add driver for Zynq
Message-Id: <20d5a924832b4a91819fdbecc33b11b6@BL2FFO11FD006.protection.gbl>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-6-git-send-email-soren.brinkmann@xilinx.com>
 <54599853.9050706@suse.de>
In-Reply-To: <54599853.9050706@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2014-11-05 at 04:24AM +0100, Andreas Färber wrote:
> Hi,
> 
> Am 03.11.2014 um 20:05 schrieb Soren Brinkmann:
> > +	PINCTRL_PIN(54, "EMIO_SD0_WP"),
> > +	PINCTRL_PIN(55, "EMIO_SD0_CD"),
> > +	PINCTRL_PIN(56, "EMIO_SD1_WP"),
> > +	PINCTRL_PIN(57, "EMIO_SD0_CD"),
> 
> Should this be "EMIO_SD1_CD"?

Absolutely, good catch.

	Thanks,
	Sören
