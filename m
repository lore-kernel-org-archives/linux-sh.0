From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 03:49:48 +0000
Subject: Re: [PATCH 01/05] ARM: shmobile: Sync KZM9D DTS with KZM9D reference DTS
Message-Id: <20131003034947.GH28463@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131001103255.813.65710.sendpatchset@w520>
 <20131001103305.813.70296.sendpatchset@w520>
In-Reply-To: <20131001103305.813.70296.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 01, 2013 at 07:33:05PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Copy the device nodes from KZM9D reference into the KZM9D
> device tree file. This will allow us to use a single DTS
> file regarless of kernel configuration. In case of legacy
> C board code the device nodes may or may not be used, but
> in the multiplatform case all the DT device nodes are used.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>
> ---
> 
>  arch/arm/boot/dts/emev2-kzm9d.dts |   33 ++++++++++++++++++++++++++++++++-
>  1 file changed, 32 insertions(+), 1 deletion(-)

Thanks, I have queued this up in the dt3 branch.
It should make it into v3.13 but if not I'll rename the branch
dt after rebasing it on v3.13-rcX which will then be targeted at v3.14.
