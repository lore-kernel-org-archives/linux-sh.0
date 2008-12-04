From: Paul Mundt <lethal@linux-sh.org>
Date: Thu, 04 Dec 2008 14:07:54 +0000
Subject: Re: [PATCH 00/03] sh: CONFIG_PM and CONFIG_CPU_IDLE
Message-Id: <20081204140754.GB14492@linux-sh.org>
List-Id: <linux-sh.vger.kernel.org>
References: <20081204134455.21168.38196.sendpatchset@rx1.opensource.se>
In-Reply-To: <20081204134455.21168.38196.sendpatchset@rx1.opensource.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Thu, Dec 04, 2008 at 10:44:55PM +0900, Magnus Damm wrote:
> CONFIG_PM and CONFIG_CPU_IDLE:
> 
> [PATCH 01/03] sh: move the hp6xx pm code
> [PATCH 02/03] sh: allow CONFIG_PM
> [PATCH 03/03] sh: allow CONFIG_CPU_IDLE
> 
> These patches allow SuperH users to select CONFIG_PM and
> CONFIG_CPU_IDLE. Suspend and hibernation are however not
> allowed by default, platforms wanting such support should
> use ARCH_SUSPECT_POSSIBLE and ARCH_HIBERNATION_POSSIBLE.
> 
> The not-so-generic pm code used by hp6xx is moved in next
> to the rest of the hp6xx pm code.
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>

Applied, thanks.
