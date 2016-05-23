From: Simon Horman <horms@verge.net.au>
Date: Mon, 23 May 2016 00:41:13 +0000
Subject: Re: [PATCH v2 0/2] ARM/arm64: renesas: Stop using drivers/sh/
Message-Id: <20160523004112.GE25562@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1463730655-16199-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1463730655-16199-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, linux-renesas-soc@vger.kernel.org, linux-sh@vger.kernel.org

On Fri, May 20, 2016 at 09:50:53AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> Now CONFIG_PM and CONFIG_PM_GENERIC_DOMAINS are enabled unconditionally
> for Renesas ARM-based SoCs, the legacy clock domain is no longer used on
> these SoCs, and we can return drivers/sh/ to SuperH.
> 
> Both patches were extracted from series "[PATCH 0/4] Enable PM and
> PM_GENERIC_DOMAINS for SoCs with PM Domains", and updated, hence the
> v2.
> 
> Note that this does break booting R-Car Gen2 boards using pre-v4.3 DTSes
> that don't have power-domains properties, as this relied on the legacy
> clock domain.
> 
> Thanks!

Thanks, I have queued this up for v4.8 which should give it a good
amount of time to sit in next.
