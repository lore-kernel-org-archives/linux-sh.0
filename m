From: Chris Ball <cjb@laptop.org>
Date: Fri, 09 Mar 2012 04:29:10 +0000
Subject: Re: [PATCH] mmc: tmio_mmc: do not enable card hotplug interrupts, if unused
Message-Id: <m2fwdiqtwp.fsf@bob.laptop.org>
List-Id: <linux-sh.vger.kernel.org>
References: <alpine.DEB.2.00.1202221314351.3136@axis700.grange>
In-Reply-To: <alpine.DEB.2.00.1202221314351.3136@axis700.grange> (Guennadi
	Liakhovetski's message of "Wed, 22 Feb 2012 13:16:09 +0100 (CET)")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>

Hi Guennadi,

On Wed, Feb 22 2012, Guennadi Liakhovetski wrote:
> If TMIO MMC is used in polling mode, or the card is non-removable, or
> card-detection is performed, using an external interrupt, there is no
> need to enable controller native card hotplug interrupts.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Thanks, pushed to mmc-next for 3.4.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
