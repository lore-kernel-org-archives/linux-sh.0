From: Simon Horman <horms@verge.net.au>
Date: Tue, 07 Jan 2014 01:02:26 +0000
Subject: Re: [PATCH 1/2] ARM: shmobile: Lager: pass Ether PHY IRQ
Message-Id: <20140107010224.GA28639@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <201312200218.08076.sergei.shtylyov@cogentembedded.com>
 <201312200219.31121.sergei.shtylyov@cogentembedded.com>
In-Reply-To: <201312200219.31121.sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 20, 2013 at 02:19:30AM +0300, Sergei Shtylyov wrote:
> Pass Ether's PHY IRQ (which is IRQC's IRQ0) to the 'sh_eth' driver. Set the IRQ
> trigger type to be low-level as per the Micrel PHY driver's setup.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Hi Sergei,

for better or for worse I believe this is a v3.15 candidate.

Could you repost it once v3.14-rc1 has been released,
I believe it will include the dependencies of this patch.

Thanks
