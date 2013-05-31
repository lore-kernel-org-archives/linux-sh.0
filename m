From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 31 May 2013 15:11:59 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: sdhi: pass DMA filter from platform code
Message-Id: <2862988.jnTv0iSQcj@wuerfel>
List-Id: <linux-sh.vger.kernel.org>
References: <1370008605-3745603-1-git-send-email-arnd@arndb.de>
 <alpine.DEB.2.00.1305311611460.7395@axis700.grange>
In-Reply-To: <alpine.DEB.2.00.1305311611460.7395@axis700.grange>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Friday 31 May 2013 16:52:13 Guennadi Liakhovetski wrote:
> 
> Thanks for the patches. How about this fix:
> 
> http://thread.gmane.org/gmane.linux.kernel.mmc/20619
> 
> I think it's a better fix. SHDMA users cannot use other DMA drivers, so, I 
> don't think we need to pass the filter via the platform data.

I think it's more a matter of using the API correctly. The dmaengine
API is an abstraction to separate the slave driver from the master
through well-defined calls. If you make additional assumptions
in the slave driver about the master, that is a layering violation.

	Arnd
