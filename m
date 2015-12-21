From: Phil Edworthy <phil.edworthy@renesas.com>
Date: Mon, 21 Dec 2015 10:52:37 +0000
Subject: RE: [PATCH 2/4] PCI: rcar: Support runtime PM link state L1 handling in pcie-rcar
Message-Id: <KL1PR06MB1174165C6112327548CD29DDF5E40@KL1PR06MB1174.apcprd06.prod.outlook.com>
List-Id: <linux-sh.vger.kernel.org>
References: <1450358557-28376-1-git-send-email-phil.edworthy@renesas.com>
 <1450358557-28376-3-git-send-email-phil.edworthy@renesas.com>
 <20151217133058.GA20372@katana>
 <PS1PR06MB1180304088ECF5384C497E40F5E10@PS1PR06MB1180.apcprd06.prod.outlook.com>
 <20151218140412.GA4595@katana>
In-Reply-To: <20151218140412.GA4595@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Simon Horman <horms@verge.net.au>, Bjorn Helgaas <bhelgaas@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>

Hi Wolfram,

On 18 December 2015 14:04, Wolfram Sang wrote:
> > Since the hardware doesn't support hot plug, I believe this loop will
> > always exit very quickly. Unless someone has taken a hammer to the HW
> > of course.
> 
> I know what you mean. But since readl_poll_timeout() makes it easy, we
> should better be safe than sorry.
Hmm, I changed the code, but now it doesn't come out of suspend unless
sleep_us passed to readl_poll_timeout is 0. Any reason you can think of?

To test, I am just using:
Build the kernel with CONFIG_PM_DEBUG. 
echo platform > /sys/power/pm_test
echo N > /sys/module/printk/parameters/console_suspend
echo mem > /sys/power/state

Thanks
Phil
