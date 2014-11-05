From: =?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?= <afaerber@suse.de>
Date: Wed, 05 Nov 2014 03:24:03 +0000
Subject: Re: [PATCH 5/7] pinctrl: Add driver for Zynq
Message-Id: <54599853.9050706@suse.de>
List-Id: <linux-sh.vger.kernel.org>
References: <1415041531-15520-1-git-send-email-soren.brinkmann@xilinx.com>
 <1415041531-15520-6-git-send-email-soren.brinkmann@xilinx.com>
In-Reply-To: <1415041531-15520-6-git-send-email-soren.brinkmann@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi,

Am 03.11.2014 um 20:05 schrieb Soren Brinkmann:
> +	PINCTRL_PIN(54, "EMIO_SD0_WP"),
> +	PINCTRL_PIN(55, "EMIO_SD0_CD"),
> +	PINCTRL_PIN(56, "EMIO_SD1_WP"),
> +	PINCTRL_PIN(57, "EMIO_SD0_CD"),

Should this be "EMIO_SD1_CD"?

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imendörffer; HRB 21284 AG Nürnberg
