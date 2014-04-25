From: Simon Horman <horms@verge.net.au>
Date: Fri, 25 Apr 2014 01:35:57 +0000
Subject: Re: [PATCH v5 00/15] Renesas CMT, MTU2 and TMU platform cleanups
Message-Id: <20140425013556.GF12641@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1398251722-31667-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Apr 23, 2014 at 01:15:07PM +0200, Laurent Pinchart wrote:
> Hello,
> 
> This patch set switches all Renesas platforms to the new style CMT, MTU2 and
> TMU device platform data. All patches have been previously posted as part of
> the "[PATCH v3 00/52] Renesas CMT and TMU cleanups" and "[PATCH 00/22] SH MTU2
> DT support" patch series.
> 
> This new version fixes an interrupt-related bug introduced when switching the
> sh7372 and sh73a0 platforms to the new style TMU device, caused by mistakenly
> using evt2irq instead of intcs_evt2irq for the IRQ resources.
> 
> Simon, I've tested this on Mackerel and the board now boots correctly. Could
> you please assist me in debugging the Bock-W boot hang issue, as I don't have
> access to that board ?

Yes, of course I am happy to help.
