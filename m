From: Magnus Damm <magnus.damm@gmail.com>
Date: Fri, 09 Mar 2012 13:51:21 +0000
Subject: Re: [PATCH v2] mmc: sh_mobile_sdhi: support modular mmc-core with non-standard hotplug
Message-Id: <CANqRtoQ8GSmX5U-twQjKmHcBv18RBHO_YW8DqBW8myOauebufg@mail.gmail.com>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1202271454270.32434@axis700.grange>
	<Pine.LNX.4.64.1203091012150.7852@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1203091012150.7852@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, Mar 9, 2012 at 6:16 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> Currently if a platform wants to implement a non-standard card-detection
> method, it would need to call tmio_mmc_cd_wakeup(), which is an inline
> function, calling mmc_detect_change(). For this the platform would have
> to link mmc_core statically into the kernel, losing the ability to build
> it as a module. This patch adds a callback to the sh_mobile_sdhi driver,
> which eliminates this dependency.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Looks good to me, thanks for this!

Acked-by: Magnus Damm <damm@opensource.se>
