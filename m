From: Simon Horman <horms@verge.net.au>
Date: Tue, 08 Oct 2013 01:53:09 +0000
Subject: Re: [PATCH 3/4] ARM: shmobile: r8a7779: tidyup I2C driver name on DTSI
Message-Id: <20131008015307.GD16625@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <87fvshzg9z.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87fvshzg9z.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Oct 03, 2013 at 11:44:44PM -0700, Kuninori Morimoto wrote:
> 10e8d4f6dddb0f9dc408c2f2bde8399b243a42ca
> (ARM: mach-shmobile: r8a7779: Minimal setup using DT)
> added I2C driver, but it was SH-Mobile I2C.
> R-Car H1 needs R-Car I2C driver.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Thanks, I have queued this up but I am unsure if it will
end up in v3.13 or v3.14.
