From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 02 May 2014 16:31:55 +0000
Subject: Re: [PATCH 1/2] DMA: shdma: tidyup callback chunk finder
Message-Id: <20140502161955.GY32284@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <87lhvnrtkw.wl%kuninori.morimoto.gx@gmail.com>
 <87k3b7rtjw.wl%kuninori.morimoto.gx@gmail.com>
In-Reply-To: <87k3b7rtjw.wl%kuninori.morimoto.gx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: Linux-SH <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org

On Wed, Apr 02, 2014 at 08:16:51PM -0700, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Current shdma is using "last" which indicates last desc
> which needs to have callback function.
> but, that desc's chunks is always 1
> We can use it as finder
> 
Applied both with reflow of changelog.

Also in future pls use right subsystem name "dmaengine"

-- 
~Vinod
