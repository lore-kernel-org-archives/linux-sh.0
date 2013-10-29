From: Simon Horman <horms@verge.net.au>
Date: Tue, 29 Oct 2013 04:32:16 +0000
Subject: Re: [PATCH 3/3] arm: shmobile: lager: Add USBHS support
Message-Id: <20131029043216.GB20432@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1381188423-1867-4-git-send-email-valentine.barshak@cogentembedded.com>
In-Reply-To: <1381188423-1867-4-git-send-email-valentine.barshak@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 10, 2013 at 02:14:47AM +0400, Valentine Barshak wrote:
> This adds USBHS PHY and registers USBHS device if the driver is enabled.
> 
> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
> Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks,

I notice that Felipe Balbi's has merged the first patch of this series and
that it is present in linux-next though not in v3.12-rc7. My assumption is
that means it will appear in v3.13-rc1 but not v3.12.

With this in mind my current plan is to wait for v3.13-rc1, rebase my
branches, and then queue-up this patch for v3.14.
