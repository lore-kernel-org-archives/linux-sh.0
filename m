From: Simon Horman <horms@verge.net.au>
Date: Tue, 13 Jan 2015 02:08:18 +0000
Subject: Re: [PATCH 0/4] ARM: shmobile: sh73a0/kzm9g: Complete multiplatform support
Message-Id: <20150113020818.GB21265@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <1420809866-4330-1-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1420809866-4330-1-git-send-email-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jan 09, 2015 at 02:24:26PM +0100, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series completes the migration from kzm9g-reference (legacy
> DT based) to kzm9g-multiplatform (ARM multiplatform DT based with
> common clock framework).
> 
>   - The first two patches fix Ethernet on kzm9g, by adding a Bus State
>     Controller node, as introduced in "[PATCH v3 0/4] drivers: bus:
>     Add Simple Power-Managed Bus", and moving the Ethernet node to it,
>   - The third path enables kzm9g support in shmobile_defconfig,
>   - The fourth patch removes all kzm9g-reference support, now the
>     sh73a0 generic multiplatform case has the same feature set
>     (better, it provides 16 MiB more RAM!).
> 
> Thanks for applying!

It seems to me that at the first two patches require the patchset
referenced above in order to work. For that reason I am holding off
on applying this series. I am quite happy to negotiate merging
some or all of this series earlier than later :)
