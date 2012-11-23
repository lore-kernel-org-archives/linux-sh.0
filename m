From: Samuel Ortiz <sameo@linux.intel.com>
Date: Fri, 23 Nov 2012 14:21:18 +0000
Subject: Re: [PATCH v2 2/2] regulator: add a regulator driver for the AS3711 PMIC
Message-Id: <20121123142118.GI12685@sortiz-mobl>
List-Id: <linux-sh.vger.kernel.org>
References: <Pine.LNX.4.64.1211221107520.28453@axis700.grange>
 <Pine.LNX.4.64.1211221110330.28453@axis700.grange>
 <20121123111515.GD12685@sortiz-mobl>
 <20121123114915.GG4529@opensource.wolfsonmicro.com>
In-Reply-To: <20121123114915.GG4529@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org

On Fri, Nov 23, 2012 at 08:49:16PM +0900, Mark Brown wrote:
> On Fri, Nov 23, 2012 at 12:15:15PM +0100, Samuel Ortiz wrote:
> 
> > Mark, does that look ok with you ? There's a build dependency with patch #1,
> > so it would make sense for me to take it.
> 
> If there's a build dependency there's a problem - the Kconfig should
> prevent the driver being selected without the MFD.
It indeed does, sorry for the noise.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
