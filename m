From: Simon Horman <horms@verge.net.au>
Date: Thu, 03 Oct 2013 04:25:19 +0000
Subject: Re: [PATCH 04/05] ARM: shmobile: Let KZM9D multiplatform boot with KZM9D DTB
Message-Id: <20131003042517.GP7925@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20131001103255.813.65710.sendpatchset@w520>
 <20131001103334.813.45590.sendpatchset@w520>
In-Reply-To: <20131001103334.813.45590.sendpatchset@w520>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Oct 01, 2013 at 07:33:34PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@opensource.se>
> 
> Let the multiplatform KZM9D support boot with the
> legacy DTS for KZM9D as well as the KZM9D reference DTS.
> 
> Signed-off-by: Magnus Damm <damm@opensource.se>

Thanks, I have queued this up in the boards3 branch.
It should make it into v3.13 but if not I'll rename the branch
soc after rebasing it on v3.13-rcX which will then be targeted at v3.14.
