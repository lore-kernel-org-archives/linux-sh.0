From: Paul Mundt <lethal@linux-sh.org>
Date: Fri, 11 Nov 2011 07:51:30 +0000
Subject: Re: [PATCH] ARM: mach-shmobile: cpuidle single/global and last_state fixes
Message-Id: <20111111075130.GI29807@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20111111050130.9104.12599.sendpatchset@w520>
In-Reply-To: <20111111050130.9104.12599.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Fri, Nov 11, 2011 at 02:01:30PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> The following commits break cpuidle on SH-Mobile ARM:
> 
> 46bcfad cpuidle: Single/Global registration of idle states
> e978aa7 cpuidle: Move dev->last_residency update to driver enter routine; remove dev->last_state
> 
> This patch remedies these issues by up-porting the SH-Mobile
> code to fit with the above introduced framework changes.
> 
> It is worth noting that the new code becomes significantly cleaner,
> so these framework changes are very welcome. At the same time this
> breakage could probably have been avoided by grepping for "last_state"
> and "cpuidle_register_driver".
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Applied, thanks.
