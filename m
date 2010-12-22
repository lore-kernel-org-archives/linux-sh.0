From: Paul Mundt <lethal@linux-sh.org>
Date: Wed, 22 Dec 2010 07:36:47 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: sh73a0 CPGA fix for KEYSC
Message-Id: <20101222073647.GB28151@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20101222061405.25163.82564.sendpatchset@t400s>
In-Reply-To: <20101222061405.25163.82564.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Wed, Dec 22, 2010 at 03:14:05PM +0900, Magnus Damm wrote:
> Fix the sh73a0 KEYSC clock control by adding MSTP403
> to mstp_clks[]. Use KEYSC instead of KEYSC0 in comments.

On Wed, Dec 22, 2010 at 03:26:06PM +0900, Magnus Damm wrote:
> On SH-Mobile, Pull UP/Downs can be controlled independently
> from Function selectors (by lower nibble of PFCR).
> It means people may want to use GPIO_FN_xxx_PU/PD in addition
> to GPIO_IN_PU/PD which is currently supported.
> This patch adds pull-up version for some input signals on
> KEYSC, MMC, FSIA as well as SDHI1.

On Wed, Dec 22, 2010 at 03:30:19PM +0900, Magnus Damm wrote:
> Follow up to pfc-sh73a0.c's pull-up support.
> Change GPIO_FN_KEYINx to GPIO_FN_KEYINx_PU.

On Wed, Dec 22, 2010 at 03:35:30PM +0900, Magnus Damm wrote:
> Adding platform resources, PFC setting and release
> reset pin for eMMC on ag5evm.

Applied to rmobile-latest, thanks.
