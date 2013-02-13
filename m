From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 04:32:59 +0000
Subject: Re: [PATCH/RFC 3/3] ARM: shmobile: switch SDHI and MMCIF interfaces on kzm9g-reference to pinctrl
Message-Id: <20130213043259.GN30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360684204-12888-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360684204-12888-4-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Feb 12, 2013 at 04:50:04PM +0100, Guennadi Liakhovetski wrote:
> The recently added on sh73a0 DT pinctrl support enables us to switch SDHI
> and MMCIF interface pins to pinctrl and to add GPIO bindings for their
> card-detection pins and regulators.

This depends on an earlier patch of yours
"ARM: shmobile: move GIC and I2C devices from sh73a0 common .dtsi to reference"
which I have replied to.
