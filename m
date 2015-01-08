From: Simon Horman <horms@verge.net.au>
Date: Thu, 08 Jan 2015 00:07:51 +0000
Subject: Re: [PATCH v2 0/2] ARM: shmobile: sh73a0: CCF conversion fallout
Message-Id: <20150108000750.GB18943@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1420574166-14979-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420574166-14979-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jan 06, 2015 at 08:56:04PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series contains two missing pieces for the sh73a0 common
> clock framework conversion.
> 
> Both patches are independent of each other, but please note that "ARM:
> shmobile: sh73a0 dtsi: Add missing INTCA0 clock for irqpin module"
> (con)textually depends on "ARM: shmobile: sh73a0 dtsi: Set
> control-parent for all irqpin nodes", which is a fix for a crash and
> thus had higher priority.
> 
> Thanks for applying!

Thanks, done.
