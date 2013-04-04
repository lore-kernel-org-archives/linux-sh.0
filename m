From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Apr 2013 04:43:25 +0000
Subject: Re: [PATCH] ARM: shmobile: kzm9g: enable AS3711 PMIC in defconfig
Message-Id: <20130404044325.GH28297@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1304031752440.10531@axis700.grange>
In-Reply-To: <Pine.LNX.4.64.1304031752440.10531@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 03, 2013 at 05:53:54PM +0200, Guennadi Liakhovetski wrote:
> An AS3711 PMIC is used on kzm9g to supply CPU power and LCD backlight.
> This patch enables it in board defconfig.

Thanks, applied to the defconfigs branch.
I will endeavour to get this included in v3.10.
