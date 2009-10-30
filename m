From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 30 Oct 2009 06:59:16 +0000
Subject: Re: [PATCH 00/09] sh:  sh: SuperH Mobile Sleep Mode Rewrite Part 2/2
Message-Id: <20091030065916.GA18508@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20091030042331.11783.88942.sendpatchset@rxone.opensource.se>
In-Reply-To: <20091030042331.11783.88942.sendpatchset@rxone.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Oct 30, 2009 at 01:23:31PM +0900, Magnus Damm wrote:
> [PATCH 01/09] sh: Move ap325rxa board code into separate directory
> [PATCH 02/09] sh: Add ap325rxa specific memory pre/post sleep code
> [PATCH 03/09] sh: Add Ecovec24 specific memory pre/post sleep code
> [PATCH 04/09] sh: Rework SuperH Mobile sleep mode code
> [PATCH 05/09] sh: Keep track of allowed sleep modes
> [PATCH 06/09] sh: Add MMU and Cache handling sleep mode code
> [PATCH 07/09] sh: Use RSMEM for sleep code on sh7724
> [PATCH 08/09] sh: Add R-standby sleep mode support
> [PATCH 09/09] sh: Add KFR2R09 specific memory pre/post R-standby code

On Fri, Oct 30, 2009 at 03:22:03PM +0900, Magnus Damm wrote:
> Update the SDHI platform data for the AP325RXA board
> to include support for the CN7 Micro SD Card slot.

On Fri, Oct 30, 2009 at 03:26:04PM +0900, Magnus Damm wrote:
> Get rid of the unused WP signal for SDHI0 on KFR2R09.
> This because yc304 on KFR2R09 is a Micro SD slot which
> does not implement the WP signal.

Applied, thanks.
