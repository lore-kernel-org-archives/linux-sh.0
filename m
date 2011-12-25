From: Chris Ball <cjb@laptop.org>
Date: Sun, 25 Dec 2011 02:20:36 +0000
Subject: Re: [PATCH 3/4 v2] mmc: sh_mmcif: process requests asynchronously
Message-Id: <m2boqxz91n.fsf@bob.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
	<1323887514-12650-4-git-send-email-g.liakhovetski@gmx.de>
In-Reply-To: <1323887514-12650-4-git-send-email-g.liakhovetski@gmx.de>
	(Guennadi Liakhovetski's message of "Wed, 14 Dec 2011 19:31:53 +0100")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Wed, Dec 14 2011, Guennadi Liakhovetski wrote:
> This patch converts the sh_mmcif MMC host driver to process requests
> asynchronously instead of waiting in its .request() method for completion.
> This is achieved by using threaded IRQs.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This patch (3/4) no longer applies to mmc-next -- mind resending?

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
