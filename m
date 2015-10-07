From: Simon Horman <horms@verge.net.au>
Date: Wed, 07 Oct 2015 03:39:58 +0000
Subject: Re: [PATCH] ARM: shmobile: porter: add SDHI0/2 DT support
Message-Id: <20151007033957.GA30650@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <2228837.DO5U5OvRSi@wasted.cogentembedded.com>
In-Reply-To: <2228837.DO5U5OvRSi@wasted.cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Oct 07, 2015 at 02:05:41AM +0300, Sergei Shtylyov wrote:
> Define the Porter board dependent part of the SDHI0/2 device nodes along with
> the  necessary  voltage regulators (note that the Vcc regulators are dummy --
> they are required but don't actually exist on the board). Also, GPIOs have to
> be used for the CD and WP signals due to the SDHI driver constraints...
> 
> This patch is analogous to the commit 1299df03d719 (ARM: shmobile: henninger:
> add SDHI0/2 DT support) as there  are no differences between those boards in
> this respect.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> 
> ---
> This patch is against the 'renesas-devel-20151006-v4.3-rc4' tag of Simon
> Horman's 'renesas.git' repo.

Thanks I have queued this up after addressing some issues
in the changelog that checkpatch complained about:

* text > 75 characters wide
* Missing '"' around name of patch referred to

Its looking like there is already quite a log shared between
r8a7791-porter.dts and r8a7791-henninger.dts. Do you have any
thoughts on consolidating or sharing common elements between
them somehow?
