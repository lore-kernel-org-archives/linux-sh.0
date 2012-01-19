From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 19 Jan 2012 02:17:40 +0000
Subject: Re: [PATCH v2] ARM: mach-shmobile: mackerel: use renesas_usbhs instead of r8a66597_hcd
Message-Id: <20120119021740.GJ8182@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <4D087CC8.6020803@renesas.com>
In-Reply-To: <4D087CC8.6020803@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 18, 2012 at 05:32:05PM -0800, Kuninori Morimoto wrote:
> Current renesas_usbhs driver can use both USB host/gadget.
> This patch removes current r8a66597_hcd driver settings,
> and adds renesas_usbhs host driver settings for mackerel USB1 port.
> You can still use this port as "gadget" with small modify.

On Wed, Jan 18, 2012 at 04:37:07PM -0800, Kuninori Morimoto wrote:
> current ak4642 needs amixer settings for playing which was not
> needed on old kernel.
> This patch show it on comment area

Both applied, thanks.
