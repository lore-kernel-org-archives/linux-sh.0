From: Simon Horman <horms@verge.net.au>
Date: Wed, 22 Jul 2015 00:34:38 +0000
Subject: Re: [PATCH v2] ARM: shmobile: r8a7779 Marzen legacy fix V2
Message-Id: <20150722003437.GA25644@verge.net.au>
List-Id: <linux-sh.vger.kernel.org>
References: <20150714072522.2854.69938.sendpatchset@little-apple>
In-Reply-To: <20150714072522.2854.69938.sendpatchset@little-apple>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

On Tue, Jul 14, 2015 at 04:25:22PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm+renesas@opensource.se>
> 
> Unbreak the r8a7779 Marzen legacy code provided by marzen_defconfig.
> 
> As it is today Marzen multiplatform is working, but the legacy code
> is broken. This patch intends to leave multiplatform as-is but do
> a simple one-shot fix to unbreak the legacy code base.
> 
> Without this patch there is no preset delay and the TWD is defined
> both in C code and in DT. Solve the delay by invoking shmobile_init_delay()
> and simply disable TWD in case of building for legacy.
> 
> Marzen legacy code will be removed in the near future, but until then
> we may as well avoid breaking it.
> 
> Signed-off-by: Magnus Damm <damm+renesas@opensource.se>

I currently have this patch queued up.
However, as "[PATCH 00/03] ARM: shmobile: r8a7779 Marzen legacy removal" is
also queued up I have it in mind to drop this patch. The reasoning is
twofold:

* There seems little benefit to fix legacy code that is being removed
* There is a tedious merge conflict between fixing and removing the code
