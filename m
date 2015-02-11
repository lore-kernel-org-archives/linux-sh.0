From: Vinod Koul <vinod.koul@intel.com>
Date: Wed, 11 Feb 2015 01:35:55 +0000
Subject: Re: [PATCH v2 1/2] shdmac: use SET_RUNTIME_PM_OPS()
Message-Id: <20150211012355.GG21387@intel.com>
List-Id: <linux-sh.vger.kernel.org>
References: <9005734.b9UuUHqyUV@wasted.cogentembedded.com>
In-Reply-To: <9005734.b9UuUHqyUV@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Jan 21, 2015 at 12:09:46AM +0300, Sergei Shtylyov wrote:
> Use SET_RUNTIME_PM_OPS() to initialize the runtime PM method pointers in the
> 'struct dev_pm_ops';  since that macro doesn't  do anything  if CONFIG_PM is
> not defined, we have  to move #ifdef up to also cover the runtime PM methods
> in order to avoid compilation warnings.
> 
Applied both, thanks.

Btw shdmac is NOT a subsystem name!!

-- 
~Vinod

