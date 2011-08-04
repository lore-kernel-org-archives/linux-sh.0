From: Simon Horman <horms@verge.net.au>
Date: Thu, 04 Aug 2011 01:04:09 +0000
Subject: Re: [PATCH] serial: sh-sci: console Runtime PM support
Message-Id: <20110804010359.GA25966@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20110803034736.3425.87722.sendpatchset@t400s>
In-Reply-To: <20110803034736.3425.87722.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Aug 03, 2011 at 12:47:36PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Add Runtime PM context save/restore support to
> the SCIF driver. Tested on the AP4EVB console.

Hi Magnus,

could you explain in a little more detail how this was tested?
Also, is this likely to work on other boards? E.g the AP4 Mackerel?
