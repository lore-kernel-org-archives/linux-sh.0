From: Simon Horman <horms@verge.net.au>
Date: Wed, 13 Feb 2013 03:36:32 +0000
Subject: Re: [PATCH v2 2/8] ARM: shmobile: add SDHI and MMCIF interfaces to armadillo800eva-reference
Message-Id: <20130213033632.GB30425@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1360348712-29255-3-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1360348712-29255-3-git-send-email-g.liakhovetski@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Feb 08, 2013 at 07:38:26PM +0100, Guennadi Liakhovetski wrote:
> Add SDHI0, SDHI1 and MMCIF interfaces to armadillo800eva-reference. With
> no pinctrl DT support we cannot use GPIO card-detection and regulator
> switching.

Thanks. I have added this to the topic/intc-of branch.
